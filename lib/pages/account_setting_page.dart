// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../theme/app_theme.dart';
// import '../controller/theme_controller.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ThemeController themeController = Get.find<ThemeController>();

//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final glass = Theme.of(context).extension<GlassColors>()!;

//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             "Settings",
//             style: TextStyle(
//               color: glass.textPrimary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () => themeController.toggleTheme(),
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: Icon(
//                   isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SafeArea(
//           child: ListView(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.05,
//               vertical: 20,
//             ),
//             children: [
//               /// --- Profile Section ---
//               Center(
//                 child: glassAvatar(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500',
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Profile Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Full Name", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Email Address", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Phone Number", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(
//                 hint: "Password",
//                 glass: glass,
//                 obscureText: true,
//               ),

//               SizedBox(height: 30),

//               /// --- App Settings Section ---
//               Text(
//                 "App Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "Enable Notifications",
//                 glass: glass,
//                 value: true.obs,
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "Enable Dark Mode",
//                 glass: glass,
//                 value: themeController.isDark,
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "App Sounds",
//                 glass: glass,
//                 value: true.obs,
//               ),

//               SizedBox(height: 30),

//               /// --- Account Settings Section ---
//               Text(
//                 "Account Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Change Email", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(
//                 hint: "Change Password",
//                 glass: glass,
//                 obscureText: true,
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Two-Factor Authentication", glass: glass),

//               SizedBox(height: 40),

//               /// --- Save Button ---
//               _glassButton("Save All Changes", glass: glass, isDark: isDark),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   /// --- Reusable Glass Widgets ---

//   // Avatar
//   Widget glassAvatar({required String imageUrl}) {
//     final glass = Theme.of(Get.context!).extension<GlassColors>()!;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//         child: Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: glass.glassBackground,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: CircleAvatar(
//             radius: 45,
//             backgroundImage: NetworkImage(imageUrl),
//           ),
//         ),
//       ),
//     );
//   }

//   // TextField
//   Widget _glassTextField({
//     required String hint,
//     required GlassColors glass,
//     bool obscureText = false,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           height: 50,
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: TextField(
//             obscureText: obscureText,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: glass.textSecondary, fontSize: 14),
//               border: InputBorder.none,
//             ),
//             style: TextStyle(color: glass.textPrimary),
//           ),
//         ),
//       ),
//     );
//   }

//   // Button
//   Widget _glassButton(
//     String text, {
//     required GlassColors glass,
//     required bool isDark,
//   }) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         height: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           gradient: LinearGradient(
//             colors: [
//               glass.chipSelectedGradientStart,
//               glass.chipSelectedGradientEnd,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isDark
//                   ? Colors.black.withOpacity(0.4)
//                   : Colors.orange.withOpacity(0.25),
//               blurRadius: 12,
//               offset: Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Toggle Tile
//   Widget _glassToggleTile({
//     required String title,
//     required RxBool value,
//     required GlassColors glass,
//   }) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(50),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           height: 55,
//           decoration: BoxDecoration(
//             color: glass.cardBackground,
//             borderRadius: BorderRadius.circular(50),
//             border: Border.all(color: glass.glassBorder),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Obx(
//                 () => Switch(
//                   value: value.value,
//                   onChanged: (v) => value.value = v,
//                   activeColor: glass.chipSelectedGradientStart,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../theme/app_theme.dart';
// import '../controller/theme_controller.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     final ThemeController themeController = Get.find<ThemeController>();

//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final glass = Theme.of(context).extension<GlassColors>()!;

//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           title: Text(
//             "Settings",
//             style: TextStyle(
//               color: glass.textPrimary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           actions: [
//             GestureDetector(
//               onTap: () => themeController.toggleTheme(),
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: SafeArea(
//           child: ListView(
//             padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.05,
//               vertical: 20,
//             ),
//             children: [
//               /// --- Profile Section ---
//               Center(
//                 child: glassAvatar(
//                   imageUrl:
//                       'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500',
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Profile Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Full Name", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Email Address", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Phone Number", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(
//                 hint: "Password",
//                 glass: glass,
//                 obscureText: true,
//               ),
//               SizedBox(height: 30),

//               /// --- App Settings Section ---
//               Text(
//                 "App Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "Enable Notifications",
//                 glass: glass,
//                 value: true.obs,
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "Enable Dark Mode",
//                 glass: glass,
//                 value: themeController.isDark,
//               ),
//               SizedBox(height: 15),
//               _glassToggleTile(
//                 title: "App Sounds",
//                 glass: glass,
//                 value: true.obs,
//               ),
//               SizedBox(height: 30),

//               /// --- Account Settings Section ---
//               Text(
//                 "Account Settings",
//                 style: TextStyle(
//                   color: glass.textPrimary,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Change Email", glass: glass),
//               SizedBox(height: 15),
//               _glassTextField(
//                 hint: "Change Password",
//                 glass: glass,
//                 obscureText: true,
//               ),
//               SizedBox(height: 15),
//               _glassTextField(hint: "Two-Factor Authentication", glass: glass),
//               SizedBox(height: 30),

//               /// Save Button
//               _glassButton("Save All Changes", glass: glass, isDark: isDark),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

// /// --- Reusable Glass Widgets ---

// Widget glassAvatar({required String imageUrl}) {
//   final glass = Theme.of(Get.context!).extension<GlassColors>()!;
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//       child: Container(
//         padding: const EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: glass.glassBackground,
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: CircleAvatar(
//           radius: 45,
//           backgroundImage: NetworkImage(imageUrl),
//         ),
//       ),
//     ),
//   );
// }

// Widget _glassTextField({
//   required String hint,
//   required GlassColors glass,
//   bool obscureText = false,
// }) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         height: 50,
//         decoration: BoxDecoration(
//           color: glass.cardBackground,
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: glass.textSecondary, fontSize: 14),
//             border: InputBorder.none,
//           ),
//           style: TextStyle(color: glass.textPrimary),
//         ),
//       ),
//     ),
//   );
// }

// Widget _glassButton(
//   String text, {
//   required GlassColors glass,
//   required bool isDark,
// }) {
//   return GestureDetector(
//     onTap: () {},
//     child: Container(
//       height: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         gradient: LinearGradient(
//           colors: [
//             glass.chipSelectedGradientStart,
//             glass.chipSelectedGradientEnd,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withOpacity(0.4)
//                 : Colors.orange.withOpacity(0.25),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget _glassToggleTile({
//   required String title,
//   required RxBool value,
//   required GlassColors glass,
// }) {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         height: 55,
//         decoration: BoxDecoration(
//           color: glass.cardBackground,
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(color: glass.glassBorder),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 color: glass.textPrimary,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Obx(
//               () => Switch(
//                 value: value.value,
//                 onChanged: (v) => value.value = v,
//                 activeColor: glass.chipSelectedGradientStart,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../controller/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final glass = Theme.of(context).extension<GlassColors>()!;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(
              color: glass.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => themeController.toggleTheme(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: glass.textPrimary,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              // ---------------- Profile Avatar ----------------
              Center(
                child: _glassAvatar(
                  imageUrl:
                      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500",
                  glass: glass,
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- Profile Settings ----------------
              sectionTitle("Profile Settings", glass),
              const SizedBox(height: 15),

              _glassInput("Full Name", glass),
              const SizedBox(height: 15),
              _glassInput("Email", glass),
              const SizedBox(height: 15),
              _glassInput("Phone Number", glass),
              const SizedBox(height: 15),
              _glassInput("Password", glass, obscure: true),

              const SizedBox(height: 35),

              // ---------------- App Settings ----------------
              sectionTitle("App Settings", glass),
              const SizedBox(height: 15),

              _glassSwitch("Enable Notifications", true.obs, glass),
              const SizedBox(height: 15),

              _glassSwitch("Enable Dark Mode", themeController.isDark, glass),
              const SizedBox(height: 15),

              _glassSwitch("App Sounds", true.obs, glass),

              const SizedBox(height: 35),

              // ---------------- Account Settings ----------------
              sectionTitle("Account Settings", glass),
              const SizedBox(height: 15),

              _glassInput("Change Email", glass),
              const SizedBox(height: 15),
              _glassInput("Change Password", glass, obscure: true),
              const SizedBox(height: 15),
              _glassInput("Two-Factor Authentication", glass),

              const SizedBox(height: 35),

              // ---------------- Save Button ----------------
              _glassButton(
                text: "Save All Changes",
                glass: glass,
                isDark: isDark,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    });
  }

  // ===============================================================
  // Reusable Widgets
  // ===============================================================

  Widget sectionTitle(String title, GlassColors glass) {
    return Text(
      title,
      style: TextStyle(
        color: glass.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _glassAvatar({
    required String imageUrl,
    required GlassColors glass,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: glass.glassBackground,
            borderRadius: BorderRadius.circular(60),
            border: Border.all(color: glass.glassBorder),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }

  Widget _glassInput(
    String hint,
    GlassColors glass, {
    bool obscure = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: glass.glassBorder),
          ),
          child: TextField(
            obscureText: obscure,
            style: TextStyle(color: glass.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: glass.textSecondary,
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _glassSwitch(
    String title,
    RxBool value,
    GlassColors glass,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            border: Border.all(color: glass.glassBorder),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: glass.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Obx(
                () => Switch(
                  value: value.value,
                  activeColor: glass.chipSelectedGradientStart,
                  onChanged: (v) => value.value = v,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassButton({
    required String text,
    required GlassColors glass,
    required bool isDark,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            glass.chipSelectedGradientStart,
            glass.chipSelectedGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.35)
                : Colors.orange.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
