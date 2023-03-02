import 'package:arrows/modules/add_address/screens/add_address_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:arrows/constants/more_info_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../components/arrows_app_bar.dart';
import '../../components/custom_button.dart';
import '../../constants/colors.dart';
import '../../helpers/shared_prefrences.dart';
import 'controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final translateName = CacheHelper.getDataToSharedPrefrence("localeIsArabic");
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ArrowsAppBar('${k.restName}'.tr),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child:Directionality(
              textDirection:
              translateName ? TextDirection.rtl : TextDirection.ltr,
              child:  Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                k.sizedBoxH,
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width/1.4.w,
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.name,
                            enabled: controller.enabled.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_your_user_name'.tr;
                              }
                              return null;
                            },
                            onChanged: (newValue) async {
                              // controller.userNameTextEditingController =
                              //     newValue;
                            },
                            decoration: InputDecoration(
                              hintText: "User Name".tr,
                              filled: true,
                              fillColor: Colors.white,
                              isDense: true,
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                size: 30.sp,
                                color: mainColor,
                              ),
                              contentPadding: EdgeInsets.all(20.w),
                              hintStyle:
                                  TextStyle(color: mainColor, fontSize: 16.sp),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mainColor,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mainColor,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mainColor,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: mainColor,
                              size: 30.sp,
                            ),
                            onPressed: () {
                              controller.isClicked();
                            }),
                      ],
                    )),
              SizedBox(height: 20.h,),
                Obx(
                  () =>  Container(
                    width: Get.width/1.4.w,
                        child: TextFormField(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          enabled: controller.enabled.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone number'.tr;
                            }
                            return null;
                          },
                          onChanged: (newValue) async {
                            // controller.userNameTextEditingController =
                            //     newValue;
                          },
                          decoration: InputDecoration(
                            hintText: "Mobile Number".tr,
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 30.sp,
                              color: mainColor,
                            ),
                            contentPadding: EdgeInsets.all(20.w),
                            hintStyle:
                            TextStyle(color: mainColor, fontSize: 16.sp),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: mainColor,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                      ),),

                SizedBox(height: 20.h,),

                Text(
                "your_address".tr,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  padding: EdgeInsets.all(  10.sp),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child:Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                   Container(
                      width:50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: IconButton(
                          onPressed: () {
                            // Get.to(ChatScreen());
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 25.sp,
                            color: Colors.red,
                          )),
                    ),
                      SizedBox(
                          width:Get.width/1.5.w,
                          child: Text('addresssaddresssaddresssaddresssaddresssaddresssaddresssaddresssaddresssaddresssaddresss',style: TextStyle( color:Colors.white,fontSize: 16.sp),)),

                    ],) ,
                ),
                Spacer(),
                Center(
                  child: Button(
                      isFramed: false,
                      text: '${'add_new_address'.tr} ',
                      fontSize: 16,
                      // size: 50,
                      size:   Get.width/1.4.w,
                      height:Get.height/20.h,

                      onPressed: ()async {
                        Get.to(AddNewAddress());

                      }),
                ),

              ],
            ),
            ),
          ),
        ));
  }
}
