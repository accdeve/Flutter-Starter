import 'package:t_quiz/api/api_provider.dart';
import 'package:t_quiz/data/models/achievment/achievment.dart';
import 'package:t_quiz/utils/constants.dart';
import 'package:t_quiz/utils/storage_helper.dart';

class AchievmentRepository {
  final ApiProvider _provider = ApiProvider();

  Future<AchievmentResponse> response(String id) async {
    try {
      String? token = await StorageHelper.getToken();

      if (token == null) {
        throw Exception('Token not found');
      }

      dynamic responseJson = await _provider.get(
        '/achievement/$id?',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'TQUIZ-KEY': TQUIZ_KEY,
          'Authorization': 'Bearer $token',
          },
      );

      AchievmentResponse response = AchievmentResponse.fromJson(responseJson);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
