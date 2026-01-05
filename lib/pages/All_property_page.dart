import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/controller/home_controller.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class AllPropertyPage extends StatelessWidget {
  AllPropertyPage({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
        title: Text(
          "All Properties",
          style: TextStyle(
            color: glass.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.properties.isEmpty) {
          return const Center(child: Text("No properties found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.properties.length,
          itemBuilder: (context, index) {
            final property = controller.properties[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: HomePropertyCard(
                property: property,
                isDark: isDark,
                onTap: () {
                  Get.to(
                    () => PropertyDetailPage(
                      slug: property['property_slug'] ?? "",
                      property: property,
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
