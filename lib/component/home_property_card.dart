import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visko_rocky_flutter/component/inquiry_form.dart';

const Color kPrimaryOrange = Color(0xffF26A33);

class HomePropertyCard extends StatefulWidget {
  final Map property;
  final bool isDark;
  final VoidCallback onTap;

  const HomePropertyCard({
    super.key,
    required this.property,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<HomePropertyCard> createState() => _HomePropertyCardState();
}

class _HomePropertyCardState extends State<HomePropertyCard> {
  @override
  Widget build(BuildContext context) {
    final property = widget.property;

    // SAFE values
    final String title = property['property_name'] ?? "No Title";
    final String city = property['property_city'] ?? "Unknown";
    final List sqfts = property['property_sq_ft'] ?? [];
    final String sizeText =
        sqfts.isNotEmpty ? "${sqfts.join(', ')} sqft" : "0 sqft";

    final String type = property['property_type'] ?? "";
    final String category = property['property_category'] ?? "";

    final List images = property['property_images'] ?? [];
    final String imageUrl =
        images.isNotEmpty ? images[0] : "https://via.placeholder.com/300";

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: widget.isDark
                  ? Colors.white.withOpacity(0.06)
                  : Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.isDark ? Colors.white24 : Colors.orange.shade100,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isDark
                      ? Colors.black.withOpacity(0.35)
                      : kPrimaryOrange.withOpacity(0.30),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    /// IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        width: 125,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 115,
                          height: 95,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// TEXT SECTION
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE + ARROW
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              _glassIcon(
                                  widget.isDark, Icons.arrow_outward_rounded),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// CITY
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: kPrimaryOrange),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  city,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: widget.isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// SIZE
                          Row(
                            children: [
                              const Icon(Icons.square_foot,
                                  size: 16, color: kPrimaryOrange),
                              const SizedBox(width: 4),
                              Text(
                                sizeText,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// TYPE + CATEGORY
                          Row(
                            children: [
                              const Icon(Icons.villa,
                                  size: 14, color: kPrimaryOrange),
                              const SizedBox(width: 4),
                              Text(
                                type,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.category,
                                  size: 14, color: kPrimaryOrange),
                              const SizedBox(width: 4),
                              Text(
                                category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                /// ACTION BUTTONS
                Row(
                  children: [
                    /// INQUIRY BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => InquiryForm(
                                isDark: widget.isDark,
                                propertySlug: property['slug'] ?? "",
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

                    /// FAV ICON
                    _glassIcon(widget.isDark, Icons.favorite_border),

                    const SizedBox(width: 8),

                    /// SHARE
                    GestureDetector(
                      onTap: () {
                        Share.share(
                          "🏡 ${title}\n📍 $city\n🔗 $imageUrl",
                        );
                      },
                      child: _glassIcon(widget.isDark, Icons.share),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// GLASS ICON
  Widget _glassIcon(bool isDark, IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(
                color: isDark ? Colors.white24 : Colors.orange.shade200),
          ),
          child: Icon(
            icon,
            size: 18,
            color: isDark ? Colors.white : kPrimaryOrange,
          ),
        ),
      ),
    );
  }
}

// this is perfect my glass theme card and you collect this color code and replace my lib/theme/app_theme.dart code and give me full code and i give my theme/app_theme.dart code this is
