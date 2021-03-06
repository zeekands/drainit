import 'package:drainit_flutter/app/modules/login/models/user_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UserProvider extends GetConnect {
  Future<LoginResponse> loginUser(Map data) async {
    final response =
        await post('${Routes.BASEURL}login/masyarakat', data).timeout(
      const Duration(
        seconds: 30,
      ),
    );
    if (response.status.hasError) {
      return Future.error(response.statusCode.toString());
    } else {
      return LoginResponse.fromJson(response.body as Map<String, dynamic>);
    }
  }
}
