import 'package:dots_indicator/dots_indicator.dart';
import 'package:florist_app/controllers/recommended_product_controller.dart';
import 'package:florist_app/pages/Flower/popular_flower_detail.dart';
import 'package:florist_app/routes/route_helper.dart';
import 'package:florist_app/utils/colors.dart';
import 'package:florist_app/widgets/app_column.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:florist_app/widgets/icon_and_text_widget.dart';
import 'package:florist_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';


class FlowerPgeBody extends StatefulWidget {
  const FlowerPgeBody({super.key});

  @override
  State<FlowerPgeBody> createState() => _FlowerPgeBodyState();
}

class _FlowerPgeBodyState extends State<FlowerPgeBody> {
  PageController pageController=PageController(viewportFraction: 0.85);
  var _currPageValue=0.0;
  double _scaleFacto=0.8;
  double _height=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue= pageController.page!;
        print("Current value is "+_currPageValue.toString());
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return popularProducts.isLoaded?Container(
            // color: Colors.redAccent,
            height:Dimensions.pageView ,

              child: PageView.builder(
                
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,popularProducts.popularProductList[position]);
                  }),

          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
          //moi sua
            position:_currPageValue.round(),
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //Popular text
        SizedBox(height:Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              // BigText(text: "Popular"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".",color:Colors.black26),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Flower pairing",),
              )
            ],
          ),
        ),
        //recommended flower
        //List of flower and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded?ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProduct.recommendedProductList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFlower(index,"home"));
                  },
                  child: Container(
                    margin:EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
                    child:Row(
                      children: [
                        //image section
                        Container(
                          width:Dimensions.listViewImgSize,
                          height:Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  // image: AssetImage(
                                  //     "assets/image/food0.png"
                                  // )
                                  image: NetworkImage(
                                   AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!
                                   )
                              )
                          ),
                        ),
                        //text container
                        Expanded(
                          child: Container(
                            height:Dimensions.listViewTextContSize,
                  
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20)
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "With chinese characteristics"),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndTextWidget(icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.iconColor2)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                  
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        })


      ],
    );
  }
  Widget _buildPageItem(int index, popularProduct){
    Matrix4 matrix =new Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale= 1-(_currPageValue-index)*(1-_scaleFacto);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currScale,0);
    }else if(index==_currPageValue.floor()+1){
      var currScale= _scaleFacto+(_currPageValue-index+1)*(1-_scaleFacto);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currScale,0);
    }else if(index==_currPageValue.floor()-1){
      var currScale= 1-(_currPageValue-index)*(1-_scaleFacto);
      var currTrans=_height*(1-currScale)/2;
      matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currScale,0);
    }else{
      var currScale=0.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFacto)/2, 1);
    }

    return Transform(
      transform:matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFlower(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin:EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image:DecorationImage(
                      fit:BoxFit.cover ,
                      image:NetworkImage(
                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                          // "assets/image/food0.png"
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment:Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin:EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom:Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)
                    ),
                  ]
              ),
              child: Container(
                padding: EdgeInsets.only(top:Dimensions.height15,left:Dimensions.height15,right:Dimensions.height15 ),
                child: AppColumn(text:popularProduct.name!),
              ),

            ),
          )
        ],
      ),
    );
  }
}
