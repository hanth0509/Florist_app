import 'package:florist_app/base/custom_loader.dart';
import 'package:florist_app/pages/auth/sign_up_page.dart';
import 'package:florist_app/routes/route_helper.dart';
import 'package:florist_app/utils/colors.dart';
import 'package:florist_app/utils/dimensions.dart';
import 'package:florist_app/widgets/app_text_field.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {

  const SignInPage({super.key,});

  @override
  Widget build(BuildContext context) {
    // var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var passwordController=TextEditingController();

    void _login(AuthController authController){
      // var authController =Get.find<AuthController>();
      String _phone =phoneController.text.trim();
      String _password=passwordController.text.trim();
      // String email= emailController.text.trim();
      // String password= passwordController.text.trim();
      // print("Name value: $name");
      if(_phone.isEmpty){
        showCustomSnackBar('enter_your_phone_number'.tr);
        return;
      }else if(_phone.length<6){
        showCustomSnackBar('enter_a_valid_phone_number'.tr);
        return;
      }else if(_password.isEmpty){
        showCustomSnackBar('enter_password'.tr);
        return;
      }
          authController.login(_phone,_password).then((status) async{
          if(status.isSuccess){
            // authController.saveUserNumberAndPassword(_phone, _password);
            // String _token=status.message.substring(1,status.message.length);
            Get.offNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getCartPage());
          }else{
            Get.snackbar("Wrong",status.message);
            // showCustomSnackBar(status.message);
          }
        });

    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
       return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height:Dimensions.screenHeight*0.05 ,),
              //logo
              Container(
                height:Dimensions.screenHeight*0.25 ,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor:Colors.white,
                    radius: 60,
                    backgroundImage:AssetImage(
                        "assets/image/logo_flower.png"
                    ) ,
                  ),
                ),
              ),
              // Welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: Dimensions.font20+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,

                      ),

                    ),
                    Text(
                      "Sign in your account ",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),

                    ),

                  ],
                ),
              ),
              SizedBox(height:Dimensions.screenHeight*0.05 ,),
              //email
              AppTextField(textController: phoneController,
                  hintText: "Phone", icon: Icons.phone_android_outlined),
              SizedBox(height: Dimensions.height10,),
              //password
              AppTextField(textController: passwordController,
                  hintText: "Password", icon: Icons.password_sharp,isObscure: true),
              SizedBox(height: Dimensions.height20,),
              //tag line
              Row(
                children: [
                  Expanded(child: Container(

                  )),
                  RichText(
                      text: TextSpan(
                        // recognizer:TapGestureRecognizer()..onTap()=>Get.back(),
                          text:"Sign into your account ",
                          //   text:"Do not have an account?",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //Button Sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color:AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      // text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                    // recognizer:TapGestureRecognizer()..onTap()=>Get.back(),
                      text:"Don\'t an account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                          recognizer:TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                          text:" Create",

                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20
                          ),
                        )
                      ]
                  )),

            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
