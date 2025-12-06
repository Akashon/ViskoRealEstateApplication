// THIS IS MY MAIN CODE FOR A HOME PROPERTY CARD WITH FAVORITE API INTEGRATION

// i want to make this card in it if api is loading then card design same placeholder loading design show like shimmer effect how can i do that? please update the code accordingly
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

const String baseURL = "https://apimanager.viskorealestate.com";

class HomePropertyCard extends StatefulWidget {
  final Map property;
  final bool isDark;
  final VoidCallback onTap;

  /// This callback removes the card from Favorite List page
  final VoidCallback? onFavoriteRemoved;

  const HomePropertyCard({
    super.key,
    required this.property,
    required this.isDark,
    required this.onTap,
    this.onFavoriteRemoved,
  });

  @override
  State<HomePropertyCard> createState() => _HomePropertyCardState();
}

class _HomePropertyCardState extends State<HomePropertyCard>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  bool loadingFav = false;

  // small press animation
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  /// 🔍 Check if THIS property is already in user's favorites
  Future<void> checkFavoriteStatus() async {
    try {
      final response = await http.get(Uri.parse("$baseURL/favorites/user"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List favList = [];
        if (data['favorite_properties'] != null) {
          favList = data['favorite_properties'];
        } else if (data['favorites'] != null) {
          favList = data['favorites'];
        } else if (data['data'] != null) {
          favList = data['data'];
        }

        final id = widget.property['property_id'];

        setState(() {
          isFavorite = favList
              .any((item) => item['property_id'].toString() == id.toString());
        });
      }
    } catch (e) {
      // silent fail - leave isFavorite as is
      debugPrint("Error fetching favorites: $e");
    }
  }

  /// ❤️ Toggle Add / Remove From Favorites
  Future<void> toggleFavorite() async {
    if (loadingFav) return;
    setState(() {
      loadingFav = true;
      // optimistic UI update
      isFavorite = !isFavorite;
    });

    final propertyId = widget.property['property_id'];
    final url = isFavorite
        ? "$baseURL/api/favorites/add"
        : "$baseURL/api/favorites/remove";

    try {
      final response =
          await http.post(Uri.parse(url), body: {"property_id": "$propertyId"});

      // if failure, rollback optimistic update
      if (response.statusCode != 200) {
        setState(() => isFavorite = !isFavorite);
      } else {
        // If removed AND card is shown in Favorite List
        if (!isFavorite && widget.onFavoriteRemoved != null) {
          // delay a tiny bit for animation smoothness
          await Future.delayed(const Duration(milliseconds: 150));
          widget.onFavoriteRemoved!();
        }
      }
    } catch (e) {
      debugPrint("Favorite Toggle Exception: $e");
      setState(() => isFavorite = !isFavorite);
    } finally {
      if (mounted) {
        setState(() => loadingFav = false);
      }
    }
  }

  void _onTapDown(_) {
    setState(() => _scale = 0.985);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;
    final property = widget.property;

    final String title = property['property_name'] ?? "No Title";
    final String city = property['property_city'] ?? "Unknown";

    dynamic sqftData = property['property_sq_ft'];
    List sqfts = [];
    if (sqftData is int) {
      sqfts = [sqftData];
    } else if (sqftData is List) {
      sqfts = sqftData;
    }
    final sizeText = sqfts.isNotEmpty ? "${sqfts.join(', ')} sqft" : "0 sqft";

    final String type = property['property_type'] ?? "";
    final String category = property['property_category'] ?? "";

    final List images = property['property_images'] ?? [];
    final String? imageUrl = images.isNotEmpty ? images[0] : null;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                // use cardBackground from theme extension
                color: glass.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: glass.glassBorder,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.45)
                        : primary.withOpacity(0.12),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    glass.glassBackground,
                    glass.cardBackground,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 148,
                          height: 120,
                          color: glass.chipUnselectedStart.withOpacity(0.15),
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  width: 128,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _fallbackImage(glass),
                                )
                              : _fallbackImage(glass),
                        ),
                      ),

                      const SizedBox(width: 14),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title + launch icon
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: glass.textPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _glassCircleIcon(
                                  icon: Icons.open_in_new_rounded,
                                  glass: glass,
                                  primary: primary,
                                  tooltip: "View details",
                                  onTap: () => widget.onTap(),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Location
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    size: 14, color: primary),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    city,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: glass.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // Sqft row
                            Row(
                              children: [
                                Icon(Icons.square_foot,
                                    size: 16, color: primary),
                                const SizedBox(width: 6),
                                Text(
                                  sizeText,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: glass.textSecondary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // Type & Category
                            Row(
                              children: [
                                Icon(Icons.villa, size: 14, color: primary),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(type,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: glass.textSecondary,
                                      )),
                                ),
                                const SizedBox(width: 12),
                                // Icon(Icons.category, size: 14, color: primary),
                                // const SizedBox(width: 6),
                                // Flexible(
                                //   child: Text(category,
                                //       style: TextStyle(
                                //         fontSize: 12,
                                //         color: glass.textSecondary,
                                //       )),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 34,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryOrange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => InquiryForm(
                                  isDark: widget.isDark,
                                  propertySlug: property['slug'] ?? "",
                                  propertyName: null,
                                  propertyData: null,
                                ),
                              );
                            },
                            child: const Text(
                              "Inquiry Now",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),

                      /// ❤️ Favorite + Share
                      Row(
                        children: [
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: isFavorite
                                    ? LinearGradient(
                                        colors: [
                                          glass.chipSelectedGradientStart,
                                          glass.chipSelectedGradientEnd,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color:
                                    isFavorite ? null : glass.glassBackground,
                                border: Border.all(
                                  color: glass.glassBorder,
                                ),
                                boxShadow: [
                                  if (isFavorite)
                                    BoxShadow(
                                      color: glass.chipSelectedGradientStart
                                          .withOpacity(0.18),
                                      blurRadius: 10,
                                      offset: const Offset(0, 6),
                                    )
                                  else
                                    BoxShadow(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black.withOpacity(0.25)
                                          : primary.withOpacity(0.06),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    )
                                ],
                              ),
                              child: loadingFav
                                  ? SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        valueColor:
                                            AlwaysStoppedAnimation(primary),
                                      ),
                                    )
                                  : AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 260),
                                      transitionBuilder: (child, animation) =>
                                          ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                      child: Icon(
                                        key: ValueKey<bool>(isFavorite),
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color: isFavorite
                                            ? Colors.white
                                            : glass.chipSelectedGradientStart,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => Share.share("🏡 $title\n📍 $city\n🔗"),
                            child: _glassCircleIcon(
                              icon: Icons.share,
                              glass: glass,
                              primary: primary,
                              tooltip: "Share",
                              onTap: () => Share.share(
                                  "🏡 $title\n📍 $city\n🔗 ${property['slug'] ?? ''}"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Fallback local image
  Widget _fallbackImage(GlassColors glass) {
    return Container(
      width: 128,
      height: 110,
      color: glass.chipUnselectedStart,
      child: Center(
        child: Icon(Icons.broken_image, size: 36, color: glass.textSecondary),
      ),
    );
  }

  /// 🔹 Glass circular icon helper
  Widget _glassCircleIcon({
    required IconData icon,
    required GlassColors glass,
    required Color primary,
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
              decoration: BoxDecoration(
                color: glass.glassBackground,
                shape: BoxShape.circle,
                border: Border.all(color: glass.glassBorder),
              ),
              child: Icon(icon, size: 18, color: primary),
            ),
          ),
        ),
      ),
    );
  }
}
