import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visko_rocky_flutter/component/home_property_card.dart';
import 'package:visko_rocky_flutter/controller/home_controller.dart';
import 'package:visko_rocky_flutter/controller/theme_controller.dart';
import 'package:visko_rocky_flutter/pages/developer_properties.dart';
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';

const Color kPrimaryOrange = Color(0xffF26A33);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());

  final ThemeController themeController = Get.find<ThemeController>();

  final RxString selectedLocation = ''.obs;

  final PageController pageController = PageController(viewportFraction: 0.75);

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDark = themeController.isDark.value;

    return Obx(() {
      final isDark = themeController.isDark.value;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
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
                          const Color.fromARGB(
                            255,
                            255,
                            215,
                            173,
                          ).withOpacity(0.35),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        glassCircleAvatar(isDark),

                        Column(
                          children: [
                            Text(
                              "Indore Location",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: isDark
                                      ? Colors.white70
                                      : kPrimaryOrange,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Vijay Nagar Indore",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () {
                            // themeController.toggleTheme(!isDark);
                            themeController.toggleTheme();
                          },
                          child: glassButton(
                            icon: isDark
                                ? Icons.light_mode_rounded
                                : Icons.dark_mode_rounded,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white30
                                        : Colors.orange.shade200,
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search properties...",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        glassButton(icon: Icons.search, isDark: isDark),
                        SizedBox(width: 10),
                        glassButton(
                          icon: Icons.filter_alt_outlined,
                          isDark: isDark,
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    Obx(() {
                      final allLocations = controller.properties
                          .map((e) => e['property_location_slug'] ?? 'Unknown')
                          .toSet()
                          .toList();

                      return SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: allLocations.length,
                          itemBuilder: (_, index) {
                            final loc = allLocations[index];
                            return Obx(
                              () => glassChip(
                                loc,
                                isDark: isDark,
                                selected: selectedLocation.value == loc,
                                onTap: () => selectedLocation.value = loc,
                              ),
                            );
                          },
                        ),
                      );
                    }),

                    SizedBox(height: 25),

                    /// ✅ REPLACED CAROUSELSLIDER WITH PAGEVIEW
                    SizedBox(
                      height: 150,
                      child: Obx(
                        () => controller.developers.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : PageView.builder(
                                controller: pageController,
                                itemCount: controller.developers.length,
                                onPageChanged: (index) {
                                  controller.setActiveIndex(index);
                                },
                                itemBuilder: (context, index) {
                                  final dev = controller.developers[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        () => DeveloperProperties(
                                          slug: dev['developer_slug'],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isDark
                                                ? Colors.black.withOpacity(0.4)
                                                : Colors.orange.withOpacity(
                                                    0.25,
                                                  ),
                                            blurRadius: 12,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  dev['developer_logo'] ?? "",
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              color: Colors.black.withOpacity(
                                                0.35,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 12,
                                              left: 12,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dev['developer_name'] ?? "",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 14,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        dev['developer_city'] ??
                                                            "",
                                                        style: TextStyle(
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Obx(
                      () => Center(
                        child: AnimatedSmoothIndicator(
                          activeIndex: controller.activeIndex.value,
                          count: controller.developers.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: kPrimaryOrange,
                            dotColor: isDark
                                ? Colors.white30
                                : Colors.orange.shade200,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Popular Properties",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),

                    SizedBox(height: 10),
                    Obx(
                      () => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: controller.properties.map((property) {
                                return HomePropertyCard(
                                  property: property,
                                  isDark: isDark,
                                  onTap: () {
                                    Get.to(
                                      () => PropertyDetailPage(
                                        slug: property['property_slug'],
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
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
}

Widget glassButton({required IconData icon, required bool isDark}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? Colors.white30 : Colors.orange.shade300,
          ),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white : kPrimaryOrange,
          size: 20,
        ),
      ),
    ),
  );
}

Widget glassIconSmall(bool isDark) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.orange.shade200,
          ),
        ),
        child: Icon(
          Icons.arrow_outward_rounded,
          size: 14,
          color: isDark ? Colors.white : kPrimaryOrange,
        ),
      ),
    ),
  );
}

Widget glassCircleAvatar(bool isDark) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isDark ? Colors.white24 : Colors.orange.shade300,
          ),
        ),
        child: const CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=500',
          ),
        ),
      ),
    ),
  );
}

Widget glassChip(
  String title, {
  required bool selected,
  required bool isDark,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: selected
              ? LinearGradient(
                  colors: [
                    kPrimaryOrange.withOpacity(0.45),
                    kPrimaryOrange.withOpacity(0.25),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ]
                      : [
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.5),
                        ],
                ),
          border: Border.all(
            color: selected
                ? Colors.orange.shade800
                : isDark
                ? Colors.white24
                : Colors.orange.shade200,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: kPrimaryOrange.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.white
                : isDark
                ? Colors.white
                : Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
