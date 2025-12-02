import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_theme.dart';
import '../controller/theme_controller.dart';
import '../config/colors.dart';

class CategoryPropertyPage extends StatefulWidget {
  final String category;
  const CategoryPropertyPage({super.key, required this.category});

  @override
  State<CategoryPropertyPage> createState() => _CategoryPropertyPageState();
}

class _CategoryPropertyPageState extends State<CategoryPropertyPage> {
  final ThemeController themeController = Get.find<ThemeController>();

  // Dummy properties for demo (replace with API data)
  final List<Map<String, dynamic>> allProperties = [
    {
      'name': "Plot A",
      'category': "Plots",
      'location': "Indore",
      'price': "50 Lakh"
    },
    {
      'name': "Luxury Villa",
      'category': "Luxury",
      'location': "Bhopal",
      'price': "5 Cr"
    },
    {
      'name': "Residential Flat",
      'category': "Residential",
      'location': "Indore",
      'price': "80 Lakh"
    },
    {
      'name': "Commercial Shop",
      'category': "Commercial",
      'location': "Indore",
      'price': "2 Cr"
    },
    {
      'name': "Plot B",
      'category': "Plots",
      'location': "Bhopal",
      'price': "60 Lakh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final properties =
        allProperties.where((p) => p['category'] == widget.category).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(),
                Text(
                  widget.category,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: glass.textPrimary,
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () => themeController.toggleTheme(),
                    child: glassButton(
                      icon: themeController.isDark.value
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: properties.isEmpty
                  ? Center(
                      child: Text(
                        "No properties found",
                        style: TextStyle(color: glass.textSecondary),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: properties.length,
                      itemBuilder: (_, index) {
                        final property = properties[index];
                        return propertyCard(property, glass);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Property Card
Widget propertyCard(Map<String, dynamic> property, GlassColors glass) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: glass.cardBackground,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: glass.glassBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property['name'],
          style: TextStyle(
              color: glass.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          "${property['location']} - ${property['price']}",
          style: TextStyle(color: glass.textSecondary),
        ),
      ],
    ),
  );
}

/// Reuse Glass Widgets
Widget backButton() {
  return GestureDetector(
    onTap: () => Get.back(),
    child: glassButton(icon: Icons.arrow_back_ios_new_rounded),
  );
}

Widget glassButton({required IconData icon}) {
  final glass = Theme.of(Get.context!).extension<GlassColors>()!;
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: glass.glassBackground,
          shape: BoxShape.circle,
          border: Border.all(color: glass.glassBorder),
        ),
        child: Icon(icon, color: Theme.of(Get.context!).primaryColor, size: 20),
      ),
    ),
  );
}
