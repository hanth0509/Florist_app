import 'package:florist_app/controllers/cart_controller.dart';
import 'package:florist_app/controllers/popular_product_controller.dart';
import 'package:florist_app/controllers/recommended_product_controller.dart';
import 'package:florist_app/pages/Flower/popular_flower_detail.dart';
import 'package:florist_app/pages/Flower/recommended_flower_detail.dart';
import 'package:florist_app/pages/auth/sign_in_page.dart';
import 'package:florist_app/pages/auth/sign_up_page.dart';
import 'package:florist_app/pages/cart/cart_page.dart';
import 'package:florist_app/pages/home/flower_page_body.dart';
import 'package:florist_app/pages/home/main_flower_page.dart';
import 'package:florist_app/pages/splash/splash_page.dart';
import 'package:florist_app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'helper/dependencies.dart'as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();//giu lai du lieu cu
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder <RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          // home: SplashScreen(),
          // home:MainFlowerPage(),
          // home:SignInPage(),

          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}





