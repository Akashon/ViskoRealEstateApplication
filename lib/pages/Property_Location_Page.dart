// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
// import '../theme/app_theme.dart';
// import 'package:http/http.dart' as http;
// import '../controller/theme_controller.dart';
// import '../component/inquiry_form.dart';

// class PropertyLocationPage extends StatefulWidget {
//   final String locationName;
//   final String locationSlug;

//   const PropertyLocationPage({
//     super.key,
//     required this.locationName,
//     required this.locationSlug,
//   });

//   @override
//   State<PropertyLocationPage> createState() => _PropertyLocationPageState();
// }

// class _PropertyLocationPageState extends State<PropertyLocationPage> {
//   bool loading = true;
//   List properties = [];
//   final ThemeController themeController = Get.find<ThemeController>();

//   @override
//   void initState() {
//     super.initState();
//     fetchProperties();
//   }

//   Future<void> fetchProperties() async {
//     final url = Uri.parse(
//         "https://apimanager.viskorealestate.com/fetch-property-location?location_slug=${widget.locationSlug}");

//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         setState(() {
//           properties = jsonData["data"] ?? [];
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       print("ERROR: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
//         title: Text(
//           widget.locationName,
//           style: TextStyle(
//             color: Theme.of(context).extension<GlassColors>()!.textPrimary,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : properties.isEmpty
//               ? Center(
//                   child: Text(
//                   "No properties found",
//                   style: TextStyle(
//                       color: Theme.of(context)
//                           .extension<GlassColors>()!
//                           .textSecondary),
//                 ))
//               : ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: properties.length,
//                   itemBuilder: (context, index) {
//                     final property = properties[index];

//                     return HomePropertyCard(
//                       isDark: isDark,
//                       property: property,
//                       onTap: () {
//                         Get.to(() => PropertyDetailPage(
//                               slug: property['property_slug'],
//                               property: null,
//                             ));
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/theme_controller.dart';
import '../theme/app_theme.dart';
import '../component/home_property_card.dart';
import 'property_detail_page.dart';

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
  final ThemeController themeController = Get.find<ThemeController>();

  bool locationsLoading = true;
  bool propertiesLoading = true;

  List<Map<String, dynamic>> locations =
      []; // each item should contain property_location_name & property_location_slug
  List<dynamic> properties = [];

  String selectedSlug = "";
  String selectedName = "";

  @override
  void initState() {
    super.initState();
    // set defaults from incoming widget
    selectedSlug = widget.locationSlug;
    selectedName = widget.locationName;

    // Load chips (locations) first, then load properties for selected slug
    fetchLocations();
  }

  // Fetch all unique locations for chips
  Future<void> fetchLocations() async {
    setState(() {
      locationsLoading = true;
    });

    final url = Uri.parse(
        "https://apimanager.viskorealestate.com/fetch-single-location");

    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final jsonData = jsonDecode(resp.body);
        final list = jsonData["location_list"] ??
            jsonData["data"] ??
            jsonData["locations"] ??
            [];

        // build unique map keyed by slug (prefer slug uniqueness)
        final Map<String, Map<String, dynamic>> unique = {};
        for (var item in list) {
          final slug =
              (item["property_location_slug"] ?? item["location_slug"] ?? "")
                  .toString();
          final name =
              (item["property_location_name"] ?? item["name"] ?? "").toString();
          if (slug.isNotEmpty && name.isNotEmpty) {
            unique[slug] = {
              "property_location_slug": slug,
              "property_location_name": name,
            };
          }
        }

        setState(() {
          locations = unique.values.toList();
          locationsLoading = false;
        });

        // If incoming selected slug not present in fetched locations, try to set from name match
        final exists =
            locations.any((e) => e["property_location_slug"] == selectedSlug);
        if (!exists) {
          final byName = locations.firstWhere(
              (e) =>
                  e["property_location_name"].toString().toLowerCase() ==
                  widget.locationName.toLowerCase(),
              orElse: () => {});
          if (byName.isNotEmpty) {
            selectedSlug = byName["property_location_slug"];
            selectedName = byName["property_location_name"];
          } else if (locations.isNotEmpty) {
            // fallback to first location
            selectedSlug = locations.first["property_location_slug"];
            selectedName = locations.first["property_location_name"];
          }
        }

        // Now fetch properties for selected slug
        await fetchProperties(selectedSlug);
      } else {
        setState(() => locationsLoading = false);
      }
    } catch (e) {
      print("ERROR fetchLocations: $e");
      setState(() => locationsLoading = false);
    }
  }

  // Fetch properties for a given location slug
  Future<void> fetchProperties(String slug) async {
    setState(() {
      propertiesLoading = true;
      properties = [];
    });

    final url = Uri.parse(
        "https://apimanager.viskorealestate.com/fetch-property-location?location_slug=$slug");

    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final jsonData = jsonDecode(resp.body);
        // API returns in "data" as you provided earlier
        final list =
            jsonData["data"] ?? jsonData["properties"] ?? jsonData ?? [];

        setState(() {
          properties = (list is List) ? list : [];
          propertiesLoading = false;
          // update selected name for header if possible
          final loc = locations.firstWhere(
              (e) => e["property_location_slug"] == slug,
              orElse: () => {});
          if (loc.isNotEmpty) selectedName = loc["property_location_name"];
        });
      } else {
        setState(() => propertiesLoading = false);
      }
    } catch (e) {
      print("ERROR fetchProperties: $e");
      setState(() => propertiesLoading = false);
    }
  }

  // Chip widget using GlassColors (keeps visual style consistent)
  Widget glassChip(String title,
      {required bool selected, required VoidCallback onTap}) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: selected
                ? LinearGradient(
                    colors: [
                      glass.chipSelectedGradientStart,
                      glass.chipSelectedGradientEnd
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      glass.chipUnselectedStart,
                      glass.chipUnselectedEnd
                    ],
                  ),
            border: Border.all(
                color: selected ? Colors.orange.shade800 : glass.glassBorder),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.white : glass.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    final isDark = themeController.isDark.value;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
        title: Text(
          selectedName.isNotEmpty ? selectedName : widget.locationName,
          style: TextStyle(
            color: glass.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: locationsLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // CHIPS ROW
                SizedBox(
                  height: 56,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    scrollDirection: Axis.horizontal,
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final loc = locations[index];
                      final name = loc["property_location_name"] ?? "";
                      final slug = loc["property_location_slug"] ?? "";

                      final bool selected = slug == selectedSlug;

                      return glassChip(
                        name,
                        selected: selected,
                        onTap: () {
                          if (slug == selectedSlug) return;
                          setState(() {
                            selectedSlug = slug;
                            selectedName = name;
                          });
                          fetchProperties(slug);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // PROPERTIES
                Expanded(
                  child: propertiesLoading
                      ? const Center(child: CircularProgressIndicator())
                      : properties.isEmpty
                          ? Center(
                              child: Text(
                                "No properties found",
                                style: TextStyle(color: glass.textSecondary),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: properties.length,
                              itemBuilder: (context, index) {
                                final item = properties[index];
                                return HomePropertyCard(
                                  isDark: isDark,
                                  property: item,
                                  onTap: () {
                                    Get.to(() => PropertyDetailPage(
                                          slug: item['property_slug'],
                                          property: null,
                                        ));
                                  },
                                );
                              },
                            ),
                ),
              ],
            ),
    );
  }
}
