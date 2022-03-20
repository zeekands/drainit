import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  Future<Profile?> geProfile(String token) async {
    final header = {'Authorization': 'Bearer $token'};
    final response = await get(
      'https://gis-drainase.pocari.id/api/masyarakat/profile',
      headers: header,
    ).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return Profile.fromJson(response.body as Map<String, dynamic>);
    } else {
      return Future.error(response.statusText.toString());
    }
  }
}