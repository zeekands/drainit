import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/components/rounded_input_field.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  print('Approve');
                },
              ),
            ],
          );
        },
      );
    }

    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: () => Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -10.w,
                child: SizedBox(
                  width: 414.w,
                  height: 896.h,
                  child: SvgPicture.asset(
                    'assets/svg/bg.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 329.h,
                  ),
                  Column(
                    children: [
                      Text(
                        'SELAMAT DATANG',
                        style: TextStyle(
                          fontFamily: 'Klasik',
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: kTextPurple,
                        ),
                      ),
                      Text(
                        'DI DRAINIT',
                        style: TextStyle(
                          fontFamily: 'Klasik',
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: kTextPurple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80.h),
                  LoginWithButton(
                    iconPath: 'assets/svg/GoogleIcon.svg',
                    width: 374.w,
                    height: 50.h,
                    spaceBetweenIconAndText: 17.w,
                    text: 'Login Tanpa Akun',
                    borderRadius: 12.r,
                    textColor: kTextPurple,
                    backgroundColor: white,
                    onClick: () {
                      Get.toNamed(Routes.HOME, arguments: 'anonymouse');
                    },
                    fontSize: 16.sp,
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  SizedBox(
                    width: 414.w,
                    height: 356.h,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Login Dengan Email',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: kTextPurple,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Divider(
                            color: kIconColor,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          RoundedInputField(
                            key: const Key("emailFormField"),
                            roundedCorner: 12.w,
                            padding: EdgeInsets.all(20.w),
                            textEditingController: controller.myControllerEmail,
                            hintText: 'Email',
                            height: 56.h,
                            width: 376.w,
                            textSize: 16.sp,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          InputPassword(
                            key: const Key("passwordFormField"),
                            controller: controller,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          controller.obx(
                            (state) => RoundedButton(
                              key: const Key("loginButton"),
                              text: 'Login',
                              fontSize: 16.sp,
                              borderRadius: 12.w,
                              height: 56.h,
                              width: 376.w,
                              color: kIconColor,
                              press: () async {
                                if (controller.myControllerEmail.text.isEmpty ||
                                    controller
                                        .myControllerPassword.text.isEmpty) {
                                  controller.loginInformationEmpty();
                                } else {
                                  await controller.userLogin(
                                    controller.myControllerEmail.text,
                                    controller.myControllerPassword.text,
                                  );
                                }
                              },
                            ),
                            onEmpty: RoundedButton(
                              text: 'Login',
                              fontSize: 16.sp,
                              borderRadius: 12.w,
                              height: 56.h,
                              width: 376.w,
                              color: kIconColor,
                              press: () async {
                                if (controller.myControllerEmail.text.isEmpty ||
                                    controller
                                        .myControllerPassword.text.isEmpty) {
                                  controller.loginInformationEmpty();
                                } else {
                                  await controller.userLogin(
                                    controller.myControllerEmail.text,
                                    controller.myControllerPassword.text,
                                  );
                                }
                              },
                            ),
                            onError: (err) {
                              final Widget errorLogin = RoundedButton(
                                text: 'Login',
                                fontSize: 16.sp,
                                borderRadius: 12.w,
                                height: 56.h,
                                width: 376.w,
                                color: kIconColor,
                                press: () async {
                                  if (controller
                                          .myControllerEmail.text.isEmpty ||
                                      controller
                                          .myControllerPassword.text.isEmpty) {
                                    controller.loginInformationEmpty();
                                  } else {
                                    await controller.userLogin(
                                      controller.myControllerEmail.text,
                                      controller.myControllerPassword.text,
                                    );
                                  }
                                },
                              );
                              return errorLogin;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                            child: Text(
                              'Lupa Password?',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum Punya Akun?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.REGISTER),
                                child: Text(
                                  ' Daftar Disini!',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kIconColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 376.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: kBackgroundInput,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: TextField(
          obscureText: controller.isPasswordHidden.value,
          cursorColor: kBackgroundInput,
          controller: controller.myControllerPassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 20.w,
              top: 20.h,
              bottom: 21.h,
            ),
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 16.sp),
            suffixIcon: IconButton(
              color: kIconColor,
              icon: controller.isPasswordHidden.value
                  ? const Icon(Icons.remove_red_eye)
                  : const Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                controller.isPasswordHidden.toggle();
              },
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}