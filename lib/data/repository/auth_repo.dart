import 'package:florist_app/data/api/api_client.dart';
import 'package:florist_app/models/signup_body_model.dart';
import 'package:florist_app/utils/app_constants.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{

  // final logger = Logger();

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
    });
  Future<Response> registration(SignUpBody signUpBody) async {
    // Log dữ liệu đăng ký trước khi gửi đi
    // logger.d('Sending registration data: $signUpBody');

    //toJson chuyen doi du lieu qua json can sent api client
       return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
    }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }
  Future<Response> login(String phone,String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI,{"phone":phone,"password":password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token=token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
  Future<void> saveUserNumberAndPassword(String number,String password) async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }
}