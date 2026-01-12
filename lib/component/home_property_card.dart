// THIS IS MY MAIN CODE FOR A HOME PROPERTY CARD WITH FAVORITE API INTEGRATION

// i want to make this card in it if api is loading then card design same placeholder loading design show like shimmer effect how can i do that? please update the code accordingly
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/controller/favorite_controller.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

const String baseURL = "https://apimanager.viskorealestate.com";

class HomePropertyCard extends StatefulWidget {
  final Map property;
  final bool isDark;
  final VoidCallback onTap;
  const HomePropertyCard({
    super.key,
    required this.property,
    required this.isDark,
    required this.onTap,
    required image,
    // this.onFavoriteRemoved,
  });

  @override
  State<HomePropertyCard> createState() => _HomePropertyCardState();
}

class _HomePropertyCardState extends State<HomePropertyCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  final FavoriteController favCtrl = Get.find<FavoriteController>();

  void _onTapDown(_) {
    setState(() => _scale = 0.985);
  }

  void _onTapUp(_) {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    final String propertyId = property['property_id'].toString();

    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

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
                    color: glass.glassBorder.withOpacity(0.25),
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
                          color: glass.chipUnselectedStart,
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
                                // const SizedBox(width: 8),
                                // _glassCircleIcon(
                                //   icon: Icons.open_in_new_rounded,
                                //   glass: glass,
                                //   tooltip: "View details",
                                //   onTap: () => widget.onTap(),
                                // ),
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
                                Expanded(
                                  child: Text(
                                    sizeText,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: glass.textSecondary,
                                    ),
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
                                // backgroundColor: kPrimaryOrange,
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => InquiryForm(
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
                      const SizedBox(width: 12),

                      /// ❤️ Favorite + Share
                      Row(
                        children: [
                          // GestureDetector(
                          //   onTap: toggleFavorite,
                          //   child: Container(
                          //     padding: const EdgeInsets.all(7),
                          //     decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       gradient: isFavorite
                          //           ? LinearGradient(
                          //               colors: [
                          //                 glass.chipSelectedGradientStart,
                          //                 glass.chipSelectedGradientEnd
                          //               ],
                          //               begin: Alignment.topLeft,
                          //               end: Alignment.bottomRight,
                          //             )
                          //           : null,
                          //       color:
                          //           isFavorite ? null : glass.glassBackground,
                          //       border: Border.all(
                          //           color: glass.glassBorder, width: 2.5),
                          //     ),
                          //     child: loadingFav
                          //         ? SizedBox(
                          //             width: 20,
                          //             height: 20,
                          //             child: CircularProgressIndicator(
                          //               strokeWidth: 2,
                          //               valueColor:
                          //                   AlwaysStoppedAnimation(primary),
                          //             ),
                          //           )
                          //         : Icon(
                          //             isFavorite
                          //                 ? Icons.favorite
                          //                 : Icons.favorite_border,
                          //             color: isFavorite
                          //                 ? glass.solidSurface
                          //                 : glass.textSecondary,
                          //             size: 20,
                          //           ),
                          //   ),
                          // ),

                          Obx(() {
                            final isFav = favCtrl.isFavorite(propertyId);

                            return GestureDetector(
                              onTap: () => favCtrl.toggleFavorite(property),
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: isFav
                                      ? LinearGradient(
                                          colors: [
                                            glass.chipSelectedGradientStart,
                                            glass.chipSelectedGradientEnd,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: isFav ? null : glass.glassBackground,
                                  border: Border.all(
                                    color: glass.glassBorder,
                                    width: 2.5,
                                  ),
                                ),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav
                                      ? glass.solidSurface
                                      : glass.textSecondary,
                                  size: 20,
                                ),
                              ),
                            );
                          }),

                          // const SizedBox(width: 6),
                          // GestureDetector(
                          //   onTap: () => Share.share("🏡 $title\n📍 $city\n🔗"),
                          //   child: _glassCircleIcon(
                          //     icon: Icons.share,
                          //     glass: glass,
                          //     tooltip: "Share",
                          //     onTap: () => Share.share(
                          //         "🏡 $title\n📍 $city\n🔗 ${property['slug'] ?? ''}"),
                          //   ),
                          // ),
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

  Widget _glassCircleIcon({
    required IconData icon,
    required GlassColors glass,
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
                color: glass.glassBackground, // theme background
                shape: BoxShape.circle,
                border: Border.all(
                    color: glass.glassBorder, width: 2.5), // theme border
              ),
              child: Icon(
                icon,
                size: 18,
                color: glass.textPrimary, // theme text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
