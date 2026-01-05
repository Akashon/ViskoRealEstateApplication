import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:visko_rocky_flutter/pages/property_detail_page.dart';
import '../component/home_property_card.dart';
import '../theme/app_theme.dart';

const String baseURL = "https://apimanager.viskorealestate.com";

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List favorites = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final response = await http.get(Uri.parse("$baseURL/favorites/user"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List list = [];

        if (data["favorite_properties"] != null) {
          list = data["favorite_properties"];
        } else if (data["favorites"] != null) {
          list = data["favorites"];
        } else if (data["data"] != null) {
          list = data["data"];
        }

        setState(() {
          favorites = list;
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() => loading = false);
    }
  }

  void removeFromFavorites(int id) async {
    try {
      final response = await http.post(
        Uri.parse("$baseURL/api/favorites/remove"),
        body: {"property_id": id.toString()},
      );

      if (response.statusCode == 200) {
        setState(() {
          favorites.removeWhere(
            (item) => item["property_id"].toString() == id.toString(),
          );
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : favorites.isEmpty
                ? _buildEmptyUI(glass)
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ================= HEADER =================
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Your saved properties",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================= FAVORITES LIST =================
                        Flexible(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 16),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              final item = favorites[index];

                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOut,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: GlassFavoriteCard(
                                  glass: glass,
                                  child: HomePropertyCard(
                                    property: item,
                                    isDark: Theme.of(context).brightness ==
                                        Brightness.dark,
                                    onTap: () {
                                      Get.to(
                                        () => PropertyDetailPage(
                                          slug: item['property_slug'],
                                          property: null,
                                        ),
                                      );
                                    },
                                    onFavoriteRemoved: () {
                                      removeFromFavorites(item["property_id"]);
                                    },
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

  Widget _buildEmptyUI(GlassColors glass) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite_border_rounded,
            size: 90, color: glass.textSecondary),
        const SizedBox(height: 12),
        Text(
          "No Favorites Yet",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: glass.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Start saving properties you love",
          style: TextStyle(fontSize: 15, color: glass.textSecondary),
        ),
      ],
    );
  }
}

class GlassFavoriteCard extends StatelessWidget {
  final Widget child;
  final GlassColors glass;

  const GlassFavoriteCard(
      {super.key, required this.child, required this.glass});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: glass.cardBackground,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}
