import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import '../theme/app_theme.dart';
import 'package:http/http.dart' as http;
import '../controller/theme_controller.dart';
import '../component/inquiry_form.dart';

class PropertyLocationPage extends StatefulWidget {
  final String locationName;
  final String locationSlug;

  const PropertyLocationPage({
    super.key,
    required this.locationName,
    required this.locationSlug,
  });

  @override
  State<PropertyLocationPage> createState() => _PropertyLocationPageState();
}

class _PropertyLocationPageState extends State<PropertyLocationPage> {
  bool loading = true;
  List properties = [];
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    final url = Uri.parse(
        "https://apimanager.viskorealestate.com/fetch-property-location?location_slug=${widget.locationSlug}");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          properties = jsonData["data"] ?? [];
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
      print("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
        title: Text(
          widget.locationName,
          style: TextStyle(
            color: Theme.of(context).extension<GlassColors>()!.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : properties.isEmpty
              ? Center(
                  child: Text(
                  "No properties found",
                  style: TextStyle(
                      color: Theme.of(context)
                          .extension<GlassColors>()!
                          .textSecondary),
                ))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    final property = properties[index];

                    return HomePropertyCard(
                      isDark: isDark,
                      property: property,
                      onTap: () {
                        Get.to(() => PropertyDetailPage(
                              slug: property['property_slug'],
                              property: null,
                            ));
                      },
                    );
                  },
                ),
    );
  }
}
