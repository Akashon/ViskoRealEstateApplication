import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PersonalInfoController extends GetxController {
  final box = GetStorage();

  final name = ''.obs;
  final address = ''.obs;
  final dob = ''.obs;
  final gender = 'Male'.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    name.value = box.read('name') ?? '';
    address.value = box.read('address') ?? '';
    dob.value = box.read('dob') ?? '';
    gender.value = box.read('gender') ?? 'Male';
  }

  void save({
    required String name,
    required String address,
    required String dob,
    required String gender,
  }) {
    box.write('name', name);
    box.write('address', address);
    box.write('dob', dob);
    box.write('gender', gender);

    this.name.value = name;
    this.address.value = address;
    this.dob.value = dob;
    this.gender.value = gender;
  }
}
