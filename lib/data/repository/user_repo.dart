import 'package:florist_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api/api_client.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

}
