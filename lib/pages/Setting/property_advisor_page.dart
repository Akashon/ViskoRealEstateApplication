import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class PropertyAdvisorPage extends StatelessWidget {
  const PropertyAdvisorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: const Text("Property Advisor"),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: glass.textPrimary,
          onPressed: () => Get.back(),
        ),
        title: const Text("Property Advisor"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _advisorCard(glass),
            const SizedBox(height: 30),
            _actionCard(
              glass,
              icon: Icons.schedule,
              title: "Schedule a Call",
              subtitle: "Choose a convenient time",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _actionCard(
              glass,
              icon: Icons.chat_bubble_outline,
              title: "Chat Now",
              subtitle: "Instant support from advisor",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // WIDGETS
  // ===============================================================

  Widget _advisorCard(GlassColors glass) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=400",
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rahul Sharma",
                      style: TextStyle(
                        color: glass.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Senior Property Advisor",
                      style: TextStyle(
                        color: glass.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "10+ years experience • Verified",
                      style: TextStyle(
                        color: glass.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCard(
    GlassColors glass, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: glass.cardBackground,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: glass.glassBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        glass.chipSelectedGradientStart,
                        glass.chipSelectedGradientEnd,
                      ],
                    ),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: glass.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: glass.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: glass.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
