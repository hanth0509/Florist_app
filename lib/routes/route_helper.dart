import 'package:florist_app/pages/Flower/popular_flower_detail.dart';
import 'package:florist_app/pages/Flower/recommended_flower_detail.dart';
import 'package:florist_app/pages/address/add_address_page.dart';
import 'package:florist_app/pages/auth/sign_in_page.dart';
import 'package:florist_app/pages/cart/cart_page.dart';
import 'package:florist_app/pages/home/main_flower_page.dart';
import 'package:florist_app/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RouteHelper{
  static const String splashPage="/splash-page";
  static const String initial="/";
  static const String popularFlower="/popular-flower" ;
  static const String recommendedFlower="/recommended-flower" ;
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";


  static const String addAddress="/add-address";

  //$ tham so
  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFlower(int pageId,String page)=>'$popularFlower?pageId=$pageId&page=$page';
  static String getRecommendedFlower(int pageId,String page)=>'$recommendedFlower?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';

  static List<GetPage> routes=[
    GetPage(name: splashPage, page: ()=>SplashScreen()),
    GetPage(name: initial, page: (){
      return HomePage();
    },transition:Transition.fade),
    GetPage(name: signIn, page: (){
      return SignInPage();
    },transition: Transition.fade),
  GetPage(name: popularFlower, page:(){
  var pageId=Get.parameters['pageId'];
  var page=Get.parameters['page'];
  return PopularFlowerDetail(pageId:int.parse(pageId!) ,page:page!);
  },
  transition: Transition.fadeIn
  ),

  GetPage(name: recommendedFlower, page:(){
  var pageId=Get.parameters['pageId'];
  var page=Get.parameters['page'];
  return RecommendedFlowerDetail(pageId:int.parse(pageId!),page:page!);
  },
  transition: Transition.fadeIn
  ),
  GetPage(name: cartPage, page: (){
  return CartPage();

  },
  transition:Transition.fadeIn
  ),
  GetPage (name: addAddress, page: (){
    return AddAddressPage();
    }),
  ];
  }

