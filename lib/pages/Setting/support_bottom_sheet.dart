import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBottomSheet {
  static void show(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final primary = Theme.of(context).primaryColor;

    Get.bottomSheet(
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: glass.glassBackground,
              border: Border.all(color: glass.glassBorder),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔹 Drag Handle
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: glass.textSecondary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Title
                Text(
                  "Contact Support",
                  style: TextStyle(
                    color: glass.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                // 🔹 Email Tile
                _supportTile(
                  glass,
                  primary: primary,
                  icon: Icons.email_outlined,
                  title: "Email Support",
                  subtitle: "support@visko.com",
                  onTap: () => _launchEmail("support@visko.com"),
                ),
                const SizedBox(height: 12),

                // 🔹 Phone Tile
                _supportTile(
                  glass,
                  primary: primary,
                  icon: Icons.phone_in_talk_outlined,
                  title: "Phone Support",
                  subtitle: "+91 98765 43210",
                  onTap: () => _launchPhone("+919876543210"),
                ),
                const SizedBox(height: 12),

                // 🔹 WhatsApp Tile
                // _supportTile(
                //   glass,
                //   primary: primary,
                //   icon: Icons.whatsapp,
                //   title: "WhatsApp Support",
                //   subtitle: "Chat instantly",
                //   onTap: () => _launchWhatsApp("+919876543210"),
                // ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // ================= SUPPORT TILE =================
  static Widget _supportTile(
    GlassColors glass, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primary,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: glass.cardBackground,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: glass.glassBorder),
            ),
            child: Row(
              children: [
                Icon(icon, color: primary, size: 22),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: glass.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
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
                  color: glass.textSecondary.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= LAUNCH METHODS =================

  static Future<void> _launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(uri)) {
      Get.snackbar(
        "Error",
        "Could not launch phone app",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: Uri.encodeFull('subject=Support Request&body=Hi Support,'),
    );
    if (!await launchUrl(uri)) {
      Get.snackbar(
        "Error",
        "Could not launch email app",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future<void> _launchWhatsApp(String phone) async {
    final Uri uri = Uri.parse("https://wa.me/$phone");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        "Error",
        "Could not open WhatsApp",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
