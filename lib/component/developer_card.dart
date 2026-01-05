import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/pages/developer_properties.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import '../config/colors.dart';

class DeveloperCard extends StatelessWidget {
  final Map<String, dynamic> dev;

  const DeveloperCard(
      {super.key, required this.dev, required Null Function() onTap});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return GestureDetector(
      onTap: () {
        Get.to(() => DeveloperProperties(
              slug: dev['developer_slug'] ?? '',
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 6, right: 3),
        width: MediaQuery.of(context).size.width * 0.72,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: glass.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: glass.glassBorder, width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.45)
                          : Colors.orange.shade100.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: CachedNetworkImage(
                //     imageUrl:
                //         dev['developer_banner'] ?? dev['developer_logo'] ?? '',
                //     width: double.infinity,
                //     height: 150,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: (dev['developer_banner'] ??
                                dev['developer_logo'] ??
                                '')
                            .isNotEmpty
                        ? dev['developer_banner'] ?? dev['developer_logo']!
                        : 'https://via.placeholder.com/150', // fallback image
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),

            // Dark overlay for depth
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.10),
                    ],
                  ),
                ),
              ),
            ),

            // ⭐ Rating Badge
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: kPrimaryOrange,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: glass.glassBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      (dev['rating'] ?? "4.8").toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

            // Glass bottom panel
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: glass.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: glass.glassBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Developer name + city
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dev['developer_name'] ?? 'Developer Name',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: glass.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: 14, color: glass.textSecondary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      dev['developer_city'] ?? 'City',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: glass.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Type badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: glass.glassBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: glass.glassBorder),
                          ),
                          child: Text(
                            dev['developer_type'] ?? 'Builder',
                            style: TextStyle(
                              fontSize: 12,
                              color: kPrimaryOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
