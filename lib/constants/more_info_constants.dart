import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'colors.dart';

class k {
  static const restName = 'Mama\'s Tenders';
  static const restLogo = 'assets/images/logo1.png';
  static const appBarLogo = 'assets/images/logoappbar.png';
  static const restWebSite = 'Balloonz.com';

  static SizedBox sizedBoxH = SizedBox(
    height: 40.h,
  );
  static SizedBox sizedBoxW = SizedBox(
    width: 22.w,
  );
  static InputDecoration inputDecoration = InputDecoration(
    hintText: "".tr,
    filled: true,
    fillColor: Colors.white,

    isDense: true,
    // Added this
    contentPadding: EdgeInsets.all(20.w),
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
  );
}
