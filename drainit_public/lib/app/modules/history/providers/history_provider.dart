import 'package:drainit_flutter/app/modules/homepage/models/timeline_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HistoryProvider extends GetConnect {
  Future<List<Timeline>> loadHistory(String token) async {
    final header = {'Authorization': 'Bearer $token'};

    final response = await get(
      '${Routes.BASEURL_SYSTEM}pengaduan_by_masyarakat',
      headers: header,
    ).timeout(const Duration(seconds: 10));

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      // print(response.body);
      final dataRaw = (response.body as List)
          .map(
            (e) => Timeline.fromJson(e as Map<String, dynamic>),
          )
          .toList();
      return dataRaw;
    }
  }
}
