import 'package:florist_app/utils/colors.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:florist_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import 'flower_page_body.dart';


class MainFlowerPage extends StatefulWidget {
  const MainFlowerPage({super.key});

  @override
  State<MainFlowerPage> createState() => _MainFlowerPageState();
}

class _MainFlowerPageState extends State<MainFlowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          //show the header
          Container(

            child: Container(
              margin: EdgeInsets.only(top:Dimensions.height45, bottom: Dimensions.height15),
              padding:EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Column(
                    children: [
                     BigText(text: "VietNam",color: AppColors.mainColor),
                     Row(
                       children: [
                         SmallText(text: "DaNang",color: Colors.black54),
                         Icon(Icons.arrow_drop_down_rounded)
                       ],
                     )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      child: Icon(Icons.search,color: Colors.white,size:Dimensions.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(Dimensions.radius15),
                        color:AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //show the body
          Expanded(child: SingleChildScrollView(
            child: FlowerPgeBody(),
          ))
        ],
      ),
    );

  }
}
