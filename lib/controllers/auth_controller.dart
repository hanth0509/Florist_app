import 'dart:convert';

import 'package:florist_app/data/repository/auth_repo.dart';
import 'package:florist_app/models/response_model.dart';
import 'package:florist_app/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
});

  bool _isLoading=false;
  bool get isLoading => _isLoading;

Future<ResponseModel>  registration(SignUpBody signUpBody) async {
    _isLoading=true;
    update();
   Response response=await authRepo.registration(signUpBody);
   // print("my response is ${response.body["errors"]}");
   late ResponseModel responseModel;
   if(response.statusCode==200){
        authRepo.saveUserToken(response.body["token"]);
        print("My token is "+ response.body["token"]);
        responseModel=ResponseModel(true, response.body["token"]);
   }else{
     print("error");
     responseModel=ResponseModel(false, response.statusText!);
     // responseModel=ResponseModel(false, response.body["errors"][0]);
   }
   _isLoading=false;
   update();
   return responseModel;
  }

  Future<ResponseModel>login(String phone,String password) async {
    // print("Getting token");
    // print(jsonEncode(authRepo.getUserToken().toString()));
    // print(authRepo.getUserToken().toString());
    _isLoading=true;
    update();
    Response response=await authRepo.login(phone,password);
    // print("my response is ${response.body["errors"][0]["message"]}");
    late ResponseModel responseModel;
    if(response.statusCode==200){
      // print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      // print(response.body["token"].toString());
      // await authRepo.updateToken();
      responseModel=ResponseModel(true,
          response.body["token"]);
    }else{
      // responseModel=ResponseModel(false, response.statusText!);
      responseModel=ResponseModel(false, response.body["errors"][0]["message"]);
    }
    _isLoading=false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number,String password)  {
    authRepo.saveUserNumberAndPassword(number, password);
  }
  bool userLoggedIn(){
    return authRepo.userLoggedIn();
  }
  bool clearShareData(){
    return authRepo.clearSharedData();
  }
}