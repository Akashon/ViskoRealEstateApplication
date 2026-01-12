// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// const String baseURL = "https://apimanager.viskorealestate.com";

// class FavoriteController extends GetxController {
//   var favorites = <Map>[].obs;
//   var loading = false.obs;

//   @override
//   void onInit() {
//     fetchFavorites();
//     super.onInit();
//   }

//   /// 🔄 Load favorites once
//   Future<void> fetchFavorites() async {
//     loading.value = true;
//     try {
//       final res = await http.get(Uri.parse("$baseURL/favorites/user"));
//       if (res.statusCode == 200) {
//         final data = json.decode(res.body);
//         List list = data['favorite_properties'] ??
//             data['favorites'] ??
//             data['data'] ??
//             [];
//         favorites.assignAll(List<Map>.from(list));
//       }
//     } catch (e) {
//       debugPrint("Fetch favorite error: $e");
//     }
//     loading.value = false;
//   }

//   /// ❤️ Check
//   bool isFavorite(String propertyId) {
//     return favorites
//         .any((item) => item['property_id'].toString() == propertyId.toString());
//   }

//   /// ❤️ Toggle (INSTANT)
//   Future<void> toggleFavorite(Map property) async {
//     final id = property['property_id'];
//     final alreadyFav = isFavorite(id);

//     /// 🔥 optimistic UI update
//     if (alreadyFav) {
//       favorites.removeWhere(
//           (item) => item['property_id'].toString() == id.toString());
//     } else {
//       favorites.add(property);
//     }

//     final url = alreadyFav
//         ? "$baseURL/api/favorites/remove"
//         : "$baseURL/api/favorites/add";

//     try {
//       final res = await http.post(
//         Uri.parse(url),
//         body: {"property_id": "$id"},
//       );

//       /// rollback if API fails
//       if (res.statusCode != 200) {
//         alreadyFav ? favorites.add(property) : favorites.remove(property);
//       }
//     } catch (e) {
//       debugPrint("Toggle favorite error: $e");
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const String baseURL = "https://apimanager.viskorealestate.com";

class FavoriteController extends GetxController {
  var favoriteList = <Map>[].obs;
  var isLoading = false.obs;

  // 🔍 check favorite
  bool isFavorite(String propertyId) {
    return favoriteList.any(
      (item) => item['property_id'].toString() == propertyId,
    );
  }

  // 🔄 load favorites
  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("$baseURL/favorites/user"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List list = [];
        if (data['favorite_properties'] != null) {
          list = data['favorite_properties'];
        } else if (data['favorites'] != null) {
          list = data['favorites'];
        } else if (data['data'] != null) {
          list = data['data'];
        }

        favoriteList.assignAll(List<Map>.from(list));
      }
    } catch (e) {
      debugPrint("Fetch favorites error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ❤️ toggle favorite
  Future<void> toggleFavorite(Map property) async {
    final String id = property['property_id'].toString();

    if (isFavorite(id)) {
      favoriteList.removeWhere(
        (item) => item['property_id'].toString() == id,
      );
      await _removeFromApi(id);
    } else {
      favoriteList.add(property);
      await _addToApi(id);
    }
  }

  Future<void> _addToApi(String id) async {
    await http.post(
      Uri.parse("$baseURL/api/favorites/add"),
      body: {"property_id": id},
    );
  }

  Future<void> _removeFromApi(String id) async {
    await http.post(
      Uri.parse("$baseURL/api/favorites/remove"),
      body: {"property_id": id},
    );
  }

  isItemLoading(String propertyId) {}
}
