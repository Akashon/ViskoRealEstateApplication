import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ContactInfoController extends GetxController {
  final _box = GetStorage();

  final RxString mobile = ''.obs;
  final RxString email = ''.obs;

  final RxBool mobileVerified = false.obs;
  final RxBool emailVerified = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    mobile.value = _box.read('mobile') ?? '';
    email.value = _box.read('email') ?? '';

    mobileVerified.value = mobile.value.isNotEmpty;
    emailVerified.value = email.value.isNotEmpty;
  }

  void save({
    required String mobile,
    required String email,
  }) {
    this.mobile.value = mobile;
    this.email.value = email;

    mobileVerified.value = mobile.isNotEmpty;
    emailVerified.value = email.isNotEmpty;

    _box.write('mobile', mobile);
    _box.write('email', email);
  }
}
