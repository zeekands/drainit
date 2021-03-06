import 'package:date_time_picker/date_time_picker.dart';
import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/components/text_default.dart';
import 'package:drainit_flutter/app/modules/register/controllers/register_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: appBarGradient(),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                InputText(
                  key: controller.nameKey,
                  title: "Nama",
                  hintText: "Example",
                  controller: controller.myControllerName,
                ),
                InputText(
                  key: controller.phoneKey,
                  title: "Telepon",
                  hintText: "0821000000",
                  controller: controller.myControllerPhoneNumber,
                ),
                InputText(
                  key: controller.emailKey,
                  title: "Email",
                  hintText: "Example@gmail.com",
                  controller: controller.myControllerEmail,
                ),
                InputText(
                  key: controller.addressKey,
                  title: "Alamat",
                  hintText: "Jl. Sudirman no.16",
                  controller: controller.myControllerAddress,
                ),
                InputText(
                  key: controller.passwordKey,
                  title: "Password",
                  hintText: "******",
                  controller: controller.myControllerPassword,
                ),
                InputText(
                  key: controller.confirmPasswordKey,
                  title: "Password Confirmation",
                  hintText: "******",
                  controller: controller.myControllerPasswordConfirm,
                ),
                DateTimePicker(
                  initialValue: '',
                  dateMask: 'yyyy-MM-dd',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Tanggal Lahir',
                  onChanged: (date) {
                    controller.dateOfBirth = date;
                  },
                ),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        key: controller.isCheckedKey,
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.isChecked.value = value!;
                        },
                      ),
                    ),
                    TextRegular(
                      text: "Saya setuju dengan syarat dan ketentuan",
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                20.verticalSpace,
                controller.obx(
                  (state) => RoundedButton(
                    key: controller.nextKey,
                    text: "Daftar",
                    height: ScreenUtil().setHeight(50),
                    borderRadius: 10.r,
                    width: Get.width,
                    textColor: black,
                    press: () {
                      controller.validateForm();
                    },
                  ),
                  onLoading: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  onEmpty: RoundedButton(
                    key: controller.nextKey,
                    text: "Daftar",
                    height: ScreenUtil().setHeight(50),
                    borderRadius: 10.r,
                    width: Get.width,
                    textColor: black,
                    press: () {
                      controller.validateForm();
                    },
                  ),
                  onError: (err) {
                    return RoundedButton(
                      key: controller.nextKey,
                      text: "Daftar",
                      height: ScreenUtil().setHeight(50),
                      borderRadius: 10.r,
                      width: Get.width,
                      textColor: black,
                      press: () {
                        controller.validateForm();
                      },
                    );
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Center(
                  child: TextRegular(
                    text: "Atau",
                    fontSize: 14.sp,
                    textColour: Colors.grey,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.LOGIN),
                      child: Text(
                        ' Masuk disini!',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  const InputText({
    Key? key,
    required this.title,
    required this.hintText,
    required this.controller,
  }) : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextRegular(text: title, fontSize: 14.sp),
        SizedBox(height: ScreenUtil().setHeight(5)),
        RoundedInputField(
          hintText: hintText,
          textEditingController: controller,
          borderColor: primary,
        ),
        SizedBox(height: ScreenUtil().setHeight(15)),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Center(
              child: SvgPicture.asset(
                'assets/svg/il_signup.svg',
                height: 250.h,
                width: 250.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          obscureText: controller.isPasswordHidden.value,
          cursorColor: primaryVariant,
          controller: controller.myControllerPassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: const TextStyle(fontSize: 13),
            icon: const Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () => controller.isPasswordHidden.toggle(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class InputPasswordConfirm extends StatelessWidget {
  const InputPasswordConfirm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: Get.width * 0.8,
        height: Get.height * 0.05,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          obscureText: controller.isConfirmPasswordHidden.value,
          cursorColor: primaryVariant,
          controller: controller.myControllerPasswordConfirm,
          decoration: InputDecoration(
            hintText: 'Konfirmasi Password',
            hintStyle: const TextStyle(fontSize: 13),
            icon: const Icon(
              Icons.lock,
              color: primary,
            ),
            suffixIcon: IconButton(
              color: primary,
              icon: controller.isConfirmPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () => controller.isConfirmPasswordHidden.toggle(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
