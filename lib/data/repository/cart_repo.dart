import 'dart:convert';

import 'package:florist_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart=[];
  List<String> cartHistory=[];
  void addToCartList(List<CartModel> cartList){
      // sharedPreferences.remove(AppConstants.CART_LIST);
      // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time=DateTime.now().toString();
      cart=[];
      //convert objects to string because shared preference only accepts string
      // cartList.forEach((element)=>
      //   cart.add(jsonEncode(element))
      // );
      cartList.forEach((element){
        element.time=time;
        return cart.add(jsonEncode(element));
      });
      sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
      // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
      //   getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts=sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Inside getCartList"+ carts.toString());
    }

    List<CartModel> cartList=[];
    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });
    carts.forEach((element)=>cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory=[];
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> carListHistory=[];
    cartHistory.forEach((element) =>carListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return carListHistory;
  }
 void addToCartHistoryList(){

   if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
     cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
   }
    for(int i=0;i<cart.length;i++){
      print("history list "+cart[i]);
        cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("The lenght of history list is "+ getCartHistoryList().length.toString());
    for(int i=0;i<getCartHistoryList().length;i++){
      print("The time for the order is "+ getCartHistoryList()[i].time.toString());
    }
 }
  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
  void clearCarHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
