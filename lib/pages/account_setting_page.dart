import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:visko_rocky_flutter/pages/Setting/contact_information_page.dart';
import 'package:visko_rocky_flutter/pages/Setting/personal_info_page.dart';
import 'package:visko_rocky_flutter/pages/Setting/property_advisor_page.dart';
import 'package:visko_rocky_flutter/pages/Setting/support_bottom_sheet.dart';
import 'package:visko_rocky_flutter/pages/Setting/legal_webview_page.dart';

import '../theme/app_theme.dart';
import '../controller/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                color: glass.textPrimary,
              ),
              onPressed: themeController.toggleTheme,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            /// PROFILE HEADER
            _profileHeader(glass),
            const SizedBox(height: 30),

            /// PERSONAL INFORMATION
            _sectionCard(
              glass,
              title: "Personal Information",
              children: [
                _settingTile(
                  glass,
                  Icons.person,
                  "View & Edit Personal Info",
                  onTap: () => Get.to(() => const PersonalInfoPage()),
                ),
              ],
            ),

            /// CONTACT INFORMATION
            _sectionCard(
              glass,
              title: "Contact Information",
              children: [
                _settingTile(
                  glass,
                  Icons.phone,
                  "Mobile Number & Email",
                  onTap: () => Get.to(() => const ContactInformationPage()),
                ),
              ],
            ),

            /// APP SETTINGS
            _sectionCard(
              glass,
              title: "App Settings",
              children: [
                _switchTile(
                  glass,
                  title: "Notifications",
                  icon: Icons.notifications_active,
                  value: true.obs,
                ),
                _switchTile(
                  glass,
                  title: "Dark Mode",
                  icon: Icons.dark_mode,
                  value: themeController.isDark,
                ),
              ],
            ),

            /// SUPPORT
            _sectionCard(
              glass,
              title: "Contact Support",
              children: [
                _settingTile(
                  glass,
                  Icons.support_agent,
                  "Email • Call • WhatsApp",
                  onTap: () => SupportBottomSheet.show(context),
                ),
              ],
            ),

            /// PROPERTY ADVISOR
            _sectionCard(
              glass,
              title: "Talk to Property Advisor",
              children: [
                _settingTile(
                  glass,
                  Icons.chat_bubble_outline,
                  "Schedule Call or Chat",
                  onTap: () => Get.to(() => const PropertyAdvisorPage()),
                ),
              ],
            ),

            /// TERMS & PRIVACY
            _sectionCard(
              glass,
              title: "Terms & Privacy",
              children: [
                _settingTile(
                  glass,
                  Icons.privacy_tip,
                  "Privacy Policy",
                  onTap: () => Get.to(
                    () => const LegalWebViewPage(
                      title: "Privacy Policy",
                      url: "https://yourdomain.com/privacy-policy",
                    ),
                  ),
                ),
                _settingTile(
                  glass,
                  Icons.cookie,
                  "Cookies Policy",
                  onTap: () => Get.to(
                    () => const LegalWebViewPage(
                      title: "Cookies Policy",
                      url: "https://yourdomain.com/cookies-policy",
                    ),
                  ),
                ),
                _settingTile(
                  glass,
                  Icons.description,
                  "Terms & Conditions",
                  onTap: () => Get.to(
                    () => const LegalWebViewPage(
                      title: "Terms & Conditions",
                      url: "https://yourdomain.com/terms",
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      );
    });
  }

  // ===============================================================
  // WIDGETS
  // ===============================================================

  Widget _profileHeader(GlassColors glass) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            border: Border.all(color: glass.glassBorder),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500",
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Akash Visko",
                    style: TextStyle(
                      color: glass.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "View & edit profile",
                    style: TextStyle(
                      color: glass.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(
    GlassColors glass, {
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: glass.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: glass.cardBackground,
                  border: Border.all(color: glass.glassBorder),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(children: children),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingTile(
    GlassColors glass,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: glass.textPrimary),
      title: Text(
        title,
        style: TextStyle(color: glass.textPrimary, fontSize: 14),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 14, color: glass.textSecondary),
    );
  }

  Widget _switchTile(
    GlassColors glass, {
    required String title,
    required IconData icon,
    required RxBool value,
  }) {
    return Obx(
      () => ListTile(
        leading: Icon(icon, color: glass.textPrimary),
        title: Text(
          title,
          style: TextStyle(color: glass.textPrimary, fontSize: 14),
        ),
        trailing: Switch(
          value: value.value,
          activeColor: glass.chipSelectedGradientStart,
          onChanged: (v) => value.value = v,
        ),
      ),
    );
  }
}
