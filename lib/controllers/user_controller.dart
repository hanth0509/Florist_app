import 'package:florist_app/data/repository/user_repo.dart';
import 'package:florist_app/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';
class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading=false;
  // late UserModel _userModel;-1

  bool get isLoading => _isLoading;
  //luu thong tin nguoi dung
  // UserModel get userModel =>_userModel;-1
      UserModel? _userModel;
      UserModel? get userModel =>_userModel;
  Future<ResponseModel> getUserInfo() async {

    Response response=await userRepo.getUserInfo();
    // print("my response is ${response.body["errors"]}");
    late ResponseModel responseModel;
    print("test"+response.body.toString());
    if(response.statusCode==200){
      _userModel =UserModel.fromJson(response.body);
      _isLoading=true;
      responseModel=ResponseModel(true,"successfully");
    }else{
      responseModel=ResponseModel(false, response.statusText!);
    }
    _isLoading=false;
    update();
    return responseModel;
  }
}