import 'dart:async';
import 'dart:collection';
import 'package:arrows/components/arrows_app_bar.dart';
import 'package:arrows/constants/colors.dart';
import 'package:arrows/constants/styles.dart';
import 'package:arrows/helpers/geo_locator_helper.dart';
import 'package:arrows/helpers/shared_prefrences.dart';
import 'package:arrows/modules/add_address/controllers/add_address_controller.dart';
import 'package:arrows/modules/cart/controllers/cart_controller.dart';
import 'package:arrows/modules/reciept/screens/reciept_screen.dart';
import 'package:arrows/modules/sign_up/models/user_model.dart';
import 'package:arrows/modules/where_to_deliver/controllers/Where_to_controller.dart';
import 'package:arrows/modules/where_to_deliver/models/firebase_address_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../components/custom_address_text_field.dart';
import '../../../components/custom_button.dart';
import '../../more_info/controllers/more_info_controller.dart';
import '../../where_to_deliver/controllers/map_controller.dart';

class AddNewAddress extends StatelessWidget {
  AddNewAddress({Key? key}) : super(key: key);
  final AddAddressController addAddressController =
      Get.put(AddAddressController());
  final WhereToController whereToController = Get.put(WhereToController());
  final CartController cartController = Get.put(CartController());
  final MapController mapController = Get.put(MapController());
  final MoreInfoController moreInfoController = Get.put(MoreInfoController());

  @override
  Widget build(BuildContext context) {
    final landScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return WillPopScope(
      onWillPop: () async {
        return disposeMethod();
      },
      child: Scaffold(
        // backgroundColor: kPrimaryColor,
        appBar: ArrowsAppBar(
          "specify_address".tr,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                children: [
                  GetBuilder<MapController>(
                    init: MapController(),
                    builder: (controller) => Container(
                      padding: EdgeInsets.all(5.sp),
                      decoration: CommonStyles.customBoxDecoration,
                      width: double.infinity,
                      height: 500.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: MapController.initialPosition == null
                            ? Container(
                                child: Center(
                                  child: Text(
                                    'loading map..',
                                    style: TextStyle(
                                        fontFamily: 'Avenir-Medium',
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : FutureBuilder(
                                future: mapController.mapFuture,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    print("empty");
                                    return CircularProgressIndicator(
                                      color: mainColor,
                                    );
                                  }

                                  return GoogleMap(
                                    gestureRecognizers: Set()
                                      ..add(Factory<PanGestureRecognizer>(
                                          () => PanGestureRecognizer()))
                                      ..add(Factory<ScaleGestureRecognizer>(
                                          () => ScaleGestureRecognizer()))
                                      ..add(Factory<TapGestureRecognizer>(
                                          () => TapGestureRecognizer()))
                                      ..add(Factory<
                                              VerticalDragGestureRecognizer>(
                                          () =>
                                              VerticalDragGestureRecognizer())),
                                    mapType: MapType.normal,
                                    zoomControlsEnabled: true,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    zoomGesturesEnabled: true,
                                    markers: controller.markers.toSet(),
                                    mapToolbarEnabled: true,
                                    initialCameraPosition: CameraPosition(
                                        target: MapController.initialPosition!,
                                        zoom: 15),
                                    onCameraMove: controller.onCameraMove,
                                    onMapCreated: (GoogleMapController
                                        gcontroller) async {
                                      mapController.address;
                                       controller.showPinsOnMap(
                                          controller.currentLocation!);
                                      controller.controller
                                          .complete(gcontroller);
                                      mapController.getCurrentLocation();
                                    },
                                    onTap: (LatLng loc) {
                                      print(
                                          '${loc.latitude}, ${loc.longitude}');
                                      controller.getUserLocation(loc);
                                      controller.showPinsOnMap(loc);
                                    },
                                  );
                                }),
                      ),
                    ),
                  ),
                  GetBuilder<MapController>(
                    init: MapController(),
                    builder: (controller) => Container(
                      padding: EdgeInsets.all(5.sp),
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: Center(
                        // child: MapController.initialPosition == null  ? Text('loading ')
                        child: mapController.isLoading.value==true   ? Text('loading... ',style: TextStyle(fontSize: 14.sp,  color: Colors.white),)
                          :Text(
                                '${mapController.address.street}${mapController.address.administrativeArea}${mapController.address.country}'
                                    .tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )

                      ),
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          width: 3,
                          color: mainColor,
                          style: BorderStyle.solid,
                        ),
                        color: mainColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
                    margin: EdgeInsets.only(top: 0.h, bottom: 10.h),
                    decoration: CommonStyles.customBoxDecoration,
                    child: Column(
                      children: [
                        /*************firstRow***********/

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                width: ScreenUtil.defaultSize.width,
                                height: !landScape ? 55.h : 40.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: mainColor,
                                    )),
                                child: GetBuilder<WhereToController>(
                                    builder: (whereToController) {
                                  return  SizedBox(
                                      child: DropdownButton<dynamic>(
                                          underline: SizedBox(),
                                          isExpanded: true,
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: mainColor),
                                          items: whereToController
                                              .deliveryAreaList!
                                              .map((element) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                '${element.area}'.tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.sp,
                                                     color: mainColor),
                                              ),
                                              value: element,
                                            );
                                          }).toList(),
                                          value: whereToController
                                              .selectedDropDownValue,
                                          onChanged: (value) {
                                            whereToController
                                                .selectedDropDownValue = value;
                                            whereToController.selectedAreaPrice
                                                .value = value.price;
                                            whereToController.update();
                                            print(whereToController
                                                .selectedDropDownValue?.price);
                                          }),

                                  );
                                }),
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 10.w, top: 10.h, bottom: 10.h),
                                child: CustomAddressTextField(
                                  textEditingController:
                                      whereToController.areaNumber,
                                  hintText: "area_number",
                                  labelText: "area_number",
                                ),
                              ),
                            ),
                          ],
                        ),

                        /**************test***********/
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            /******************apartment number*****************/
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 10.h, bottom: 10.h),
                                child: CustomAddressTextField(
                                  textEditingController:
                                      whereToController.floorNumber,
                                  hintText: "floor_number",
                                  labelText: "floor_number",
                                ),
                              ),
                            ),
                            /******************building number*****************/
                            SizedBox(width: 5.w,),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 10.w, top: 10.h, bottom: 10.h),
                                child: CustomAddressTextField(
                                  textEditingController:
                                      whereToController.buildNumber,
                                  hintText: "building_number",
                                  labelText: "building_number",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: CustomAddressTextField(
                            textEditingController:
                                whereToController.addressTextController,
                            hintText: "address",
                            labelText: "address",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    text: 'add_address'.tr,
                    size: 250,
                    fontSize: 14,

                    height:!landScape ? Get.height/15.h : 100.h,
                    onPressed: ()async {

                      LocationPermission permission =
                      await Geolocator.checkPermission();
                      if (whereToController.areaNumber.text.isEmpty &&
                          whereToController.buildNumber.text.isEmpty &&
                          whereToController.floorNumber.text.isEmpty) {
                        Get.defaultDialog(title: '', content: Text('data'.tr),);
                      }
                      else if (whereToController.selectedDropDownValue!.id == '0') {
                        Get.defaultDialog(
                            content: Text('neighbourhood'.tr), title: "");}
                      else if ((permission == LocationPermission.denied || permission == LocationPermission.deniedForever) && whereToController.addressTextController.text.isEmpty) {
                        Get.defaultDialog(title: "", content: Text("enter_address".tr));}
                      else if ((permission == LocationPermission.denied || permission == LocationPermission.deniedForever) && whereToController.addressTextController.text.isNotEmpty) {

                        var newAddress=UserAddress();
                        newAddress = UserAddress(
                            address: whereToController.addressTextController.text,
                            buildNumber: whereToController.buildNumber.text,
                            floorNumber: whereToController.floorNumber.text,
                            areaNumber: whereToController.areaNumber.text,
                            landmark:whereToController.addressTextController.text,
                            lat: "",
                            lng: "",
                            area: whereToController.selectedDropDownValue);

                        var user = User(
                            password: CacheHelper.loginShared!.password,
                            phone: CacheHelper.loginShared!.phone,
                            name: CacheHelper.loginShared!.name,
                            id: CacheHelper.loginShared!.id,
                            userDeviceToken:CacheHelper.loginShared!.userDeviceToken,
                            points:cartController.totalPoints!='0'?cartController.totalPoints.toString():0.toString(),
                            address: addAddressController.addresses);

                        await FirebaseDatabase.instance
                            .reference()
                            .child("Users")
                            .child(CacheHelper.getDataToSharedPrefrence('userID'))
                            .child("user_address_list")
                            .get()
                            .then((  snapshot) {
                          if (snapshot.exists) {
                            for (Map<dynamic, dynamic> data in snapshot.value) {
                              addAddressController.addresses
                                  .add(UserAddress.fromJson(data));
                            }}
                          addAddressController.addresses.add(newAddress);
                        });
                        ///adds to the index 0 only
                        FirebaseDatabase.instance
                            .reference()
                            .child("Users")
                            .child(CacheHelper.getDataToSharedPrefrence('userID'))
                            .set(user.toJson());
                        CacheHelper.saveDataToSharedPrefrence(
                            'dropDownValuePrice',
                            whereToController.selectedDropDownValue?.price);
                        whereToController.buildNumber.clear();
                        whereToController.floorNumber.clear();
                        whereToController.landscape.clear();
                        whereToController.areaNumber.clear();
                        addAddressController.addresses.clear();
                        whereToController.addressTextController.clear();
                        Get.to(ReceiptScreen(
                            selectedAreaPrice:
                            CacheHelper.getDataToSharedPrefrence(
                                'dropDownValuePrice')));

                      }
                      /*****the previous was the same*****/
                      else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
                        addAddressController.addresses.clear();
                        Position position =
                        await GeoLocatorHelper.determinePosition();
                        addAddressController.location =
                        'Lat: ${position.latitude}, Long: ${position.longitude}';
                        await GeoLocatorHelper.getAddressFromLatLong(
                            position);
                        print(position.latitude);

                        var   newAddress = UserAddress(
                          // address:GeoLocatorHelper.address,
                            address:'${mapController.address.street}${mapController.address.administrativeArea}${mapController.address.country}',
                            buildNumber: whereToController.buildNumber.text,
                            floorNumber: whereToController.floorNumber.text,
                            landmark: whereToController.addressTextController.text,
                            areaNumber: whereToController.areaNumber.text,
                            lat: position.latitude.toString(),
                            lng: position.longitude.toString(),
                            area: whereToController.selectedDropDownValue);

                        var user = User(
                            password: CacheHelper.loginShared!.password,
                            phone: CacheHelper.loginShared!.phone,
                            name: CacheHelper.loginShared!.name,
                            id:CacheHelper.loginShared!.id,
                            points: cartController.totalPoints!='0'?cartController.totalPoints.toString():CacheHelper.loginShared!.points,
                            address: addAddressController.addresses,
                            userDeviceToken:CacheHelper.loginShared!.userDeviceToken
                        );

                        CacheHelper.loginShared!.address=addAddressController.addresses;

                        await FirebaseDatabase.instance
                            .reference()
                            .child("Users")
                            .child(CacheHelper.getDataToSharedPrefrence('userID'))
                        // .child(CacheHelper.getDataToSharedPrefrence('userID'))
                            .child("user_address_list")
                            .get()
                            .then((  snapshot) {
                          if (snapshot.exists) {
                            for (Map<dynamic, dynamic> data in snapshot.value) {
                              addAddressController.addresses
                                  .add(UserAddress.fromJson(data));
                            }
                          }
                        });
                        addAddressController.addresses.add(newAddress);

                        ///adds to the index 0 only

                        await FirebaseDatabase.instance
                            .reference()
                            .child("Users")
                            .child(CacheHelper.getDataToSharedPrefrence(
                            'userID'))

                            .set(user.toJson()).then((value) {

                          return    Get.snackbar('Done', 'an  address added successfully ',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: kPrimaryColor,
                              duration: Duration(seconds: 2),
                              dismissDirection: DismissDirection.startToEnd,
                              barBlur: 10,
                              colorText: mainColor);
                        });
                        CacheHelper.saveDataToSharedPrefrence(
                            'dropDownValuePrice',
                            whereToController.selectedDropDownValue?.price);

                        whereToController.buildNumber.clear();
                        whereToController.floorNumber.clear();
                        whereToController.landscape.clear();
                        whereToController.addresses.clear();
                        whereToController.areaNumber.clear();
                        whereToController.addressTextController.clear();
                        whereToController.update();
                        print(CacheHelper.getDataToSharedPrefrence('user'));

                        Get.off(ReceiptScreen(selectedAreaPrice: CacheHelper.getDataToSharedPrefrence('dropDownValuePrice')));

                        disposeMethod();}

                    },
                    isFramed: false,

                  ) ,
                  /**********************************arrows3*************/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  disposeMethod() {
    print('yamosaheellll');
    Get.back();
    whereToController.buildNumber.clear();
    whereToController.floorNumber.clear();
    whereToController.landscape.clear();
    whereToController.areaNumber.clear();
    whereToController.selectedDropDownValue;
    whereToController.addressTextController.clear();
    whereToController.addresses.clear();
    mapController.dispose();
    mapController.onClose();
    mapController.markers[mapController.myMarkerId] = Marker(
        markerId: MarkerId(mapController.myMarkerId.toString()),
        visible: false);
  }
}
