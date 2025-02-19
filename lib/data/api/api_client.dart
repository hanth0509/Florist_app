
import 'package:florist_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService{
  String? token;
  // late String token;
  final String appBaseUrl;//url cơ sở
  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;// biến riêng tư
  ApiClient({required this.appBaseUrl,required this.sharedPreferences}){
          baseUrl=appBaseUrl;
          timeout=Duration(seconds: 30);
          // token=sharedPreferences.getString(AppConstants.TOKEN)!;
          token=sharedPreferences.getString(AppConstants.TOKEN)??"";
          _mainHeaders={
            'Content-type':'application/json;charset=UTF-8',
            'Authorization':'Bearer $token',

    };
    }

    void updateHeader(String token){
    _mainHeaders={
      'Content-type':'application/json;charset=UTF-8',
      'Authorization':'Bearer $token',
    };
    }
    Future<Response> getData(String uri,{Map<String,String>? headers}) async {
    try{
      Response response =await get(uri,
      headers: headers??_mainHeaders
      );
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
    }
    Future<Response> postData(String uri,dynamic body) async {
    print(body.toString());
    try{
     Response response=await post(uri,body,headers: _mainHeaders);
     print(response.toString());
     return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
    }
  }
  // import 'package:get/get.dart';
//
// class ApiClient extends GetConnect implements GetxService {
//   late Map<String, String> _mainHeaders;
//   final String appBaseUrl;
//
//   ApiClient({required this.appBaseUrl}) {
//     baseUrl = appBaseUrl;
//     timeout = Duration(seconds: 30);
//     _mainHeaders = {
//       'Content-type': 'application/json;charset=UTF-8',
//     };
//   }
//
//   Future<Response> getData(String uri) async {
//     if (_mainHeaders.containsKey('Authorization')) {
//       try {
//         Response response = await get(uri, headers: _mainHeaders);
//         return response;
//       } catch (e) {
//         return Response(statusCode: 1, statusText: e.toString());
//       }
//     } else {
//       return Response(
//           statusCode: 401,
//           statusText: 'Unauthorized: Token is required for this request.');
//     }
//   }
// }
