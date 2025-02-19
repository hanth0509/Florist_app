import 'package:florist_app/base/custom_loader.dart';
import 'package:florist_app/controllers/auth_controller.dart';
import 'package:florist_app/controllers/cart_controller.dart';
import 'package:florist_app/controllers/location_controller.dart';
import 'package:florist_app/controllers/user_controller.dart';
import 'package:florist_app/routes/route_helper.dart';
import 'package:florist_app/utils/dimensions.dart';
import 'package:florist_app/widgets/account_widget.dart';
import 'package:florist_app/widgets/app_icon.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo().then((_) {
        print("User info fetched successfully");
      }).catchError((error) {
        print("Error fetching user info: $error");
      });
      print("User has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (_userLoggedIn) {
          if (userController.isLoading) {
            return Center(
              child: CustomLoader(),
            );
          } else {
            return Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: [
                  // Biểu tượng hồ sơ
                  AppIcon(
                    icon: Icons.person,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height45 + Dimensions.height30,
                    size: Dimensions.height15 * 10,
                  ),
                  SizedBox(height: Dimensions.height30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Tên
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: userController.userModel?.name ?? 'N/A',
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          // Số điện thoại
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: userController.userModel?.phone ?? 'N/A',
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          // Email
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: userController.userModel?.email ?? 'N/A',
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          // Địa chỉ
                          /* */
                          GetBuilder<LocationController>(builder: (locationController){
                            if(_userLoggedIn&&locationController.addressList.isEmpty){
                              return  GestureDetector(
                                onTap: (){
                                  Get.offNamed(RouteHelper.getAddressPage());
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Hoa Hai, Ngu Hanh Son, Da nang",
                                  ),
                                ),
                              );
                            }else{
                              return  GestureDetector(
                                onTap: (){
                                  Get.offNamed(RouteHelper.getAddressPage());
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "Hoa Hai, Ngu Hanh Son, Da Nang",
                                  ),
                                ),
                              );
                            }
                          }),



                          SizedBox(height: Dimensions.height20),
                          // Tin nhắn
                          AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.message_outlined,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: "Messages",
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().clearShareData();
                                Get.find<CartController>().clear();
                                Get.find<CartController>().clearCartHistory();
                                Get.offNamed(RouteHelper.getSignInPage());
                              } else {
                                print("You are logged out");
                              }
                            },
                            child: AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 5 / 2,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                text: "Logout",
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return Container(

            child: Center(
              child:Column(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*8,
                    margin:EdgeInsets.only(left: Dimensions.width20,right:Dimensions.width20 ) ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                            fit:BoxFit.cover ,
                            image: AssetImage(
                                "assets/image/signintocontinue.png"
                            )
                        )
                    ),
                  ),
                  SizedBox(height: Dimensions.height10*2,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                    
                      width: double.maxFinite,
                      height: Dimensions.height20*5,
                      margin:EdgeInsets.only(left: Dimensions.width20,right:Dimensions.width20 ) ,
                      decoration: BoxDecoration(
                        color:AppColors.mainColor ,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                    
                      ),
                      child:Center(child: BigText(text:"Sign in" ,color: Colors.white,size:Dimensions.font26 ,)),
                    ),
                  ),
                ],
              )
            ),
          );
        }
      }),
    );
  }
}
//
// class AccountPage extends StatelessWidget {
//   const AccountPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     bool _userLoggedIn =Get.find<AuthController>().userLoggedIn();
//     if(_userLoggedIn){
//       Get.find<UserController>().getUserInfo();
//       print("User has logged in");
//     }
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.mainColor,
//         title:
//            BigText(
//             text: "Profile",size: 24,color:Colors.white,
//           ),
//       ),
//       body: GetBuilder<UserController>(builder: (userController){
//         return _userLoggedIn?
//         (userController.isLoading?Container(
//           width: double.maxFinite,
//           margin: EdgeInsets.only(top: Dimensions.height20),
//           child: Column(
//
//             children: [
//               //profile icon
//               AppIcon(icon: Icons.person,
//                 backgroundColor: AppColors.mainColor,
//                 iconColor: Colors.white,
//                 iconSize: Dimensions.height45+Dimensions.height30,
//                 size: Dimensions.height15*10,
//               ),
//               SizedBox(height: Dimensions.height30,),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       //name
//                       AccountWidget(
//                           appIcon:AppIcon(icon: Icons.person,
//
//                             backgroundColor: AppColors.mainColor,
//                             iconColor: Colors.white,
//                             iconSize:Dimensions.height10*5/2,
//                             size: Dimensions.height10*5,
//                           ),
//
//                           bigText:BigText(text:userController.userModel!.name,)
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                       //phone
//                       AccountWidget(
//                           appIcon:AppIcon(icon: Icons.phone,
//
//                             backgroundColor: AppColors.yellowColor,
//                             iconColor: Colors.white,
//                             iconSize:Dimensions.height10*5/2,
//                             size: Dimensions.height10*5,
//                           ),
//
//                           bigText:BigText(text:userController.userModel!.phone,)
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                       //email
//                       AccountWidget(
//                           appIcon:AppIcon(icon: Icons.email,
//
//                             backgroundColor: AppColors.yellowColor,
//                             iconColor: Colors.white,
//                             iconSize:Dimensions.height10*5/2,
//                             size: Dimensions.height10*5,
//                           ),
//
//                           bigText:BigText(text:userController.userModel!.email,)
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                       //address
//                       AccountWidget(
//                           appIcon:AppIcon(icon: Icons.location_on,
//
//                             backgroundColor: AppColors.yellowColor,
//                             iconColor: Colors.white,
//                             iconSize:Dimensions.height10*5/2,
//                             size: Dimensions.height10*5,
//                           ),
//
//                           bigText:BigText(text:"Hoa Hai, Ngu Hanh Son, Da nang" ,)
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                       //message
//                       AccountWidget(
//                           appIcon:AppIcon(icon: Icons.message_outlined,
//
//                             backgroundColor: Colors.redAccent,
//                             iconColor: Colors.white,
//                             iconSize:Dimensions.height10*5/2,
//                             size: Dimensions.height10*5,
//                           ),
//
//                           bigText:BigText(text:"Messages" ,)
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                       GestureDetector(
//                         onTap: (){
//                           if(Get.find<AuthController>().userLoggedIn()){
//                             Get.find<AuthController>().clearShareData();
//                             Get.find<CartController>().clear();
//                             Get.find<CartController>().clearCartHistory();
//                             Get.offNamed(RouteHelper.getSignInPage());
//                           }else{
//                             print("you logged out");
//                           }
//
//                         },
//                         child:  AccountWidget(
//                             appIcon:AppIcon(icon: Icons.logout,
//                               backgroundColor: Colors.redAccent,
//                               iconColor: Colors.white,
//                               iconSize:Dimensions.height10*5/2,
//                               size: Dimensions.height10*5,
//                             ),
//
//                             bigText:BigText(text:"Logout" ,)
//                         ),
//                       ),
//                       SizedBox(height: Dimensions.height20,),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ):
//         CustomLoader()):
//         Container(child: Center(child: Text("You must login")));
//       }),
//     );
//   }
// }
