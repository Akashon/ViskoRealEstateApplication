// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:visko_rocky_flutter/component/home_property_card.dart';
// // import 'package:visko_rocky_flutter/pages/account_page.dart';
// // import 'package:visko_rocky_flutter/pages/purchased_properties.dart';
// // import 'package:visko_rocky_flutter/pages/visited_properties.dart';
// // // Controller
// // class DashboardController extends GetxController {
// //   var purchasedProperties = 2.obs;
// //   var profileCompleted = 85.obs;
// //   var profileVisits = 234.obs;
// //   var totalInvestment = 1450000.obs;

// //   var growthPurchase = 10.obs;
// //   var growthProfile = 5.obs;
// //   var growthVisits = 8.obs;
// //   var growthInvestment = 12.obs;

// //   var repairInProgress = 23.obs;
// //   var awaitingRepair = 12.obs;
// // }

// // // Main Dashboard Page
// // class DashboardPage extends StatelessWidget {
// //   final DashboardController controller = Get.put(DashboardController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               _buildHeader(),

// //               const SizedBox(height: 20),

// //               // Summary Cards
// //               GridView.count(
// //                 crossAxisCount: 2,
// //                 crossAxisSpacing: 12,
// //                 mainAxisSpacing: 12,
// //                 shrinkWrap: true,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 childAspectRatio: 1.6,
// //                 children: [
// //                   _buildSummaryCard(
// //                     title: "Purchased Property",
// //                     amount: controller.purchasedProperties,
// //                     growth: controller.growthPurchase,
// //                     color: Colors.blue.shade50,
// //                     icon: Icons.home_work_outlined,
// //                     prefix: '',
// //                   ),
// //                   _buildSummaryCard(
// //                     title: "Profile Completion",
// //                     amount: controller.profileCompleted,
// //                     growth: controller.growthProfile,
// //                     color: Colors.orange.shade50,
// //                     icon: Icons.person,
// //                     suffix: '%',
// //                   ),
// //                   _buildSummaryCard(
// //                     title: "Profile Visits",
// //                     amount: controller.profileVisits,
// //                     growth: controller.growthVisits,
// //                     color: Colors.green.shade50,
// //                     icon: Icons.visibility,
// //                     prefix: '',
// //                   ),
// //                   _buildSummaryCard(
// //                     title: "Total Investment",
// //                     amount: controller.totalInvestment,
// //                     growth: controller.growthInvestment,
// //                     color: Colors.purple.shade50,
// //                     icon: Icons.attach_money,
// //                     prefix: '₹',
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 20),

// //               // Chart Placeholder
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: const [
// //                   Text(
// //                     "Quick Stats",
// //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                   ),
// //                   Icon(Icons.arrow_drop_down),
// //                 ],
// //               ),
// //               const SizedBox(height: 12),
// //               Container(
// //                 height: 180,
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.all(12),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(16),
// //                   color: Colors.grey.shade100,
// //                 ),
// //                 child: const Center(
// //                   child: Text(
// //                     "Chart Placeholder",
// //                     style: TextStyle(color: Colors.grey),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 20),

// //               // Navigation Buttons
// //               _buildNavButton(
// //                 title: "Visited Property",
// //                 icon: Icons.location_on,
// //                 onTap: () => Get.to(() => VisitedPropertiesPage()),
// //               ),
// //               const SizedBox(height: 12),
// //               _buildNavButton(
// //                 title: "Purchased Property",
// //                 icon: Icons.shopping_bag,
// //                 onTap: () => Get.to(() => PurchasedPropertiesPage()),
// //               ),
// //               const SizedBox(height: 12),
// //               _buildNavButton(
// //                 title: "Account",
// //                 icon: Icons.person,
// //                 onTap: () => Get.to(() => AccountPage()),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // Header
// //   Widget _buildHeader() {
// //     return Row(
// //       children: [
// //         const CircleAvatar(
// //           radius: 20,
// //           backgroundColor: kPrimaryOrange,
// //           child: Icon(Icons.dashboard, color: Colors.white),
// //         ),
// //         const SizedBox(width: 12),
// //         const Expanded(
// //           child: Text(
// //             "Good Morning, Rocky",
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: () {},
// //           icon: const Icon(Icons.notifications_outlined, color: kPrimaryOrange),
// //         ),
// //         IconButton(
// //           onPressed: () {},
// //           icon: const Icon(Icons.chat_bubble_outline, color: kPrimaryOrange),
// //         ),
// //       ],
// //     );
// //   }

// //   // Summary Card
// //   Widget _buildSummaryCard({
// //     required String title,
// //     required RxInt amount,
// //     required RxInt growth,
// //     required Color color,
// //     required IconData icon,
// //     String prefix = '',
// //     String suffix = '',
// //   }) {
// //     return Obx(
// //       () => Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: color,
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black12,
// //               blurRadius: 4,
// //               offset: Offset(0, 4),
// //             ),
// //           ],
// //           borderRadius: BorderRadius.circular(16),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 6),
// //             Text(
// //               title,
// //               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 6),
// //             Row(
// //               children: [
// //                 Icon(icon, size: 26, color: Colors.black54),
// //                 const SizedBox(width: 6),
// //                 Text(
// //                   "$prefix${amount.value}$suffix",
// //                   style: const TextStyle(
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 4),
// //             Text(
// //               "+${growth.value}%",
// //               style: const TextStyle(color: Colors.green, fontSize: 12),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Navigation Button
// //   Widget _buildNavButton({
// //     required String title,
// //     required IconData icon,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
// //         decoration: BoxDecoration(
// //           color: Colors.grey.shade100,
// //           borderRadius: BorderRadius.circular(14),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black12,
// //               blurRadius: 3,
// //               offset: Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon, size: 24, color: kPrimaryOrange),
// //             const SizedBox(width: 12),
// //             Text(
// //               title,
// //               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //             ),
// //             const Spacer(),
// //             const Icon(Icons.arrow_forward_ios, size: 16),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/account_setting_page.dart';
// import 'package:visko_rocky_flutter/pages/purchased_properties.dart';
// import 'package:visko_rocky_flutter/pages/visited_properties.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import '../config/colors.dart';

// // Controller
// class DashboardController extends GetxController {
//   var purchasedProperties = 2.obs;
//   var profileCompleted = 85.obs;
//   var profileVisits = 234.obs;
//   var totalInvestment = 1450000.obs;

//   var growthPurchase = 10.obs;
//   var growthProfile = 5.obs;
//   var growthVisits = 8.obs;
//   var growthInvestment = 12.obs;

//   var repairInProgress = 23.obs;
//   var awaitingRepair = 12.obs;
// }

// // Main Dashboard Page
// class DashboardPage extends StatelessWidget {
//   final DashboardController controller = Get.put(DashboardController());
//   final themeController = Get.find<ThemeController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final glass = Theme.of(context).extension<GlassColors>()!;

//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(glass),
//                 const SizedBox(height: 20),

//                 // Summary Cards
//                 GridView.count(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   childAspectRatio: 1.6,
//                   children: [
//                     _buildSummaryCard(
//                       title: "Purchased Property",
//                       amount: controller.purchasedProperties,
//                       growth: controller.growthPurchase,
//                       color: glass.glassBackground,
//                       icon: Icons.home_work_outlined,
//                       prefix: '',
//                     ),
//                     _buildSummaryCard(
//                       title: "Profile Completion",
//                       amount: controller.profileCompleted,
//                       growth: controller.growthProfile,
//                       color: glass.glassBackground,
//                       icon: Icons.person,
//                       suffix: '%',
//                     ),
//                     _buildSummaryCard(
//                       title: "Profile Visits",
//                       amount: controller.profileVisits,
//                       growth: controller.growthVisits,
//                       color: glass.glassBackground,
//                       icon: Icons.visibility,
//                       prefix: '',
//                     ),
//                     _buildSummaryCard(
//                       title: "Total Investment",
//                       amount: controller.totalInvestment,
//                       growth: controller.growthInvestment,
//                       color: glass.glassBackground,
//                       icon: Icons.attach_money,
//                       prefix: '₹',
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // Chart Placeholder
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Quick Stats",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     Icon(Icons.arrow_drop_down, color: glass.textPrimary),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   height: 180,
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: glass.glassBackground,
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Chart Placeholder",
//                       style: TextStyle(color: glass.textSecondary),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Navigation Buttons
//                 _buildNavButton(
//                   title: "Visited Property",
//                   icon: Icons.location_on,
//                   glass: glass,
//                   onTap: () => Get.to(() => VisitedPropertiesPage()),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildNavButton(
//                   title: "Purchased Property",
//                   icon: Icons.shopping_bag,
//                   glass: glass,
//                   onTap: () => Get.to(() => PurchasedPropertiesPage()),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildNavButton(
//                   title: "Account",
//                   icon: Icons.person,
//                   glass: glass,
//                   onTap: () => Get.to(() => SettingsPage()),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   // Header
//   Widget _buildHeader(GlassColors glass) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 20,
//           backgroundColor: kPrimaryOrange,
//           child: Icon(Icons.dashboard, color: Colors.white),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             "Good Morning, Rocky",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: glass.textPrimary,
//             ),
//           ),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.notifications_outlined, color: kPrimaryOrange),
//         ),
//         IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.chat_bubble_outline, color: kPrimaryOrange),
//         ),
//       ],
//     );
//   }

//   // Summary Card
//   Widget _buildSummaryCard({
//     required String title,
//     required RxInt amount,
//     required RxInt growth,
//     required Color color,
//     required IconData icon,
//     String prefix = '',
//     String suffix = '',
//   }) {
//     return Obx(
//       () => Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 4),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 6),
//             Text(
//               title,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 6),
//             Row(
//               children: [
//                 Icon(icon, size: 26, color: Colors.black54),
//                 const SizedBox(width: 6),
//                 Text(
//                   "$prefix${amount.value}$suffix",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(
//               "+${growth.value}%",
//               style: const TextStyle(color: Colors.green, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Navigation Button
//   Widget _buildNavButton({
//     required String title,
//     required IconData icon,
//     required GlassColors glass,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//         decoration: BoxDecoration(
//           color: glass.glassBackground,
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 3,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Icon(icon, size: 24, color: kPrimaryOrange),
//             const SizedBox(width: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: glass.textPrimary,
//               ),
//             ),
//             const Spacer(),
//             Icon(Icons.arrow_forward_ios, size: 16, color: glass.textPrimary),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/account_setting_page.dart';
// import 'package:visko_rocky_flutter/pages/purchased_properties.dart';
// import 'package:visko_rocky_flutter/pages/visited_properties.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class DashboardController extends GetxController {
//   var purchasedProperties = 2.obs;
//   var profileCompleted = 85.obs;
//   var profileVisits = 234.obs;
//   var totalInvestment = 1450000.obs;

//   var growthPurchase = 10.obs;
//   var growthProfile = 5.obs;
//   var growthVisits = 8.obs;
//   var growthInvestment = 12.obs;

//   var repairInProgress = 23.obs;
//   var awaitingRepair = 12.obs;
// }

// class DashboardPage extends StatelessWidget {
//   final DashboardController controller = Get.put(DashboardController());
//   final themeController = Get.find<ThemeController>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isDark = themeController.isDark.value;
//       final glass = Theme.of(context).extension<GlassColors>()!;

//       return Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildHeader(glass, isDark),
//                 const SizedBox(height: 20),

//                 // ✅ Summary Cards
//                 GridView.count(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   childAspectRatio: 1.6,
//                   children: [
//                     _buildSummaryCard(
//                       title: "Purchased Property",
//                       amount: controller.purchasedProperties,
//                       growth: controller.growthPurchase,
//                       icon: Icons.home_work_outlined,
//                       prefix: '',
//                       glass: glass,
//                     ),
//                     _buildSummaryCard(
//                       title: "Profile Completion",
//                       amount: controller.profileCompleted,
//                       growth: controller.growthProfile,
//                       icon: Icons.person,
//                       suffix: '%',
//                       glass: glass,
//                     ),
//                     _buildSummaryCard(
//                       title: "Profile Visits",
//                       amount: controller.profileVisits,
//                       growth: controller.growthVisits,
//                       icon: Icons.visibility,
//                       prefix: '',
//                       glass: glass,
//                     ),
//                     _buildSummaryCard(
//                       title: "Total Investment",
//                       amount: controller.totalInvestment,
//                       growth: controller.growthInvestment,
//                       icon: Icons.attach_money,
//                       prefix: '₹',
//                       glass: glass,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Chart Card
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Quick Stats",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: glass.textPrimary,
//                       ),
//                     ),
//                     Icon(Icons.arrow_drop_down, color: glass.textPrimary),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                     child: Container(
//                       height: 180,
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: glass.cardBackground,
//                         border: Border.all(color: glass.glassBorder),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Chart Placeholder",
//                           style: TextStyle(color: glass.textSecondary),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ✅ Navigation Buttons
//                 _buildNavButton(
//                   title: "Visited Property",
//                   icon: Icons.location_on,
//                   glass: glass,
//                   onTap: () => Get.to(() => VisitedPropertiesPage()),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildNavButton(
//                   title: "Purchased Property",
//                   icon: Icons.shopping_bag,
//                   glass: glass,
//                   onTap: () => Get.to(() => PurchasedPropertiesPage()),
//                 ),
//                 const SizedBox(height: 12),
//                 _buildNavButton(
//                   title: "Account",
//                   icon: Icons.person,
//                   glass: glass,
//                   onTap: () => Get.to(() => SettingsPage()),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   // ✅ Header
//   Widget _buildHeader(GlassColors glass, bool isDark) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 22,
//           backgroundColor: Theme.of(Get.context!).primaryColor,
//           child: Icon(Icons.dashboard, color: Colors.white),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(
//             "Good Morning, Rocky",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: glass.textPrimary,
//             ),
//           ),
//         ),
//         Icon(Icons.notifications_outlined,
//             color: Theme.of(Get.context!).primaryColor),
//         const SizedBox(width: 10),
//         GestureDetector(
//           onTap: () => Get.find<ThemeController>().toggleTheme(),
//           child: Icon(
//             isDark ? Icons.light_mode : Icons.dark_mode,
//             color: Theme.of(Get.context!).primaryColor,
//           ),
//         ),
//       ],
//     );
//   }

//   // ✅ Summary Card
//   Widget _buildSummaryCard({
//     required String title,
//     required RxInt amount,
//     required RxInt growth,
//     required IconData icon,
//     required GlassColors glass,
//     String prefix = '',
//     String suffix = '',
//   }) {
//     return Obx(
//       () => ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: glass.cardBackground,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: glass.glassBorder),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: glass.textPrimary,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Icon(icon,
//                         size: 26, color: Theme.of(Get.context!).primaryColor),
//                     const SizedBox(width: 6),
//                     Text(
//                       "$prefix${amount.value}$suffix",
//                       style: TextStyle(
//                         color: glass.textPrimary,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   "+${growth.value}%",
//                   style: TextStyle(color: Colors.greenAccent.shade400),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ✅ Navigation Button
//   Widget _buildNavButton({
//     required String title,
//     required IconData icon,
//     required GlassColors glass,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//             decoration: BoxDecoration(
//               color: glass.cardBackground,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: glass.glassBorder),
//             ),
//             child: Row(
//               children: [
//                 Icon(icon,
//                     size: 24, color: Theme.of(Get.context!).primaryColor),
//                 const SizedBox(width: 12),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: glass.textPrimary,
//                   ),
//                 ),
//                 const Spacer(),
//                 Icon(Icons.arrow_forward_ios,
//                     size: 16, color: glass.textPrimary),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/pages/account_setting_page.dart';
import 'package:visko_rocky_flutter/pages/purchased_properties.dart';
import 'package:visko_rocky_flutter/pages/visited_properties.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import '../config/colors.dart';

class DashboardController extends GetxController {
  var purchasedProperties = 2.obs;
  var profileCompleted = 85.obs;
  var profileVisits = 234.obs;
  var totalInvestment = 1450000.obs;

  var growthPurchase = 10.obs;
  var growthProfile = 5.obs;
  var growthVisits = 8.obs;
  var growthInvestment = 12.obs;

  var repairInProgress = 23.obs;
  var awaitingRepair = 12.obs;
}

class DashboardPage extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = themeController.isDark.value;
      final glass = Theme.of(context).extension<GlassColors>()!;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Top Gradient Background (same style as HomePage)
            Container(
              height: MediaQuery.of(context).size.height * 0.62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          Colors.black.withOpacity(0.6),
                          Colors.grey.shade800.withOpacity(0.4),
                        ]
                      : [
                          kPrimaryOrange.withOpacity(0.65),
                          const Color.fromARGB(255, 255, 215, 173)
                              .withOpacity(0.35),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(glass),
                    const SizedBox(height: 20),

                    // Summary Cards
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.6,
                      children: [
                        _buildSummaryCard(
                          title: "Purchased Property",
                          amount: controller.purchasedProperties,
                          growth: controller.growthPurchase,
                          icon: Icons.home_work_outlined,
                          prefix: '',
                          glass: glass,
                        ),
                        _buildSummaryCard(
                          title: "Profile Completion",
                          amount: controller.profileCompleted,
                          growth: controller.growthProfile,
                          icon: Icons.person,
                          suffix: '%',
                          glass: glass,
                        ),
                        _buildSummaryCard(
                          title: "Profile Visits",
                          amount: controller.profileVisits,
                          growth: controller.growthVisits,
                          icon: Icons.visibility,
                          prefix: '',
                          glass: glass,
                        ),
                        _buildSummaryCard(
                          title: "Total Investment",
                          amount: controller.totalInvestment,
                          growth: controller.growthInvestment,
                          icon: Icons.attach_money,
                          prefix: '₹',
                          glass: glass,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Quick Stats Chart Card
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quick Stats",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: glass.textPrimary,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: glass.textPrimary),
                      ],
                    ),
                    const SizedBox(height: 12),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: glass.cardBackground,
                          border: Border.all(color: glass.glassBorder),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            "Chart Placeholder",
                            style: TextStyle(color: glass.textSecondary),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Navigation Buttons
                    _buildNavButton(
                      title: "Visited Property",
                      icon: Icons.location_on,
                      glass: glass,
                      onTap: () => Get.to(() => VisitedPropertiesPage()),
                    ),
                    const SizedBox(height: 12),
                    _buildNavButton(
                      title: "Purchased Property",
                      icon: Icons.shopping_bag,
                      glass: glass,
                      onTap: () => Get.to(() => PurchasedPropertiesPage()),
                    ),
                    const SizedBox(height: 12),
                    _buildNavButton(
                      title: "Account",
                      icon: Icons.person,
                      glass: glass,
                      onTap: () => Get.to(() => SettingsPage()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // ------------------------------------
  // HEADER
  // ------------------------------------
  Widget _buildHeader(GlassColors glass) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: kPrimaryOrange,
          child: Icon(Icons.dashboard, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "Good Morning, Rocky",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: glass.textPrimary,
            ),
          ),
        ),
        Icon(Icons.notifications_outlined, color: kPrimaryOrange),
        const SizedBox(width: 6),
        Icon(Icons.chat_bubble_outline, color: kPrimaryOrange),
      ],
    );
  }

  // ------------------------------------
  // SUMMARY CARD
  // ------------------------------------
  Widget _buildSummaryCard({
    required String title,
    required RxInt amount,
    required RxInt growth,
    required IconData icon,
    required GlassColors glass,
    String prefix = '',
    String suffix = '',
  }) {
    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            border: Border.all(color: glass.glassBorder),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: glass.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(icon, size: 26, color: kPrimaryOrange),
                  const SizedBox(width: 8),
                  Text(
                    "$prefix${amount.value}$suffix",
                    style: TextStyle(
                      color: glass.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "+${growth.value}%",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------
  // NAVIGATION BUTTON
  // ------------------------------------
  Widget _buildNavButton({
    required String title,
    required IconData icon,
    required GlassColors glass,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: glass.glassBorder),
          ),
          child: Row(
            children: [
              Icon(icon, size: 24, color: kPrimaryOrange),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: glass.textPrimary,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16, color: glass.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
