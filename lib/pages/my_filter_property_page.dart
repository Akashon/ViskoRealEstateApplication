// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class MyFilterPropertyPage extends StatefulWidget {
//   final String subcategory;
//   final String location;
//   final String type;
//   final String sqFt;

//   const MyFilterPropertyPage({
//     super.key,
//     required this.subcategory,
//     required this.location,
//     required this.type,
//     required this.sqFt,
//   });

//   @override
//   State<MyFilterPropertyPage> createState() => _MyFilterPropertyPageState();
// }

// class _MyFilterPropertyPageState extends State<MyFilterPropertyPage> {
//   final ThemeController themeController = Get.find<ThemeController>();

//   final RxBool isLoading = true.obs;
//   final RxList<Map<String, dynamic>> properties = <Map<String, dynamic>>[].obs;

//   @override
//   void initState() {
//     super.initState();
//     fetchFilteredProperties();
//   }

//   Future<void> fetchFilteredProperties() async {
//     try {
//       // ✅ FIXED API PARAM LOGIC
//       final isPlot = widget.subcategory.toLowerCase() == "plot";

//       final apiSubcategory =
//           isPlot ? "Residential" : widget.subcategory; // KEEP ORIGINAL CASE

//       final apiType = isPlot ? "plot" : widget.type;

//       final uri = Uri.parse(
//         'https://apimanager.viskorealestate.com/fetch-properties'
//         '?subcategory=${Uri.encodeComponent(apiSubcategory)}'
//         '&location=${Uri.encodeComponent(widget.location)}'
//         '${apiType.isNotEmpty ? '&type=${Uri.encodeComponent(apiType)}' : ''}'
//         '&sq_ft=${Uri.encodeComponent(widget.sqFt)}',
//       );

//       debugPrint("FILTER API → $uri");

//       final res = await http.get(uri);
//       final body = jsonDecode(res.body);

//       if (body != null && body['status'] == true && body['data'] != null) {
//         final List list = body['data'] is List
//             ? body['data']
//             : (body['data']['properties'] ?? []);

//         properties.assignAll(
//           list.map((e) => Map<String, dynamic>.from(e)).toList(),
//         );
//       } else {
//         properties.clear();
//       }
//     } catch (e) {
//       properties.clear();
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Text(
//           "Filtered Properties",
//           style: TextStyle(
//             color: glass.textPrimary,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
//       ),
//       body: Obx(() {
//         if (isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (properties.isEmpty) {
//           return Center(
//             child: Text(
//               "No properties found",
//               style: TextStyle(
//                 color: glass.textSecondary,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(14),
//           itemCount: properties.length,
//           itemBuilder: (_, index) {
//             final property = properties[index];

//             return HomePropertyCard(
//               property: property,
//               isDark: isDark,
//               onTap: () {
//                 Get.to(() => PropertyDetailPage(
//                       slug: property['property_slug'] ?? "",
//                       property: property,
//                     ));
//               },
//             );
//           },
//         );
//       }),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/controller/theme_controller.dart';
// import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';

// class MyFilterPropertyPage extends StatefulWidget {
//   final String subcategory;
//   final String location;
//   final String type;
//   final String sqFt;

//   const MyFilterPropertyPage({
//     super.key,
//     required this.subcategory,
//     required this.location,
//     required this.type,
//     required this.sqFt,
//   });

//   @override
//   State<MyFilterPropertyPage> createState() => _MyFilterPropertyPageState();
// }

// class _MyFilterPropertyPageState extends State<MyFilterPropertyPage> {
//   final ThemeController themeController = Get.find<ThemeController>();

//   /// 🔍 SEARCH STATE
//   final RxString subcategory = "".obs;
//   final RxString selectedLocation = "".obs;
//   final RxString selectedType = "".obs;
//   final RxString selectedSqFt = "".obs;

//   final RxList<String> locations = <String>[].obs;
//   final RxList<String> types = <String>[].obs;
//   final RxList<String> sqFts = <String>[].obs;

//   /// 📋 PROPERTY STATE
//   final RxBool isLoading = false.obs;
//   final RxList<Map<String, dynamic>> properties = <Map<String, dynamic>>[].obs;

//   @override
//   void initState() {
//     super.initState();

//     /// ✅ Set values coming from HomePage
//     subcategory.value = widget.subcategory;
//     selectedLocation.value = widget.location;
//     selectedType.value = widget.type;
//     selectedSqFt.value = widget.sqFt;

//     /// ✅ Load everything
//     loadInitial();
//   }

//   Future<void> loadInitial() async {
//     await fetchFilters();
//     await fetchProperties();
//   }

//   /// ---------------- FILTER API ----------------
//   Future<void> fetchFilters() async {
//     final isPlot = subcategory.value == "Plot";
//     final apiSub = isPlot ? "Residential" : subcategory.value;
//     final apiType = isPlot ? "plot" : selectedType.value;

//     final uri = Uri.parse(
//       'https://apimanager.viskorealestate.com/fetch-homepage-filters'
//       '?subcategory=$apiSub'
//       '&location=${selectedLocation.value}'
//       '&type=$apiType'
//       '&sq_ft=${selectedSqFt.value}',
//     );

//     final res = await http.get(uri);
//     final body = jsonDecode(res.body);

//     if (body['status'] == true) {
//       locations.value = List<String>.from(body['locations'] ?? []);
//       types.value = List<String>.from(body['types'] ?? []);

//       final sq = body['sqFts'];
//       if (sq is Map) {
//         sqFts.value = sq.values.map((e) => e.toString()).toList();
//       } else if (sq is List) {
//         sqFts.value = sq.map((e) => e.toString()).toList();
//       }
//     }
//   }

//   /// ---------------- PROPERTY API ----------------
//   Future<void> fetchProperties() async {
//     try {
//       isLoading.value = true;
//       properties.clear();

//       Map<String, String> query = {};

//       if (subcategory.value.isNotEmpty) {
//         query['subcategory'] = subcategory.value;
//       }
//       if (selectedLocation.value.isNotEmpty) {
//         query['location'] = selectedLocation.value;
//       }
//       if (selectedType.value.isNotEmpty) {
//         query['type'] = selectedType.value;
//       }
//       if (selectedSqFt.value.isNotEmpty) {
//         query['sq_ft'] = selectedSqFt.value;
//       }

//       /// 🚨 IMPORTANT CHECK
//       if (query.isEmpty) {
//         isLoading.value = false;
//         return;
//       }

//       final uri = Uri.https(
//         'apimanager.viskorealestate.com',
//         '/fetch-properties',
//         query,
//       );

//       /// 🔍 DEBUG (MUST SEE THIS)
//       debugPrint("PROPERTY API => $uri");

//       final res = await http.get(uri);
//       final body = jsonDecode(res.body);

//       debugPrint("RESPONSE => $body");

//       if (body['status'] == true && body['data'] != null) {
//         final List list =
//             body['data'] is List ? body['data'] : body['data']['properties'];

//         properties.assignAll(
//           list.map((e) => Map<String, dynamic>.from(e)).toList(),
//         );
//       }
//     } catch (e) {
//       debugPrint("ERROR => $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// 🔍 SEARCH BUTTON ACTION (IMPORTANT)
//   void onSearch() async {
//     await fetchFilters();
//     await fetchProperties();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     final isDark = themeController.isDark.value;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text("Filtered Properties"),
//       ),
//       body: Obx(() {
//         return Column(
//           children: [
//             /// 🔍 SEARCH BAR (HOME JESA)
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: buildRoundedDropdown(
//                       label: "Location",
//                       items: locations,
//                       value: selectedLocation.value,
//                       onChanged: (v) => selectedLocation.value = v ?? "",
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   if (subcategory.value == "Residential")
//                     Expanded(
//                       child: buildRoundedDropdown(
//                         label: "Type",
//                         items: types,
//                         value: selectedType.value,
//                         onChanged: (v) => selectedType.value = v ?? "",
//                       ),
//                     ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: buildRoundedDropdown(
//                       label: "Sq Ft",
//                       items: sqFts,
//                       value: selectedSqFt.value,
//                       onChanged: (v) => selectedSqFt.value = v ?? "",
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: onSearch,
//                     child: const Icon(Icons.search),
//                   )
//                 ],
//               ),
//             ),

//             /// 📋 RESULT LIST
//             Expanded(
//               child: isLoading.value
//                   ? const Center(child: CircularProgressIndicator())
//                   : properties.isEmpty
//                       ? const Center(child: Text("No properties found"))
//                       : ListView.builder(
//                           padding: const EdgeInsets.all(14),
//                           itemCount: properties.length,
//                           itemBuilder: (_, i) {
//                             final property = properties[i];
//                             return HomePropertyCard(
//                               property: property,
//                               isDark: isDark,
//                               onTap: () {
//                                 Get.to(() => PropertyDetailPage(
//                                       slug: property['property_slug'] ?? "",
//                                       property: property,
//                                     ));
//                               },
//                             );
//                           },
//                         ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// Widget buildRoundedDropdown({
//   required String label,
//   required List<String> items,
//   required String? value,
//   required Function(String?) onChanged,
// }) {
//   final glass = Get.context!.theme.extension<GlassColors>()!;

//   // FIX 1 → Remove duplicates
//   final safeItems = items.toSet().toList();

//   // FIX 2 → Only set value if it exists in the list
//   final safeValue = (value != null && safeItems.contains(value)) ? value : null;

//   return DropdownButtonFormField<String>(
//     value: safeValue,
//     decoration: InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(
//         fontSize: 13,
//         color: glass.textSecondary,
//         fontWeight: FontWeight.w500,
//       ),
//       filled: true,
//       fillColor: glass.glassBackground,
//       contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(18),
//         borderSide: BorderSide(color: glass.glassBorder, width: 1),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(18),
//         borderSide: BorderSide(color: glass.glassBorder, width: 1),
//       ),
//     ),
//     style: TextStyle(
//       fontSize: 14,
//       color: glass.textPrimary,
//       fontWeight: FontWeight.w500,
//     ),
//     dropdownColor: glass.cardBackground,
//     items: safeItems
//         .map((v) => DropdownMenuItem(
//               value: v,
//               child: Text(
//                 v,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: glass.textPrimary,
//                 ),
//               ),
//             ))
//         .toList(),
//     onChanged: onChanged,
//   );
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class MyFilterPropertyPage extends StatefulWidget {
  final String initialSubcategory;
  final String initialLocation;
  final String initialType;
  final String initialSqFt;

  const MyFilterPropertyPage({
    super.key,
    this.initialSubcategory = "Residential",
    this.initialLocation = "",
    this.initialType = "",
    this.initialSqFt = "",
  });

  @override
  State<MyFilterPropertyPage> createState() => _MyFilterPropertyPageState();
}

class _MyFilterPropertyPageState extends State<MyFilterPropertyPage> {
  String subcategory = "Residential";
  String selectedLocation = "";
  String selectedType = "";
  String selectedSqFt = "";

  List<String> locations = [];
  List<String> types = [];
  List<String> sqFts = [];

  List<Map<String, dynamic>> properties = [];

  bool loading = true;
  bool searching = false;

  @override
  void initState() {
    super.initState();
    subcategory = widget.initialSubcategory;
    selectedLocation = widget.initialLocation;
    selectedType = widget.initialType;
    selectedSqFt = widget.initialSqFt;

    fetchFilters();
    fetchProperties();
  }

  Future<void> fetchFilters() async {
    try {
      final params = {
        "subcategory": subcategory,
        "location": selectedLocation,
        if (subcategory == "Residential" && selectedType.isNotEmpty)
          "type": selectedType,
        if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
      };

      final uri = Uri.https(
        "apimanager.viskorealestate.com",
        "/fetch-homepage-filters",
        params,
      );

      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] == true) {
        locations = List<String>.from(data["locations"] ?? []);
        types = List<String>.from(data["types"] ?? []);
        sqFts = data["sqFts"] != null
            ? List<String>.from(data["sqFts"].values.map((e) => e.toString()))
            : [];
      }
    } catch (_) {}
    setState(() {});
  }

  Future<void> fetchProperties() async {
    setState(() => loading = true);
    try {
      final params = {
        "subcategory": subcategory,
        "location": selectedLocation,
        if (subcategory == "Residential" && selectedType.isNotEmpty)
          "type": selectedType,
        if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
      };

      final uri = Uri.https(
        "apimanager.viskorealestate.com",
        "/fetch-homepage-filters-data-show",
        params,
      );

      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] == true) {
        properties = List<Map<String, dynamic>>.from(
          data["data"].map((e) => Map<String, dynamic>.from(e)),
        );
      } else {
        properties = [];
      }
    } catch (_) {
      properties = [];
    }
    setState(() => loading = false);
  }

  void handleSearch() async {
    setState(() => searching = true);
    await fetchProperties();
    setState(() => searching = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
        title: Text(
          "Filter Property",
          style: TextStyle(
            // color: glass.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            /// TABS
            Row(
              children: ["Residential", "Plot"].map((e) {
                final active = subcategory == e;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        subcategory = e;
                        selectedLocation = "";
                        selectedType = "";
                        selectedSqFt = "";
                      });
                      fetchFilters();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: active ? Colors.orange : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: active ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            /// FILTERS
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedLocation.isEmpty ? null : selectedLocation,
                    hint: const Text("Location"),
                    items: locations
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      setState(() => selectedLocation = v ?? "");
                      fetchFilters();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                if (subcategory == "Residential")
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedType.isEmpty ? null : selectedType,
                      hint: const Text("Type"),
                      items: types
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() => selectedType = v ?? "");
                        fetchFilters();
                      },
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedSqFt.isEmpty ? null : selectedSqFt,
              hint: const Text("Area (sq ft)"),
              items: sqFts
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => selectedSqFt = v ?? ""),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: searching ? null : handleSearch,
              child: searching
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Search"),
            ),

            const SizedBox(height: 16),

            /// RESULTS
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : properties.isEmpty
                      ? const Center(child: Text("No properties found"))
                      : GridView.builder(
                          itemCount: properties.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (_, i) {
                            final p = properties[i];
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    p["property_images"]?.first ??
                                        "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      p["property_name"] ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      "${p["property_city"] ?? ""}",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
