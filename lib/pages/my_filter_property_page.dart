// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:visko_rocky_flutter/component/home_property_card.dart';
// import 'package:visko_rocky_flutter/theme/app_theme.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';

// class MyFilterPropertyPage extends StatefulWidget {
//   final String initialSubcategory;
//   final String initialLocation;
//   final String initialType;
//   final String initialSqFt;

//   const MyFilterPropertyPage({
//     super.key,
//     this.initialSubcategory = "Residential",
//     this.initialLocation = "",
//     this.initialType = "",
//     this.initialSqFt = "",
//   });

//   @override
//   State<MyFilterPropertyPage> createState() => _MyFilterPropertyPageState();
// }

// class _MyFilterPropertyPageState extends State<MyFilterPropertyPage> {
//   String subcategory = "Residential";
//   String selectedLocation = "";
//   String selectedType = "";
//   String selectedSqFt = "";

//   List<String> locations = [];
//   List<String> types = [];
//   List<String> sqFts = [];

//   List<Map<String, dynamic>> properties = [];
//   bool loading = true;
//   bool searching = false;

//   @override
//   void initState() {
//     super.initState();
//     subcategory = widget.initialSubcategory;
//     selectedLocation = widget.initialLocation;
//     selectedType = widget.initialType;
//     selectedSqFt = widget.initialSqFt;

//     fetchFilters(); // Fetch initial filters
//     fetchProperties(); // Fetch initial properties
//   }

//   /// Fetch filter options based on current selections
//   Future<void> fetchFilters() async {
//     try {
//       final apiSubc = subcategory == "Plot" ? "Residential" : subcategory;
//       final apiType = subcategory == "Plot" ? "plot" : selectedType;

//       final uri = Uri.https(
//         "apimanager.viskorealestate.com",
//         "/fetch-homepage-filters",
//         {
//           "subcategory": apiSubc,
//           if (selectedLocation.isNotEmpty) "location": selectedLocation,
//           if (subcategory == "Residential" && selectedType.isNotEmpty)
//             "type": apiType,
//           if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
//         },
//       );

//       final res = await http.get(uri);
//       final data = jsonDecode(res.body);

//       if (data["status"] == true) {
//         locations = List<String>.from(data["locations"] ?? []);
//         types = List<String>.from(data["types"] ?? []);
//         final sqData = data["sqFts"];
//         if (sqData is Map) {
//           sqFts = sqData.values.map((e) => e.toString()).toList();
//         } else if (sqData is List) {
//           sqFts = List<String>.from(sqData.map((e) => e.toString()));
//         } else {
//           sqFts = [];
//         }

//         // Reset selected values if no longer valid
//         selectedLocation =
//             locations.contains(selectedLocation) ? selectedLocation : "";
//         selectedType = types.contains(selectedType) ? selectedType : "";
//         selectedSqFt = sqFts.contains(selectedSqFt) ? selectedSqFt : "";
//       } else {
//         locations = [];
//         types = [];
//         sqFts = [];
//         selectedLocation = "";
//         selectedType = "";
//         selectedSqFt = "";
//       }
//     } catch (_) {
//       locations = [];
//       types = [];
//       sqFts = [];
//       selectedLocation = "";
//       selectedType = "";
//       selectedSqFt = "";
//     }
//     setState(() {});
//   }

//   /// Fetch property list based on selected filters
//   Future<void> fetchProperties() async {
//     setState(() => loading = true);
//     try {
//       final apiSubc = subcategory == "Plot" ? "Residential" : subcategory;
//       final apiType = subcategory == "Plot" ? "plot" : selectedType;

//       final uri = Uri.https(
//         "apimanager.viskorealestate.com",
//         "/fetch-homepage-filters-data-show",
//         {
//           "subcategory": apiSubc,
//           if (selectedLocation.isNotEmpty) "location": selectedLocation,
//           if (subcategory == "Residential" && selectedType.isNotEmpty)
//             "type": apiType,
//           if (subcategory == "Plot")
//             "type": "plot", // Plot tab always fetch plots
//           if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
//         },
//       );

//       final res = await http.get(uri);
//       final data = jsonDecode(res.body);

//       if (data["status"] == true) {
//         properties = List<Map<String, dynamic>>.from(
//             data["data"].map((e) => Map<String, dynamic>.from(e)));
//       } else {
//         properties = [];
//       }
//     } catch (_) {
//       properties = [];
//     }
//     setState(() => loading = false);
//   }

//   void handleSearch() async {
//     setState(() => searching = true);
//     await fetchProperties();
//     setState(() => searching = false);
//   }

//   Widget buildRoundedDropdown({
//     required String label,
//     required List<String> items,
//     required String? value,
//     required Function(String?) onChanged,
//     bool enabled = true,
//   }) {
//     final context = Get.context!;
//     final glass = context.theme.extension<GlassColors>()!;
//     final safeItems = items.toSet().toList();
//     final safeValue =
//         (value != null && safeItems.contains(value)) ? value : null;

//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         value: safeValue,
//         hint: Text(
//           " $label",
//           style: TextStyle(fontSize: 14, color: glass.textSecondary),
//         ),
//         items: safeItems.map((item) {
//           return DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 14, color: glass.textPrimary),
//             ),
//           );
//         }).toList(),
//         onChanged: enabled ? onChanged : null,
//         buttonStyleData: ButtonStyleData(
//           height: 50,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: glass.glassBackground,
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(color: glass.glassBorder, width: 1.2),
//           ),
//         ),
//         dropdownStyleData: DropdownStyleData(
//           elevation: 0,
//           maxHeight: 48 * 4,
//           decoration: BoxDecoration(
//             color: glass.solidSurface,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: glass.glassBorder, width: 1.2),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final glass = Theme.of(context).extension<GlassColors>()!;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
//         elevation: 0,
//         title: const Text(
//           "Filter Properties",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           children: [
//             /// SUBCATEGORY TABS
//             Row(
//               children: ["Residential", "Plot"].map((tab) {
//                 final active = subcategory == tab;
//                 return Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         subcategory = tab;
//                         selectedLocation = "";
//                         selectedSqFt = "";
//                         selectedType = "";
//                       });
//                       fetchFilters();
//                       fetchProperties();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       decoration: BoxDecoration(
//                         gradient: active
//                             ? LinearGradient(
//                                 colors: [
//                                   glass.chipSelectedGradientStart,
//                                   glass.chipSelectedGradientEnd
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               )
//                             : LinearGradient(
//                                 colors: [
//                                   glass.chipUnselectedStart,
//                                   glass.chipUnselectedEnd
//                                 ],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               ),
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       child: Text(
//                         tab,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: active ? Colors.white : glass.textPrimary,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 16),

//             /// FILTER DROPDOWNS
//             Row(
//               children: [
//                 if (subcategory == "Plot")
//                   Expanded(
//                     flex: 2,
//                     child: buildRoundedDropdown(
//                       label: "Residential",
//                       items: const ["Residential"],
//                       value: "Residential",
//                       onChanged: (_) {},
//                       enabled: false,
//                     ),
//                   ),
//                 if (subcategory == "Plot") const SizedBox(width: 10),
//                 Expanded(
//                   flex: 3,
//                   child: buildRoundedDropdown(
//                     label: "Location",
//                     items: locations,
//                     value: selectedLocation.isEmpty ? null : selectedLocation,
//                     onChanged: (v) {
//                       setState(() => selectedLocation = v ?? "");
//                       fetchFilters(); // Ensure area (sq ft) updates
//                     },
//                   ),
//                 ),
//                 if (subcategory == "Residential") const SizedBox(width: 10),
//                 if (subcategory == "Residential")
//                   Expanded(
//                     flex: 3,
//                     child: buildRoundedDropdown(
//                       label: "Type",
//                       items: types,
//                       value: selectedType.isEmpty ? null : selectedType,
//                       onChanged: (v) {
//                         setState(() => selectedType = v ?? "");
//                         fetchFilters();
//                       },
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             buildRoundedDropdown(
//               label: "Area (sq ft)",
//               items: sqFts,
//               value: selectedSqFt.isEmpty ? null : selectedSqFt,
//               onChanged: (v) => setState(() => selectedSqFt = v ?? ""),
//             ),
//             const SizedBox(height: 16),

//             /// SEARCH BUTTON
//             ElevatedButton(
//               onPressed: searching ? null : handleSearch,
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 50),
//                 backgroundColor: Theme.of(context).primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//               ),
//               child: searching
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text(
//                       "Search",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//             ),
//             const SizedBox(height: 16),

//             /// PROPERTY COUNT
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: Text(
//                 "${properties.length} Properties Found",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),

//             /// PROPERTY LIST
//             Expanded(
//               child: loading
//                   ? const Center(child: CircularProgressIndicator())
//                   : properties.isEmpty
//                       ? const Center(
//                           child: Text(
//                             "No properties found",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: ListView.separated(
//                             itemCount: properties.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(height: 12),
//                             itemBuilder: (_, i) {
//                               final property = properties[i];
//                               return HomePropertyCard(
//                                 property: property,
//                                 isDark: Theme.of(context).brightness ==
//                                     Brightness.dark,
//                                 onTap: () {
//                                   Get.toNamed(
//                                     '/property-detail',
//                                     arguments: {
//                                       'slug': property['property_slug'] ?? ""
//                                     },
//                                   );
//                                 },
//                                 image: null,
//                               );
//                             },
//                           ),
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
  // Filters
  String subcategory = "Residential";
  String selectedLocation = "";
  String selectedType = "";
  String selectedSqFt = "";

  List<String> locations = [];
  List<String> types = [];
  List<String> sqFts = [];

  // Properties
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

  /// Fetch filter options based on current selections
  Future<void> fetchFilters() async {
    try {
      final apiSubc = subcategory == "Plot" ? "Residential" : subcategory;
      final apiType = subcategory == "Plot" ? "plot" : selectedType;

      final uri = Uri.https(
        "apimanager.viskorealestate.com",
        "/fetch-homepage-filters",
        {
          "subcategory": apiSubc,
          "location": selectedLocation,
          if (subcategory == "Residential" && selectedType.isNotEmpty)
            "type": apiType,
          if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
        },
      );

      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] == true) {
        locations = List<String>.from(data["locations"] ?? []);
        types = List<String>.from(data["types"] ?? []);
        final sqData = data["sqFts"];
        if (sqData is Map) {
          sqFts = sqData.values.map((e) => e.toString()).toList();
        } else if (sqData is List) {
          sqFts = List<String>.from(sqData.map((e) => e.toString()));
        } else {
          sqFts = [];
        }

        selectedLocation =
            locations.contains(selectedLocation) ? selectedLocation : "";
        selectedType = types.contains(selectedType) ? selectedType : "";
        selectedSqFt = sqFts.contains(selectedSqFt) ? selectedSqFt : "";
      } else {
        locations = [];
        types = [];
        sqFts = [];
        selectedLocation = "";
        selectedType = "";
        selectedSqFt = "";
      }
    } catch (_) {
      locations = [];
      types = [];
      sqFts = [];
      selectedLocation = "";
      selectedType = "";
      selectedSqFt = "";
    }
    setState(() {});
  }

  /// Fetch property list based on selected filters
  Future<void> fetchProperties() async {
    setState(() => loading = true);
    try {
      final apiSubc = subcategory == "Plot" ? "Residential" : subcategory;
      final apiType = subcategory == "Plot" ? "plot" : selectedType;

      final uri = Uri.https(
        "apimanager.viskorealestate.com",
        "/fetch-homepage-filters-data-show",
        {
          "subcategory": apiSubc,
          "location": selectedLocation,
          if (subcategory == "Residential" && selectedType.isNotEmpty)
            "type": apiType,
          if (selectedSqFt.isNotEmpty) "sq_ft": selectedSqFt,
        },
      );

      final res = await http.get(uri);
      final data = jsonDecode(res.body);

      if (data["status"] == true) {
        properties = List<Map<String, dynamic>>.from(
            data["data"].map((e) => Map<String, dynamic>.from(e)));
      } else {
        properties = [];
      }
    } catch (_) {
      properties = [];
    }
    setState(() => loading = false);
  }

  /// Handle search button press
  void handleSearch() async {
    setState(() => searching = true);
    await fetchProperties();
    setState(() => searching = false);
  }

  /// Premium Dropdown using your theme
  Widget buildRoundedDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    final context = Get.context!;
    final glass = context.theme.extension<GlassColors>()!;
    final safeItems = items.toSet().toList();
    final safeValue =
        (value != null && safeItems.contains(value)) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            value: safeValue,
            hint: Text(
              " $label",
              style: TextStyle(
                fontSize: 14,
                color: glass.textSecondary,
              ),
            ),
            items: safeItems.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: glass.textPrimary,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            buttonStyleData: ButtonStyleData(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: glass.glassBackground,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: glass.glassBorder,
                  width: 1.2,
                ),
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              maxHeight: 48 * 4,
              decoration: BoxDecoration(
                color: glass.solidSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: glass.glassBorder,
                  width: 1.2,
                ),
              ),
              scrollbarTheme: ScrollbarThemeData(
                thumbColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                thickness: MaterialStateProperty.all(5),
                radius: const Radius.circular(10),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
            iconStyleData: IconStyleData(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 22,
              iconEnabledColor: glass.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.08),
        elevation: 0,
        title: const Text(
          "Filter Properties",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            /// SUBCATEGORY TABS
            Row(
              children: ["Residential", "Plot"].map((tab) {
                final active = subcategory == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        subcategory = tab;
                        selectedLocation = "";
                        selectedType = "";
                        selectedSqFt = "";
                      });
                      await fetchFilters();
                      await fetchProperties();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: active
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
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: active ? Colors.white : glass.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            /// FILTER DROPDOWNS
            Column(
              children: [
                Row(
                  children: [
                    if (subcategory == "Plot")
                      Expanded(
                        flex: 2,
                        child: buildRoundedDropdown(
                          label: "Residential",
                          items: const ["Residential"],
                          value: "Residential",
                          onChanged: (_) {},
                        ),
                      ),
                    if (subcategory == "Plot") const SizedBox(width: 6),
                    Expanded(
                      flex: 3,
                      child: buildRoundedDropdown(
                        label: "Location",
                        items: locations,
                        value:
                            selectedLocation.isEmpty ? null : selectedLocation,
                        onChanged: (val) async {
                          if (val != null) {
                            setState(() {
                              selectedLocation = val;
                              selectedSqFt = "";
                            });
                            await fetchFilters();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (subcategory == "Residential")
                      Expanded(
                        flex: 2,
                        child: buildRoundedDropdown(
                          label: "Type",
                          items: types,
                          value: selectedType.isEmpty ? null : selectedType,
                          onChanged: (val) async {
                            if (val != null) {
                              setState(() {
                                selectedType = val;
                                selectedSqFt = "";
                              });
                              await fetchFilters();
                            }
                          },
                        ),
                      ),
                    if (subcategory == "Residential") const SizedBox(width: 6),
                    SizedBox(
                      width: 140,
                      child: buildRoundedDropdown(
                        label: "Area Size",
                        items: sqFts,
                        value: selectedSqFt.isEmpty ? null : selectedSqFt,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => selectedSqFt = val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: searching ? null : handleSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                        ),
                        child: searching
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : const Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Property Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "${properties.length} Properties Found",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            /// Property List
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : properties.isEmpty
                      ? const Center(
                          child: Text(
                            "No properties found",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.separated(
                            itemCount: properties.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, i) {
                              final property = properties[i];
                              return SizedBox(
                                child: HomePropertyCard(
                                  property: property,
                                  isDark: Theme.of(context).brightness ==
                                      Brightness.dark,
                                  onTap: () {
                                    Get.toNamed(
                                      '/property-detail',
                                      arguments: {
                                        'slug': property['property_slug'] ?? ""
                                      },
                                    );
                                  },
                                  image: null,
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
