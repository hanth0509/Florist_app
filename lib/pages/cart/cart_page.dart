

import 'package:florist_app/controllers/auth_controller.dart';
import 'package:florist_app/controllers/cart_controller.dart';
import 'package:florist_app/controllers/location_controller.dart';
import 'package:florist_app/controllers/popular_product_controller.dart';
import 'package:florist_app/utils/app_constants.dart';
import 'package:florist_app/widgets/app_icon.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:florist_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../Flower/recommended_flower_detail.dart';
import '../home/flower_page_body.dart';
import '../home/main_flower_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // header
          Positioned(
            top:Dimensions.height20*3,
            left: Dimensions.width20,
              right: Dimensions.width20,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Get.toNamed(RouteHelper.getInitial());
                        // Get.to(()=> MainFlowerPage());
                      },
                      child: AppIcon(icon:Icons.arrow_back_ios,
                      iconColor:Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize:Dimensions.iconSize24 ,
                      ),
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    GestureDetector(
                      onTap:(){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon:Icons.home_outlined,
                        iconColor:Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize:Dimensions.iconSize24 ,
                      ),
                    ),
                    AppIcon(icon:Icons.shopping_cart,
                      iconColor:Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:Dimensions.iconSize24 ,
                    ),
                  ],
          )),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top:Dimensions.height20*5,
                right: Dimensions.width20,
                left: Dimensions.width20,
                bottom: 0,
                child:Container(
                  margin:EdgeInsets.only(top: Dimensions.height15) ,
                  // color:Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder:(cartController){
                      var _cartList=cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20*5,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex=Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFlower(popularIndex,"cartpage"));
                                      }else{
                                        var recommendedIndex=Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar("History product", "Product review is not available for history products ",
                                            backgroundColor: AppColors.mainColor,
                                            colorText:Colors.white,
                                          );
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFlower(recommendedIndex,"cartpage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.width20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!,
                                            ),
                                          ),
                                          borderRadius:BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text:cartController.getItems[index].name!,color: Colors.black54),
                                        SmallText(text:"Spicy" ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text:"\$ "+cartController.getItems[index].price.toString(),color:Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },

                                                      child: Icon(Icons.remove,color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  BigText(text:_cartList[index].quantity.toString()),// popularProduct.inCartItems.toString()),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                        print("being tapped");
                                                      },

                                                      child: Icon(Icons.add,color: AppColors.signColor,)),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ) ):NoDataPage(text:"Your cart is empty! ");
          })
        ],
      ),
        //bottom bar
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [

                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "\$ "+cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    if(Get.find<AuthController>().userLoggedIn()){
                      // print("logged in?");
                      // if(Get.find<LocationController>().addressList.isEmpty){
                      //   Get.toNamed(RouteHelper.getAddressPage());
                      // }else{
                      //   Get.offNamed(RouteHelper.getInitial());
                      // }
                      cartController.addToHistory();
                    }else{
                      Get.toNamed(RouteHelper.getSignInPage());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                    child: BigText(text: "  Checkout",color: Colors.white,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ):Container(),
          );
        },)
    );
  }
}
