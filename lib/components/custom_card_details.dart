



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:arrows/constants/more_info_constants.dart';
import '../constants/colors.dart';
import 'cart_card.dart';

class CustomCardDetails extends StatelessWidget {
    CustomCardDetails({
    Key? key,
    required this.message,
    required this.image,
    required this.price,
    required this.total,
    required this.quantity,
    required this.name
  }) : super(key: key);
  String message;
  String image;
  String price;
  String total;
  String quantity;
  String name;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: mainColor, width: 3),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              height: 40.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: mainColor,
              ),
              child: Center(child: Text('$name',overflow:TextOverflow.ellipsis ,style:TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.white),),),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                k.sizedBoxW,
                Container(
                  width: 100.w,
                  height: 100.h,
                  child: Image.network('$image'),
                ),
                // k.sizedBoxW,
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.w,right: 10.w),
                    child: Column(
                      children: [
                        CartIngrediantRow(
                            textKey: 'price'.tr,
                            widget: Text(price.tr,
                              style: TextStyle(fontSize: 16.sp),
                            )),

                        CartIngrediantRow(
                          textKey: 'quantity'.tr,
                          widget: Text(quantity.tr,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                        Divider(
                          thickness: .7,
                          height: 2,
                          color: Colors.grey,
                        ),
                        CartIngrediantRow(
                          textKey: 'total'.tr,
                          widget: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              k.sizedBoxW,
                              Text(total.tr,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              // k.sizedBoxW,
                              Text(
                                'coin_jordan'.tr,
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 40.h,
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  border: Border.all(
                    color: mainColor,
                    width: 2,
                  )),
              child: Row(
                children: [
                  Container(
                    color: mainColor,
                    height: 40.h,
                    width: Get.width / 3,
                    child: Center(
                        child: Text('Messages',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                  k.sizedBoxW,
                  k.sizedBoxW,
                Text('$message',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: mainColor),),


                ],
              ),
            ),
          ],
        ));
  }
}
