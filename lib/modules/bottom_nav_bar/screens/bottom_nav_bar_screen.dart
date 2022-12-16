import 'package:arrows/components/arrows_app_bar.dart';
import 'package:arrows/components/arrows_bottom_nav_bar.dart';
import 'package:arrows/constants/colors.dart';
import 'package:arrows/modules/bottom_nav_bar/controllers/bottom_nav_bar_controller.dart';
import 'package:arrows/modules/cart/controllers/cart_controller.dart';
import 'package:arrows/modules/cart/screens/cart_screen.dart';
import 'package:arrows/modules/home/screens/home_screen.dart';
import 'package:arrows/modules/main_category/screens/main_categories_screen.dart';
import 'package:arrows/modules/more_info/screens/more_info_screen.dart';
import 'package:arrows/modules/order_history/screens/order_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrows/constants/more_info_constants.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../helpers/connectivity.dart';
import '../../Items Screen/new_sub_category_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavBarController = Get.put(BottomNavBarController());
    final cartController = Get.put(CartController());

    final List _bodyScreens = [
      NewSubCategoryScreen(),
      // MainCategoryScreen(),
      OrderHistoryScreen(),
      HomeScreen(),
      CartScreen(),
      MoreInfoScreen(),
    ].obs;

    final List<String> title = <String>[
      'menu'.tr,
      'track_order'.tr,
      'home'.tr,
      'cart'.tr,
      '${k.restName}'.tr
    ].obs;

    final connection = Get.put(ConnectionStatusSingleton());
    return Scaffold(
        backgroundColor: Colors.white,
        key: bottomNavBarController.scaffoldKey,
        body: Obx(() => connection.connectivity.value == 1
            ? _bodyScreens[bottomNavBarController.currentIndex.value]
            : Scaffold(
                body: Center(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ic_no_connection.png',
                    height: 300.h,
                    width: 300.w,
                    color: mainColor,
                  ),
                  Text(
                    'no_connection'.tr,
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )))),
        bottomNavigationBar: Material(
          elevation: 2,
          child: Container(
            width: double.infinity,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => GestureDetector(
                      onTap: () {
                        bottomNavBarController.changeTabIndex(4);
                      },
                      child: Expanded(
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color:
                                bottomNavBarController.currentIndex.value == 4
                                    ? Colors.pinkAccent.shade100
                                    : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              bottomNavBarController.currentIndex.value == 4
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Image.asset(
                                        "assets/icons/ic_more.png",
                                        width: 25,
                                        height: 25,
                                        color: bottomNavBarController
                                                    .currentIndex.value ==
                                                4
                                            ? Colors.white
                                            : Colors.black,
                                      ))
                                  : Image.asset(
                                      "assets/icons/ic_more.png",
                                      width: 25,
                                      height: 25,
                                      color: bottomNavBarController
                                                  .currentIndex.value ==
                                              4
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              bottomNavBarController.currentIndex.value == 4
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Text("more_info".tr,
                                          style: TextStyle(
                                              color: bottomNavBarController
                                                          .currentIndex.value ==
                                                      4
                                                  ? Colors.white
                                                  : Colors.black)),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )),
                Obx(() => GestureDetector(
                      onTap: () {
                        bottomNavBarController.changeTabIndex(3);
                      },
                      child: Expanded(
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color:
                                bottomNavBarController.currentIndex.value == 3
                                    ? Colors.pinkAccent.shade100
                                    : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              bottomNavBarController.currentIndex.value == 3
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Image.asset(
                                        "assets/icons/ic_cart.png",
                                        width: 25,
                                        height: 25,
                                        color: bottomNavBarController
                                                    .currentIndex.value ==
                                                3
                                            ? Colors.white
                                            : Colors.black,
                                      ))
                                  : Image.asset(
                                      "assets/icons/ic_cart.png",
                                      width: 25,
                                      height: 25,
                                      color: bottomNavBarController
                                                  .currentIndex.value ==
                                              3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              bottomNavBarController.currentIndex.value == 3
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Text("cart".tr,
                                          style: TextStyle(
                                              color: bottomNavBarController
                                                          .currentIndex.value ==
                                                      3
                                                  ? Colors.white
                                                  : Colors.black)))
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )),
                Obx(() => GestureDetector(
                      onTap: () {
                        bottomNavBarController.changeTabIndex(2);
                      },
                      child: Expanded(
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color:
                                bottomNavBarController.currentIndex.value == 2
                                    ? Colors.pinkAccent.shade100
                                    : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              bottomNavBarController.currentIndex.value == 2
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Image.asset(
                                        "assets/icons/ic_home.png",
                                        width: 25,
                                        height: 25,
                                        color: bottomNavBarController
                                                    .currentIndex.value ==
                                                2
                                            ? Colors.white
                                            : Colors.black,
                                      ))
                                  : Image.asset(
                                      "assets/icons/ic_home.png",
                                      width: 25,
                                      height: 25,
                                      color: bottomNavBarController
                                                  .currentIndex.value ==
                                              2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              bottomNavBarController.currentIndex.value == 2
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Text("home".tr,
                                          style: TextStyle(
                                              color: bottomNavBarController
                                                          .currentIndex.value ==
                                                      2
                                                  ? Colors.white
                                                  : Colors.black)))
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )),
                Obx(() => GestureDetector(
                      onTap: () {
                        bottomNavBarController.changeTabIndex(1);
                      },
                      child: Expanded(
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color:
                                bottomNavBarController.currentIndex.value == 1
                                    ? Colors.pinkAccent.shade100
                                    : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              bottomNavBarController.currentIndex.value == 1
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Image.asset(
                                        "assets/icons/track.png",
                                        width: 25,
                                        height: 25,
                                        color: bottomNavBarController
                                                    .currentIndex.value ==
                                                1
                                            ? Colors.white
                                            : Colors.black,
                                      ))
                                  : Image.asset(
                                      "assets/icons/track.png",
                                      width: 25,
                                      height: 25,
                                      color: bottomNavBarController
                                                  .currentIndex.value ==
                                              1
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              bottomNavBarController.currentIndex.value == 1
                                  ? Text("track_order".tr,
                                      style: TextStyle(
                                          color: bottomNavBarController
                                                      .currentIndex.value ==
                                                  1
                                              ? Colors.white
                                              : Colors.black))
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )),
                Obx(() => GestureDetector(
                      onTap: () {
                        bottomNavBarController.changeTabIndex(0);
                      },
                      child: Expanded(
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color:
                                bottomNavBarController.currentIndex.value == 0
                                    ? Colors.pinkAccent.shade100
                                    : Colors.transparent,
                          ),
                          child: Column(
                            children: [
                              bottomNavBarController.currentIndex.value == 0
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Image.asset(
                                        "assets/icons/ic_menu.png",
                                        width: 25,
                                        height: 25,
                                        color: bottomNavBarController
                                                    .currentIndex.value ==
                                                0
                                            ? Colors.white
                                            : Colors.black,
                                      ))
                                  : Image.asset(
                                      "assets/icons/ic_menu.png",
                                      width: 25,
                                      height: 25,
                                      color: bottomNavBarController
                                                  .currentIndex.value ==
                                              0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                              bottomNavBarController.currentIndex.value == 0
                                  ? ShowUpAnimation(
                                      animationDuration:
                                          Duration(milliseconds: 200),
                                      child: Text("menu".tr,
                                          style: TextStyle(
                                              color: bottomNavBarController
                                                          .currentIndex.value ==
                                                      0
                                                  ? Colors.white
                                                  : Colors.black)))
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        )
        // ArrowBottomNavBar(
        //   bottomNavBarController: bottomNavBarController,
        // ),
        );
  }
}
