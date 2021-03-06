import 'package:drainit_petugas/app/modules/login/providers/login_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late GetStorage box;
  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
    box = GetStorage();
    change(
      null,
      status: RxStatus.empty(),
    );
  }

  Future<void> loginPetugas(String email, String password) async {
    final dataLogin = {
      'email': email,
      'password': password,
    };
    //when user call this function, change the state to loading
    change(
      null,
      status: RxStatus.loading(),
    );
    //call this function to check user login with given data
    LoginProvider().loginPetugas(dataLogin).then(
      (resp) => {
        //if the result is ok then change the status to success and move the page to home page
        change(
          resp,
          status: RxStatus.success(),
        ),
        // box.write(Routes.TOKEN, resp.accessToken),
        box.write(Routes.TOKEN, resp.token),
        Get.offAllNamed(Routes.HOMEPAGE, arguments: 'login')
      },
      //if error happens then catch the error and show to user
      onError: (err) {
        Get.bottomSheet(
          Container(
            key: const Key('error'),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/logo.png',
                  height: Get.height * 0.3,
                ),
                Text(
                  'Error ketika login : $err',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
        change(
          null,
          status: RxStatus.error('Error occured : $err'),
        );
      },
    );
  }

  @override
  void onClose() {}
}
