import 'package:florist_app/utils/dimensions.dart';
import 'package:florist_app/widgets/app_icon.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key,required this.appIcon,required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color:Colors.white ,
      padding: EdgeInsets.only(left: Dimensions.width20,
      top:  Dimensions.width10,
        bottom: Dimensions.width10,
      ),
      child:Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText,

        ],
      ),
        decoration: BoxDecoration(
          //them vo
            color:Colors.white ,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0,2),
              color: Colors.grey.withOpacity(0.2),
            )
        ]
    ),
    );
  }
}
