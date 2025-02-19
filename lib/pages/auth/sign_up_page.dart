import 'package:florist_app/base/custom_loader.dart';
import 'package:florist_app/base/show_custom_snackbar.dart';
import 'package:florist_app/controllers/auth_controller.dart';
import 'package:florist_app/models/signup_body_model.dart';
import 'package:florist_app/pages/auth/sign_in_page.dart';
import 'package:florist_app/utils/colors.dart';
import 'package:florist_app/utils/dimensions.dart';
import 'package:florist_app/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    var signUpImages=[
      "t.png",
      "f.png",
      "g.png",
    ];
    //trim remove whitespaces
    void _registration(AuthController authController){
      // var authController =Get.find<AuthController>();
      String name= nameController.text.trim();
      String phone= phoneController.text.trim();
      String email= emailController.text.trim();
      String password= passwordController.text.trim();
      // print("Name value: $name");
      if(name.isEmpty){
        showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone",title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email address",title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address",title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: "Password");
      }else{
        // showCustomSnackBar("All went well",title: "Perfect");
        SignUpBody signUpBody=SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
             print(signUpBody.toString());
            authController.registration(signUpBody).then((status){
              // print("A"+status.toString()+"a");
              if(status.isSuccess){
                print("Success registration");
                Get.offNamed(RouteHelper.getInitial());
              }else{
                showCustomSnackBar(status.message);
                // Get.offNamed(RouteHelper.getInitial());
                // print("error:<<<");
              }
            });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              //email
              AppTextField(textController: emailController,
                  hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height10,),
              //password
              AppTextField(textController: passwordController,
                  hintText: "Password", icon: Icons.password_sharp,isObscure:true),
              SizedBox(height: Dimensions.height10,),
              // name
              AppTextField(textController: nameController,
                  hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height10,),
              //phone
              AppTextField(textController: phoneController,
                  hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.height10*2,),
              //Sign up button
              GestureDetector(
                onTap:(){
                  _registration(_authController);
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
                      text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(
                  text: TextSpan(
                      recognizer:TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage(),transition: Transition.fade),
                      text:"Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                  text: TextSpan(
                      text:"Sign up using of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
