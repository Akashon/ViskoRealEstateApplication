// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class HomeController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxInt activeIndex = 0.obs;

//   RxList developers = [].obs; // (still static / optional API later)
//   RxList properties = [].obs;

//   final String apiUrl =
//       "https://apimanager.viskorealestate.com/fetch-all-properties";

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProperties();
//     loadDevelopers(); // temporary static
//   }

//   void setActiveIndex(int index) {
//     activeIndex.value = index;
//   }

//   // ✅ Static developers (you can make API later)
//   void loadDevelopers() {
//     developers.value = [
//       {
//         "developer_name": "Elite Builders",
//         "developer_logo":
//             "https://images.unsplash.com/photo-1501183007986-d0d080b147f9?w=600",
//         "developer_city": "Indore",
//         "developer_slug": "elite-builders",
//       },
//       {
//         "developer_name": "Skyline Group",
//         "developer_logo":
//             "https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=600",
//         "developer_city": "Bhopal",
//         "developer_slug": "skyline-group",
//       },
//     ];
//   }

//   // ✅ Fetch Properties from API
//   Future<void> fetchProperties() async {
//     try {
//       isLoading.value = true;

//       final response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data["status"] == true && data["properties"] != null) {
//           properties.value = data["properties"];
//         } else {
//           properties.value = [];
//         }
//       } else {
//         properties.value = [];
//       }
//     } catch (e) {
//       print("API Error: $e");
//       properties.value = [];
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDevelopersLoading = false.obs;

  RxInt activeIndex = 0.obs;

  RxList developers = [].obs;
  RxList properties = [].obs;

  final String developersApi =
      "https://apimanager.viskorealestate.com/fetch-all-developers";
  final String propertiesApi =
      "https://apimanager.viskorealestate.com/fetch-all-properties";

  get bannerImages => null;

  get bannerIndex => null;

  @override
  void onInit() {
    super.onInit();
    fetchDevelopers();
    fetchProperties();
  }

  void setActiveIndex(int index) {
    activeIndex.value = index;
  }

  // ✅ Fetch Developers
  Future<void> fetchDevelopers() async {
    try {
      isDevelopersLoading.value = true;

      final res = await http.get(Uri.parse(developersApi));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data["status"] == true && data["developers"] != null) {
          developers.value = data["developers"];
        } else {
          developers.value = [];
        }
      } else {
        developers.value = [];
      }
    } catch (e) {
      developers.value = [];
      print("Developer API Error: $e");
    } finally {
      isDevelopersLoading.value = false;
    }
  }

  // ✅ Fetch Properties
  Future<void> fetchProperties() async {
    try {
      isLoading.value = true;

      final res = await http.get(Uri.parse(propertiesApi));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data["status"] == true && data["properties"] != null) {
          properties.value = data["properties"];
        } else {
          properties.value = [];
        }
      } else {
        properties.value = [];
      }
    } catch (e) {
      properties.value = [];
      print("Properties API Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadData() {}
}
