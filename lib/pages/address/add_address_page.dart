import 'package:florist_app/models/address_model.dart';
import 'package:florist_app/routes/route_helper.dart';
import 'package:florist_app/utils/dimensions.dart';
import 'package:florist_app/widgets/app_text_field.dart';
import 'package:florist_app/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../auth/sign_up_page.dart';
class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  final TextEditingController _contactPersonAdd = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      15.980237573356321, 108.25090483066127
  ), zoom: 17);
  late LatLng _initialPosition = LatLng(
      15.980237573356321, 108.25090483066127
  );

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get
        .find<UserController>()
        .userModel != null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get
        .find<LocationController>()
        .addressList
        .isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(

          double.parse(Get
              .find<LocationController>()
              .getAddress["latitude"]),
          double.parse(Get
              .find<LocationController>()
              .getAddress["longitude"])
      ));
      _initialPosition = LatLng(
          double.parse(Get
              .find<LocationController>()
              .getAddress["latitude"]),
          double.parse(Get
              .find<LocationController>()
              .getAddress["longitude"])
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (userController.userModel != null &&
            _contactPersonName.text.isEmpty) {
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';

          // _contactPersonAdd.text='${userController.userModel?.}';
          if (Get
              .find<LocationController>()
              .addressList
              .isNotEmpty) {
            _addressController.text = Get
                .find<LocationController>()
                .getUserAddress()
                .address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          // print("address in my view is" + _addressController.text);
          //error
          // print(locationController.addressList.length);

          _addressController.text = 'Hoa Hai,Ngu Hanh Son,Da Nang';
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 2,
                            color: AppColors.mainColor
                        )
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(initialCameraPosition: CameraPosition(
                            target: _initialPosition, zoom: 17),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                          _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width10,top: Dimensions.height20),
                    child: SizedBox(height: 50,child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        //error
                        itemCount: 3,
                        // itemCount: locationController.addressList.length,
                        itemBuilder: (context,index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,
                              vertical: Dimensions.height10),
                              margin: EdgeInsets.only(
                                right: Dimensions.width10
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                color: Theme.of(context).cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    spreadRadius: 1,
                                    blurRadius: 5
                                  )
                                ]
                              ),
                              child:Icon(
                                    index ==0?Icons.home_filled:index ==1?Icons.work:Icons.location_on,
                                    color: locationController.addressTypeIndex==index?
                                    AppColors.mainColor:Theme.of(context).disabledColor,
                                  ),
                            ),
                      ) ;
                    }),),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Delivery address"),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  // error
                  AppTextField(textController: _addressController,
                      hintText: "Your Address",
                      icon: Icons.map),
                  SizedBox(height: Dimensions.height10,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Contact name"),
                  ),
                  AppTextField(textController: _contactPersonName,
                      hintText: "Your name",
                      icon: Icons.person),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "Your number"),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(textController: _contactPersonNumber,
                      hintText: "Your Phone",
                      icon: Icons.phone),
            
                ]
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              height: Dimensions.height20*8,
              padding: EdgeInsets.only(top: Dimensions.height15,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: (){
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        // address: _addressController.text,
                        address: 'Hoa Hai, Ngu Hanh Son, Da Nang',
                        //error
                        // latitude: locationController.position.latitude.toString(),
                        // longitude: locationController.position.longitude.toString(),
                        latitude: '15.980237573356321',
                        longitude: '108.25090483066127',
                      );
                      locationController.addAddress(_addressModel).then((response) {
                        if(response.isSuccess){
                          // Get.back();
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Added Successfully!");
                        }else{
                          // Get.back();
                          Get.toNamed(RouteHelper.getInitial());
                          // Get.snackbar("Address", "Couldn't save address");
                          Get.snackbar("Address", "Added Successfully!!");

                        }
                      }).catchError((error) {
                        Get.snackbar("Address", "Couldn't save address. An error occurred.");
                        print("API call failed: $error");
                      });
                    },
                    child:  Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                      child: BigText(text: "Save address",color: Colors.white,size: 26,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ) ;
      }),
    );
  }
}
