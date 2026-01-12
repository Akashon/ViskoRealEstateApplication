import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/config/colors.dart';
import 'package:visko_rocky_flutter/controller/favorite_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:open_filex/open_filex.dart';

class PropertyDetailPage extends StatefulWidget {
  final String slug;
  const PropertyDetailPage({
    required this.slug,
    super.key,
  });

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

final FavoriteController favCtrl = Get.find<FavoriteController>();
// final String propertyId = property!['property_id'].toString();

Future<void> downloadAndOpenPDF(String url) async {
  final glass = Theme.of(Get.context!).extension<GlassColors>()!;
  try {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/property_brochure.pdf');
      await file.writeAsBytes(res.bodyBytes, flush: true);
      await OpenFilex.open(file.path);
    } else {
      Get.snackbar(
        "Download Failed",
        "Could not download brochure",
        backgroundColor: glass.cardBackground,
        colorText: glass.textPrimary,
      );
    }
  } catch (_) {
    Get.snackbar(
      "Error",
      "Something went wrong",
      backgroundColor: glass.cardBackground,
      colorText: glass.textPrimary,
    );
  }
}

class _PropertyDetailPageState extends State<PropertyDetailPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  Map<String, dynamic>? property;
  int activeIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController();

  GlassColors get glassColors => Theme.of(context).extension<GlassColors>()!;
  Color get primary => Theme.of(context).primaryColor;

  @override
  void initState() {
    super.initState();
    fetchProperty();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchProperty() async {
    try {
      final res = await http.get(Uri.parse(
          'https://apimanager.viskorealestate.com/fetch-property-full-details?slug=${widget.slug}'));
      final data = json.decode(res.body);
      if (res.statusCode == 200 && data['status'] == true) {
        property = Map<String, dynamic>.from(data['data']);
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  void openFullScreenImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            )
          : property == null
              ? Center(
                  child: Text(
                    "Property not found",
                    style: TextStyle(color: glass.textSecondary),
                  ),
                )
              : SingleChildScrollView(
                  // padding: const EdgeInsets.only(bottom: 140),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ================= IMAGE BANNER =================
                      SizedBox(
                        height: 480,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _imagesLength(),
                              onPageChanged: (i) =>
                                  setState(() => activeIndex = i),
                              itemBuilder: (_, index) {
                                final img = _getImageAtIndex(index);
                                return GestureDetector(
                                  onTap: () => openFullScreenImage(img),
                                  child: Image.network(
                                    img,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: glass.cardBackground,
                                      child: Icon(Icons.broken_image,
                                          color: glass.textSecondary),
                                    ),
                                  ),
                                );
                              },
                            ),

                            /// Indicator
                            Positioned(
                              bottom: 18,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: activeIndex,
                                  count: _imagesLength(),
                                  effect: ExpandingDotsEffect(
                                    activeDotColor: primary,
                                    dotColor: glass.textSecondary,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                  ),
                                ),
                              ),
                            ),

                            /// Back
                            Positioned(
                              top: 40,
                              left: 14,
                              child: _glassCircleIcon(
                                icon: Icons.arrow_back_ios_new,
                                onTap: () => Navigator.pop(context),
                              ),
                            ),

                            /// Actions
                            Positioned(
                              top: 40,
                              right: 14,
                              child: Row(
                                children: [
                                  // _glassCircleIcon(
                                  //   icon: Icons.share,
                                  //   onTap: () {
                                  //     Share.share(
                                  //       property?['url'] ??
                                  //           'https://visko-realestate.com',
                                  //     );
                                  //   },
                                  // ),
                                  const SizedBox(width: 10),
                                  Obx(() {
                                    if (property == null)
                                      return const SizedBox();

                                    final String propertyId =
                                        property!['property_id'].toString();

                                    final bool isFav =
                                        favCtrl.isFavorite(propertyId);

                                    return GestureDetector(
                                      onTap: () =>
                                          favCtrl.toggleFavorite(property!),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 220),
                                        curve: Curves.easeOut,
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          // ✅ Theme gradient when selected
                                          gradient: isFav
                                              ? LinearGradient(
                                                  colors: [
                                                    glass
                                                        .chipSelectedGradientStart,
                                                    glass
                                                        .chipSelectedGradientEnd,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,

                                          // ✅ Theme background when not selected
                                          color: isFav
                                              ? null
                                              : glass.glassBackground,

                                          border: Border.all(
                                            color: isFav
                                                ? glass.chipSelectedGradientEnd
                                                : glass.glassBorder,
                                            width: 2.5,
                                          ),
                                        ),
                                        child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,

                                          // ✅ Theme-only icon colors
                                          color: isFav
                                              ? glass.solidSurface
                                              : glass.textSecondary,

                                          size: 20,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// ================= THUMBNAILS =================
                      SizedBox(
                        height: 76,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: _imagesLength(),
                          itemBuilder: (_, index) {
                            final imageUrl = _getImageAtIndex(index);
                            final isActive = activeIndex == index;
                            return GestureDetector(
                              onTap: () => _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 8),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color:
                                        isActive ? primary : glass.glassBorder,
                                    width: isActive ? 2 : 1,
                                  ),
                                  color: glass.cardBackground,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      /// ================= DETAILS =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property?['property_name'] ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: glass.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 14, color: primary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    property?['property_address'] ?? '',
                                    style: TextStyle(
                                      color: glass.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// ================= TABS =================
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: glass.cardBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: glass.glassBorder),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: primary,
                            unselectedLabelColor: glass.textSecondary,
                            indicatorColor: primary,
                            tabs: const [
                              Tab(text: 'About'),
                              Tab(text: 'Gallery'),
                              Tab(text: 'View Map'),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 260,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                property?['property_description'] ?? '',
                                style: TextStyle(
                                  color: glass.textSecondary,
                                ),
                              ),
                            ),
                            Center(
                              child: Text("Gallery",
                                  style: TextStyle(color: glass.textSecondary)),
                            ),
                            Center(
                              child: Text("Map",
                                  style: TextStyle(color: glass.textSecondary)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Amenities
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Amenities",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: glass.textPrimary),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _amenityChips(),
                        ),
                      ),

                      // FLOOR PLAN SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            Text(
                              "Floor Plans",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: glass.textPrimary, // uses your theme
                              ),
                            ),
                            const SizedBox(height: 8),

                            // List of floor plans
                            Column(
                              children: (property?['property_floor_plan']
                                          as List<dynamic>? ??
                                      [])
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final url = entry.value.toString();
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color:
                                      glass.chipUnselectedStart, // theme color

                                  margin:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  elevation: 2,
                                  child: ExpansionTile(
                                    iconColor: primary,
                                    collapsedIconColor:
                                        Theme.of(context).primaryColor,
                                    title: Text(
                                      "Map ${index + 1}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: glass.textPrimary,
                                      ),
                                    ),
                                    childrenPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    FullScreenImageViewer(
                                                        imageUrl: url)),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            url,
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              if (progress == null)
                                                return child;
                                              return Container(
                                                height: 180,
                                                color:
                                                    glass.chipUnselectedStart,
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              );
                                            },
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                              height: 180,
                                              color: glass.cardBackground,
                                              child: const Center(
                                                  child:
                                                      Icon(Icons.broken_image)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // PREMIUM BROCHURE SECTION
                      if (property?['property_brochure'] != null &&
                          property!['property_brochure'].toString().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Brochure",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: glass.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      property!['property_brochure'].toString();
                                  debugPrint("BROCHURE URL => $url");
                                  await downloadAndOpenPDF(url);
                                },
                                child: StatefulBuilder(
                                  builder: (context, setState) {
                                    bool isPressed = false;
                                    return Listener(
                                      onPointerDown: (_) =>
                                          setState(() => isPressed = true),
                                      onPointerUp: (_) =>
                                          setState(() => isPressed = false),
                                      child: AnimatedScale(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        scale: isPressed ? 0.97 : 1.0,
                                        curve: Curves.easeOutBack,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 15, sigmaY: 15),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: glass.glassBackground
                                                    .withOpacity(0.85),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: glass.glassBorder,
                                                  width: 1.2,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 16),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.15),
                                                    ),
                                                    child: Icon(
                                                      Icons.picture_as_pdf,
                                                      size: 28,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Text(
                                                      "Download Brochure",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            glass.textPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.15),
                                                    ),
                                                    child: Icon(
                                                      Icons.download,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                      // const SizedBox(height: 140),
                    ],
                  ),
                ),

      /// ================= FIXED BOTTOM BAR =================
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: glass.glassBackground,
                  border: Border.all(color: glass.glassBorder),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => InquiryForm(
                        propertySlug: widget.slug,
                        propertyName: null,
                        propertyData: null,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "INQUIRY",
                    style: TextStyle(
                      color: glass.solidSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------- HELPERS -----------------
  int _imagesLength() {
    try {
      final list = property?['property_images'] as List?;
      return list?.length ?? 0;
    } catch (_) {
      return 0;
    }
  }

  String _getImageAtIndex(int idx) {
    try {
      final list = property?['property_images'] as List?;
      if (list == null || list.isEmpty)
        return 'https://via.placeholder.com/600x400';
      return list[idx % list.length].toString();
    } catch (_) {
      return 'https://via.placeholder.com/600x400';
    }
  }

  String _sqftText() {
    try {
      final sq = property?['property_sq_ft'];
      if (sq is List) return '${sq.join(", ")} sqft';
      if (sq != null) return '$sq sqft';
      return '- sqft';
    } catch (_) {
      return '- sqft';
    }
  }

  IconData getAmenityIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains("bed")) return Icons.bed;
    if (lower.contains("bath")) return Icons.bathtub_outlined;
    if (lower.contains("pool")) return Icons.pool;
    if (lower.contains("wifi")) return Icons.wifi;
    if (lower.contains("park") || lower.contains("parking"))
      return Icons.local_parking;
    if (lower.contains("gym")) return Icons.fitness_center;
    if (lower.contains("garden")) return Icons.park;
    if (lower.contains("pet")) return Icons.pets;
    if (lower.contains("security")) return Icons.security;
    if (lower.contains("lift") || lower.contains("elevator"))
      return Icons.elevator;
    if (lower.contains("area") ||
        lower.contains("sqft") ||
        lower.contains("m²")) return Icons.square_foot;
    return Icons.check_circle_outline;
  }

// ---------------------- Glass Circle Icon ----------------------
  Widget _glassCircleIcon({
    required IconData icon,
    String? tooltip,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip ?? '',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: glassColors.glassBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: glassColors.glassBorder,
                ),
              ),
              child: Icon(
                icon,
                size: 18,
                color: glassColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

// ---------------------- Small Tag ----------------------
  Widget _smallTag(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: glassColors.cardBackground,
        border: Border.all(color: glassColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.villa, size: 14, color: Theme.of(context).primaryColor),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(color: glassColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

// ---------------------- Amenity Chips ----------------------
  List<Widget> _amenityChips() {
    final List amenities = (property?['property_amenities'] as List?) ?? [];
    return amenities.map<Widget>((a) {
      final label = a?.toString() ?? '';
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: glassColors.cardBackground,
          border: Border.all(color: glassColors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(getAmenityIcon(label),
                size: 14, color: glassColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: glassColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

// -------------------- TAG --------------------
class Tag extends StatelessWidget {
  final String label;
  const Tag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: glassColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: glassColors.glassBorder),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 15,
            color: glassColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: glassColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- FULL SCREEN IMAGE VIEWER --------------------
class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  const FullScreenImageViewer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: glassColors.textPrimary),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
            errorBuilder: (_, __, ___) =>
                Icon(Icons.broken_image, color: glassColors.textSecondary),
          ),
        ),
      ),
    );
  }
}

// -------------------- FLOOR PLAN PAGE --------------------
class FloorPlanPage extends StatefulWidget {
  final Map<String, dynamic> property;
  const FloorPlanPage({required this.property, super.key});

  @override
  _FloorPlanPageState createState() => _FloorPlanPageState();
}

class _FloorPlanPageState extends State<FloorPlanPage> {
  int activeIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final glassColors = Theme.of(context).extension<GlassColors>()!;
    final List<dynamic> floorPlans =
        widget.property['property_floor_plan'] ?? [];

    if (floorPlans.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: glassColors.textPrimary),
          elevation: 0,
          title: Text(
            "Floor Plan",
            style: TextStyle(color: glassColors.textPrimary),
          ),
        ),
        body: Center(
          child: Text(
            "No floor plans available.",
            style: TextStyle(color: glassColors.textSecondary),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: glassColors.textPrimary),
        elevation: 0,
        title: Text(
          "Floor Plan",
          style: TextStyle(color: glassColors.textPrimary),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: floorPlans.length,
              onPageChanged: (index) => setState(() => activeIndex = index),
              itemBuilder: (context, index) {
                final img = floorPlans[index].toString();
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullScreenImageViewer(imageUrl: img),
                      ),
                    );
                  },
                  child: Container(
                    color: glassColors.cardBackground,
                    child: Image.network(
                      img,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Icon(Icons.broken_image,
                          color: glassColors.textSecondary),
                    ),
                  ),
                );
              },
            ),
          ),

          // Page indicator
          if (floorPlans.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: floorPlans.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: glassColors.textSecondary,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
