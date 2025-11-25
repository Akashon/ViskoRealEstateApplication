// property_detail_page.dart
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';

const Color kPrimaryOrange = Color(0xffF26A33);

class PropertyDetailPage extends StatefulWidget {
  final String slug;
  const PropertyDetailPage({required this.slug, super.key});

  @override
  _PropertyDetailPageState createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends State<PropertyDetailPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  Map<String, dynamic>? property;
  int activeIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController();

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    fetchPropertyDetails();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchPropertyDetails() async {
    final url =
        'https://apimanager.viskorealestate.com/fetch-property-full-details?slug=${widget.slug}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == true) {
          setState(() {
            property = Map<String, dynamic>.from(result['data'] ?? {});
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            property = null;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          property = null;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        property = null;
      });
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
    final isDark = themeController.isDark.value;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : property == null
          ? const Center(child: Text("Property not found"))
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- IMAGE BANNER (Full image banner + glass overlay) ----------
                      Stack(
                        children: [
                          SizedBox(
                            height: 340,
                            child: GestureDetector(
                              onTap: () => openFullScreenImage(
                                _getImageAtIndex(activeIndex),
                              ),
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: _imagesLength(),
                                onPageChanged: (index) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                },
                                itemBuilder: (_, index) {
                                  final img = _getImageAtIndex(index);
                                  return Container(
                                    color: isDark
                                        ? Colors.black
                                        : Colors.grey.shade200,
                                    child: Image.network(
                                      img,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                            if (progress == null) return child;
                                            return Container(
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.grey.shade200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: isDark
                                                  ? Colors.black
                                                  : Colors.grey.shade200,
                                              child: const Center(
                                                child: Icon(Icons.broken_image),
                                              ),
                                            );
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // subtle dark gradient at bottom for readability
                          // Positioned(
                          //   bottom: 0,
                          //   left: 0,
                          //   right: 0,
                          //   child: Container(
                          //     height: 120,
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         begin: Alignment.topCenter,
                          //         end: Alignment.bottomCenter,
                          //         colors: [
                          //           Colors.transparent,
                          //           (isDark
                          //                   ? Colors.black.withOpacity(0.55)
                          //                   : Colors.black.withOpacity(0.28))
                          //               .withOpacity(1),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // page indicator - centered bottom
                          Positioned(
                            bottom: 18,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: AnimatedSmoothIndicator(
                                activeIndex: activeIndex,
                                count: _imagesLength(),
                                effect: ExpandingDotsEffect(
                                  activeDotColor: kPrimaryOrange,
                                  dotColor: isDark
                                      ? Colors.white24
                                      : Colors.white70,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                ),
                              ),
                            ),
                          ),

                          // Top left / right glass circle buttons
                          Positioned(
                            top: 18,
                            left: 14,
                            child: glassCircle(
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                              isDark: isDark,
                            ),
                          ),
                          Positioned(
                            top: 18,
                            right: 16,
                            child: Row(
                              children: [
                                glassCircle(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.share,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      // TODO: share
                                    },
                                  ),
                                  isDark: isDark,
                                ),
                                const SizedBox(width: 8),
                                glassCircle(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      // TODO: favorite
                                    },
                                  ),
                                  isDark: isDark,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Thumbnails row with subtle glass border
                      SizedBox(
                        height: 76,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: _imagesLength(),
                          itemBuilder: (context, index) {
                            final imageUrl = _getImageAtIndex(index);
                            final isActive = activeIndex == index;
                            return GestureDetector(
                              onTap: () {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 8,
                                ),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isActive
                                        ? kPrimaryOrange
                                        : (isDark
                                              ? Colors.white12
                                              : Colors.transparent),
                                    width: isActive ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    if (!isDark)
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                  ],
                                  color: isDark
                                      ? Colors.white24.withOpacity(
                                          isActive ? 0.04 : 0.02,
                                        )
                                      : Colors.white,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: 64,
                                    height: 64,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 64,
                                      height: 64,
                                      color: isDark
                                          ? Colors.grey[900]
                                          : Colors.grey[200],
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Tag + basic info row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            _smallTag(
                              property?['property_type']?.toString() ?? '',
                              isDark: isDark,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.square_foot,
                              size: 18,
                              color: kPrimaryOrange,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _sqftText(),
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Title & address
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              property?['property_name']?.toString() ??
                                  'No title',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: isDark
                                      ? Colors.white70
                                      : kPrimaryOrange,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    property?['property_address']?.toString() ??
                                        '',
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Tab bar styled to match glass look
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isDark
                                ? Colors.white.withOpacity(0.02)
                                : Colors.white.withOpacity(0.75),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade200,
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: kPrimaryOrange,
                            unselectedLabelColor: isDark
                                ? Colors.white54
                                : Colors.grey,
                            indicatorColor: kPrimaryOrange,
                            indicatorWeight: 3,
                            tabs: const [
                              Tab(text: 'About'),
                              Tab(text: 'Gallery'),
                              Tab(text: 'Review'),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 260,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // ABOUT
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Tag(property!['property_category'] ?? ''),
                                      const SizedBox(width: 8),
                                      Tag(
                                        property!['property_subcategory'] ?? '',
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    property?['property_description']
                                            ?.toString() ??
                                        'No description available.',
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            // GALLERY
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _imagesLength(),
                                itemBuilder: (context, index) {
                                  final img = _getImageAtIndex(index);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => openFullScreenImage(img),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          img,
                                          width: 180,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // REVIEW
                            Center(
                              child: Text(
                                "No reviews available.",
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Developer info (glass card)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isDark
                                ? Colors.white.withOpacity(0.03)
                                : Colors.white.withOpacity(0.9),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white12
                                  : Colors.grey.shade200,
                            ),
                            boxShadow: [
                              if (!isDark)
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Developer",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: isDark
                                        ? Colors.white12
                                        : Colors.grey.shade200,
                                    child: Icon(
                                      Icons.person,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      property?['developer_name']?.toString() ??
                                          'Unknown',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // view developer
                                    },
                                    child: Text(
                                      "View",
                                      style: TextStyle(color: kPrimaryOrange),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Amenities title + chips
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Amenities",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12,
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _amenityChips(isDark),
                        ),
                      ),

                      SizedBox(height: 140), // space for bottom booking bar
                    ],
                  ),
                ),

                // BOTTOM BOOKING BAR - glass style (fixed)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.04)
                                  : Colors.white,
                              border: Border.all(
                                color: isDark
                                    ? Colors.white12
                                    : Colors.grey.shade200,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black.withOpacity(0.6)
                                      : Colors.black12,
                                  offset: const Offset(0, -2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (_) =>
                                    //       _buildInquiryDialog(isDark),
                                    // );
                                    showDialog(
                                      context: context,
                                      builder: (_) => InquiryForm(
                                        isDark: isDark,
                                        propertySlug: widget.slug,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryOrange,
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    "INQUIRY",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // ----------------------------
  // Helpers & small widgets
  // ----------------------------

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
      if (list == null || list.isEmpty) {
        return 'https://via.placeholder.com/600x400';
      }
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

  String _priceText() {
    try {
      final price = property?['property_price'] ?? property?['price'] ?? '';
      if (price == null || price.toString().isEmpty) return 'Price on request';
      return price.toString();
    } catch (_) {
      return 'Price on request';
    }
  }

  Widget glassCircle({required Widget child, required bool isDark}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: isDark ? Colors.white12 : Colors.grey.shade300,
            ),
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _smallTag(String title, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.white.withOpacity(0.9),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.villa, size: 14, color: kPrimaryOrange),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
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
        lower.contains("m²"))
      return Icons.square_foot;
    return Icons.check_circle_outline;
  }

  List<Widget> _amenityChips(bool isDark) {
    final List amenities = (property?['property_amenities'] as List?) ?? [];
    return amenities.map<Widget>((a) {
      final label = a?.toString() ?? '';
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isDark ? Colors.white12 : Colors.grey.shade100,
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.grey.shade200,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getAmenityIcon(label),
              size: 14,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

// Tag widget (small chip used in details)
class Tag extends StatelessWidget {
  final String label;
  const Tag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDark.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.06) : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isDark ? Colors.white12 : Colors.transparent),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 15.0,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Full screen image viewer
class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;
  const FullScreenImageViewer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeController>().isDark.value;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
