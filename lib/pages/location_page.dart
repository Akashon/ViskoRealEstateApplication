// THE NICE ATTRACTIVE ROW LIST UI LOCATION
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/component/inquiry_form.dart';
import 'package:visko_rocky_flutter/pages/Property_Location_Page.dart';
import '../controller/theme_controller.dart';
import '../theme/app_theme.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with TickerProviderStateMixin {
  final ThemeController themeController = Get.find<ThemeController>();
  bool loading = true;
  List locations = [];
  List filteredLocations = [];
  late AnimationController fadeController;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fetchLocations();
  }

  @override
  void dispose() {
    fadeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchLocations() async {
    final url = Uri.parse(
        "https://apimanager.viskorealestate.com/fetch-single-location");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final list = jsonData["location_list"] ??
            jsonData["data"] ??
            jsonData["locations"] ??
            [];

        // Remove duplicates
        final unique = <String, dynamic>{};
        for (var item in list) {
          final name = item["property_location_name"] ?? "";
          if (name.isNotEmpty) unique[name] = item;
        }

        setState(() {
          locations = unique.values.toList();
          filteredLocations = locations;
          loading = false;
        });

        fadeController.forward();
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
      print("ERROR: $e");
    }
  }

  void filterLocations(String query) {
    final q = query.toLowerCase();
    setState(() {
      filteredLocations = locations
          .where((loc) =>
              (loc["property_location_name"] ?? "").toLowerCase().contains(q))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + Subtitle + Search
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                "Explore Locations",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: themeController.isDark.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              )),
                          const SizedBox(height: 6),
                          Text(
                            "Choose your ideal property spot",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18),
                                      decoration: BoxDecoration(
                                        color: glass.glassBackground,
                                        borderRadius: BorderRadius.circular(28),
                                        border: Border.all(
                                            color: glass.glassBorder),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.search,
                                              color: glass.textSecondary,
                                              size: 20),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextField(
                                              controller: searchController,
                                              onChanged: filterLocations,
                                              style: TextStyle(
                                                  color: glass.textPrimary),
                                              decoration: InputDecoration(
                                                hintText: "Find a house...",
                                                hintStyle: TextStyle(
                                                    color: glass.textSecondary,
                                                    fontSize: 14),
                                                border: InputBorder.none,
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
                        ],
                      ),
                    ),

                    // Grid of Locations
                    Flexible(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                        itemCount: filteredLocations.length,
                        itemBuilder: (context, index) {
                          // final loc = filteredLocations[index]
                          //         ["property_location_name"] ??
                          //     "";
                          final loc = filteredLocations[index]
                                  ["property_location_name"] ??
                              "";
                          final slug = filteredLocations[index]
                                  ["property_location_slug"] ??
                              "";

                          return ScaleTransition(
                            scale: CurvedAnimation(
                              parent: fadeController,
                              curve: Interval(index * 0.08, 1,
                                  curve: Curves.easeOutBack),
                            ),
                            child: GestureDetector(
                              // onTap: () {
                              //   Get.snackbar(
                              //     "Location Selected",
                              //     loc,
                              //     backgroundColor: glass.glassBackground,
                              //     colorText: glass.textPrimary,
                              //   );
                              // },
                              onTap: () {
                                // Navigate to new page with slug
                                Get.to(() => PropertyLocationPage(
                                    locationName: loc, locationSlug: slug));
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: glass.glassBorder),
                                  gradient: LinearGradient(
                                    colors: [
                                      glass.glassBackground,
                                      glass.glassBackground.withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 12, sigmaY: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TweenAnimationBuilder(
                                          tween: Tween<double>(
                                              begin: 0.9, end: 1.1),
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.easeInOut,
                                          builder: (context, value, child) {
                                            return Transform.scale(
                                              scale: value,
                                              child: child,
                                            );
                                          },
                                          child: Icon(
                                            Icons.location_on_rounded,
                                            size: 42,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          loc,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: glass.textPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
