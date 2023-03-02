import 'package:arrows/components/loading_spinner.dart';
import 'package:arrows/components/phone_number_field.dart';
import 'package:arrows/constants/colors.dart';
import 'package:arrows/modules/sign_up/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../components/custom_button.dart';
import '../../../helpers/shared_prefrences.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());

  final translateName = CacheHelper.getDataToSharedPrefrence("localeIsArabic");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child:  Padding(
                    padding: EdgeInsets.all(15.w),
                    child:Form(
                      key: signUpController.formKey,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          SvgPicture.asset(
                            "assets/images/login.svg",
                            width: 200.w,
                            height: 400.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          PhoneNumberField(
                            controller: signUpController.phoneTextEditingController,
                            onChange: (PhoneNumber number)async{
                              signUpController.fullPhoneNumber = number.phoneNumber;

                            }, ),
                          SizedBox(
                            height: 10.h,
                          ),
                          GetBuilder<SignUpController>(
                            init: SignUpController(),
                            builder: (signUpController)=>  Directionality(
                              textDirection: translateName?TextDirection.rtl:TextDirection.ltr,
                              child:Container(
                                width: 348.w,
                                height: 100.h,
                                child:  TextFormField(
                                  style: TextStyle(color: mainColor,fontSize: 18.sp,fontWeight: FontWeight.bold ),
                                  keyboardType: TextInputType.name,


                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'please_enter_your_user_name'.tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (newValue) async{
                                    signUpController.userNameTextEditingController =
                                        newValue;
                                    // CacheHelper.loginShared!.name=newValue;
                                  },
                                  decoration:

                                  InputDecoration(
                                    hintText: "user_name".tr,
                                    filled: true,
                                    fillColor: Colors.white,

                                    isDense: true,
                                    // Added this
                                    contentPadding: EdgeInsets.all(10.sp),
                                    hintStyle: TextStyle(color: mainColor, fontSize: 16.sp),
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
                            ),
                          ),

                          Button(
                            text: "register_user".tr,
                            onPressed: () async {
                              if (signUpController.formKey.currentState!
                                  .validate()) {
                                showLoaderDialog(context);
                                // await signUpController.sendVerificationCode(phone:'+201112134871'
                                await signUpController.sendVerificationCode(phone:signUpController.fullPhoneNumber
                                    ,name:signUpController.userNameTextEditingController );
                              }
                            }, isFramed: false,
                            height: Get.height/20.h,
                            fontSize: 14,
                            size: 250,),
                        ],
                      ),
                    )
                  )),
            ),
          ),
    );
  }
}
