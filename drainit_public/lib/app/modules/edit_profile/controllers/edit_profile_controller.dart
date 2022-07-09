import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectedImagePath = ''.obs;
  RxString bytes64Image = ''.obs;

  Profile profile = Get.arguments as Profile;

  @override
  void onInit() {
    super.onInit();
    nameController.text = profile.nama!;
    emailController.text = profile.email!;
    phoneController.text = profile.noHp!;
    addressController.text = profile.alamat!;
  }

  void updateProfile(
    String name,
    String phone,
    String email,
    String alamat,
    String? foto,
  ) {}

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    selectedImagePath.value = '';
    bytes64Image.value = '';
  }
}
