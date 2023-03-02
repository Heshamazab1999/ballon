import 'package:arrows/constants/colors.dart';
import 'package:arrows/modules/home/models/ProductModel.dart';
import 'package:arrows/modules/sub_categories/controllers/sub_categories_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../components/loading_spinner.dart';
import '../../helpers/shared_prefrences.dart';
import '../favorite_screen/controller/fav_controller.dart';
import '../product_details/controllers/product_details_controller.dart';
import '../search/SearchModel.dart';
import '../sign_up/screens/sign_up_screen.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key, this.data}) : super(key: key);
  final ProductData? data;
  final controller = Get.put(ProductDetailsController());
  final subCategoriesController = Get.put(SubCategoriesController());
  final favoriteController = Get.put(FavoriteController());
  final translateName = CacheHelper.getDataToSharedPrefrence("localeIsArabic");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColor,
              size: 20.sp,
            )),
        title: Text(data!.name!,
            style: TextStyle(color: mainColor, fontSize: 20.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///88888888888
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  height: Get.height / 2.5.h,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    subCategoriesController.currentImageIndex.value = index;
                  }),
              items: data!.photo!
                  .map((item) => Container(
                      clipBehavior: Clip.antiAlias,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: mainColor, width: 2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: OctoImage(
                        image: CachedNetworkImageProvider(
                          item!,
                        ),
                        placeholderBuilder: OctoPlaceholder.blurHash(
                            'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                            fit: BoxFit.cover),
                        errorBuilder: (context, url, error) {
                          return BlurHash(hash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj');
                        },
                        fit: BoxFit.cover,
                      )))
                  .toList(),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() => AnimatedSmoothIndicator(
                  activeIndex: subCategoriesController.currentImageIndex.value,
                  count: data!.photo!.length,
                  effect: WormEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 5,
                    dotHeight: 5.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.grey.shade800,
                  ),
                )),

            ///88888888888
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: Get.width / 2,
                        child: Text(data!.name.toString().tr,
                            style: TextStyle(
                                fontSize: 20.sp,
                                overflow: TextOverflow.ellipsis))),
                    controller.totalPrice.value == 0
                        ? Text(
                            '${data!.price}  ${'coin_jordan'.tr}',
                            style: TextStyle(
                              fontSize: 20.sp,
                            ),
                          )
                        : Text(
                            "   ${controller.totalPrice.value.toStringAsFixed(0)}  ${'coin_jordan'.tr}    ",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.all(4.sp),
                height: 50.h,
                width: 250.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.sp),
                  color: mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.decreaseOrderCounter(data!.price!);
                      },
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.w),
                          shape: BoxShape.circle,
                          color: Colors.grey.shade800,
                        ),
                        child: Icon(Icons.remove,
                            color: Colors.white, size: 25.sp),
                      ),
                    ),
                    Text('${controller.orderCounter.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                      onTap: () {
                        controller.increaseOrderCounter(
                            data!.availability!, data!.price!.toDouble());
                      },
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.w),
                          shape: BoxShape.circle,
                          color: Colors.grey.shade800,
                        ),
                        child:
                            Icon(Icons.add, color: Colors.white, size: 25.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(15.sp)),
              child: Column(
                children: [
                  Text(
                    "${'description'.tr} :",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  SizedBox(
                    width: 400.w,
                    child: Text(
                      data!.desc!.tr,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ),
                  Directionality(
                    textDirection:
                        translateName ? TextDirection.rtl : TextDirection.ltr,
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                        onChanged: (v) {
                          controller.message = v;
                        },
                        decoration: InputDecoration(
                            hintText: "write_a_note".tr,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 3.w)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 3.w))),
                      ),
                    ),
                  ),

                  ///favorite
                  // Row(children: [
                  //  Obx(()=> IconButton(onPressed: ()async {
                  //    await  favoriteController.addToFavorite(context,data!.id);
                  //
                  //
                  //    Get.snackbar('one_item_added_to_favourite_successfully'.tr,
                  //        '',
                  //        snackPosition: SnackPosition
                  //            .TOP,
                  //        backgroundColor: Colors.grey.shade800,
                  //        duration: Duration(
                  //            seconds: 2),
                  //        dismissDirection: DismissDirection
                  //            .startToEnd,
                  //        barBlur: 10,
                  //        colorText: mainColor);
                  //    Navigator.pop(
                  //        context);
                  //
                  //
                  //   },
                  //      icon:favoriteController.visible.value==false? Icon(Icons.favorite_border,color: Colors.white,):
                  //   Icon(Icons.favorite,color: Colors.red,)
                  //   ),
                  //   ),
                  SizedBox(
                    height: 45.h,
                    width: Get.width / 1.4.w,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.sp)),
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          if (await data!.availability == 0) {
                            Get.defaultDialog(
                                content: Text('الوجبة غير متوفرة'), title: '');
                          } else if (await FirebaseAuth.instance.currentUser== null) {
                          // } else if (CacheHelper.loginShared == null) {

                            showLoaderDialog(context);
                            Get.offAll(SignUpScreen());
                          } else {
                            await controller.addToCart(context,
                                price: data!.price,
                                category: data!.categoryId,
                                name: data!.name,
                                image: data!.photo![0]);
                          };
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("add_to_cart".tr,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp)),
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 25.sp,
                            ),
                          ],
                        )),
                  ),
                  // ],),

                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
