import 'package:arrows/constants/colors.dart';
import 'package:arrows/helpers/shared_prefrences.dart';
import 'package:arrows/modules/home/models/ProductModel.dart';
import 'package:arrows/modules/product_details2/product_details.dart';
import 'package:arrows/modules/search/search_controller.dart';
import 'package:arrows/modules/sub_categories/controllers/sub_categories_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:octo_image/octo_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../product_details/controllers/product_details_controller.dart';
import 'SearchModel.dart';

class SearchScreen extends StatelessWidget {
    SearchScreen({Key? key}) : super(key: key);
  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    String replaceFarsiNumber(String input) {
      const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

      for (int i = 0; i < farsi.length; i++) {
        input = input.replaceAll(farsi[i], english[i]);
      }
      return input;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        elevation: 1,
        centerTitle: true,
        title: Text(
          'search'.tr,
          style: TextStyle(color: Colors.grey, fontSize: 25),
        ),
        leading: IconButton(onPressed: () {
          controller.searchController.clear();


          Get.back();

        }, icon: Icon(Icons.arrow_back_ios_outlined,size: 20.sp,))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: controller.searchController,
              onChanged: (v) {
                controller.search.value = v;
                controller.searchData();
              },
              decoration: InputDecoration(
                label: Text(' '.tr),
              ),
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter something to search';
                }
                return null;
              },
            ),
            Obx(() =>  (controller.searchList.value==[]||controller.searchController.text=='')
                ? SizedBox( )
                    : (controller.loading.value==true)?Text('loading...',style: TextStyle(color:mainColor),)
                    : (controller.search.value.isNotEmpty)?
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  enablePullDown: false,
                  onLoading: () async {
                    await controller.loadMore();
                  },
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.searchList.length,
                      itemBuilder: (context, index) {
                        final translateName =
                        CacheHelper.getDataToSharedPrefrence(
                            "localeIsArabic"); //
                        return InkWell(
                          onTap: ()   {
                            // Get.to(()=>ProductDetails(data: ProductData()));
                            Get.to(ProductDetails2(data: controller.searchList[index]));
                          },
                          child: Card(
                              elevation: 5,
                              color: mainColor,
                              shadowColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: mainColor, width: 3),
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.searchList[index]
                                              .name ??
                                              "",
                                          style: TextStyle(
                                            fontSize: controller
                                                .searchList[
                                            index]
                                                .availability ==
                                                0
                                                ? 22.sp
                                                : 18.sp,
                                            color: controller
                                                .searchList[
                                            index]
                                                .availability ==
                                                1
                                                ? Colors.white
                                                : Colors.grey,
                                            decoration: controller
                                                .searchList[
                                            index]
                                                .availability ==
                                                0
                                                ? TextDecoration
                                                .lineThrough
                                                : null,
                                            fontWeight: FontWeight.w600,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: translateName
                                                  ? BorderRadius.only(
                                                  bottomRight:
                                                  Radius
                                                      .circular(
                                                      15))
                                                  : BorderRadius.only(
                                                  bottomLeft: Radius
                                                      .circular(
                                                      15))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${replaceFarsiNumber(controller.searchList[index].price.toString() ?? "")} ",
                                                style: TextStyle(
                                                    fontSize: 25.sp),
                                              ),
                                              SizedBox(width: 20.w),
                                              Text(
                                                'Price',
                                                style: TextStyle(
                                                    color:
                                                    Colors.black,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 20.sp),
                                              ),
                                              SizedBox(width: 20.w),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft:
                                        Radius.circular(15)),
                                    child: CachedNetworkImage(
                                        height: 120.h,
                                        width: 150.w,
                                        imageUrl: controller
                                            .searchList[index]
                                            .photo!.first ??
                                            "",
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url,
                                            error) =>
                                            Center(
                                              child: SizedBox(
                                                height: 30,
                                                width: 30,
                                                child:
                                                CircularProgressIndicator(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            )),
                                  ),
                                ],
                              )),
                        );
                      }),
                )):Text('data',style: TextStyle(color: Colors.red),)
            )
          ],
        ),
      ),
    );
   }
}


class ProductDetails2 extends StatelessWidget {
  ProductDetails2({Key? key, required this.data }) : super(key: key);
  final Data data;
  final controller=Get.put(ProductDetailsController());
  final subCategoriesController=Get.put(SubCategoriesController());
   final translateName =
  CacheHelper.getDataToSharedPrefrence("localeIsArabic");
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
            icon: Icon(Icons.arrow_back_ios, color: mainColor)),
        title: Text('${data.name}', style: TextStyle(color: mainColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
CarouselSlider(
options: CarouselOptions(
autoPlay: false,
height: Get.height / 2.5.h,
viewportFraction: 1,
onPageChanged: (index, reason) {
subCategoriesController.currentImageIndex.value = index;
}),
items: data.photo!
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
count: data.photo!.length,
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
Obx(
() => Padding(
padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Container(
width: Get.width / 2,
child: Text(data.name.toString().tr,
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
            Obx(() {
    return  Container(
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
                      controller.decreaseOrderCounter(data.price!);

                    },
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.w),
                        shape: BoxShape.circle,
                        color: Colors.grey.shade800,
                      ),
                      child: Icon(Icons.remove, color: Colors.white, size: 25.sp),
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
                      controller.increaseOrderCounter(data.availability!,data.price!.toDouble());
                    },
                    child: Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.w),
                        shape: BoxShape.circle,
                        color: Colors.grey.shade800,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 25.sp),
                    ),
                  ),
                ],
              ),
            );}
            ),
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<ProductDetailsController>(
            init: ProductDetailsController(),
    builder: (controller) =>   Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4.h,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(15.sp)),
              child: Column(
                children: [
                  Text(
                    "${'description'.tr} :"  ,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                  Text(
                    '${data.name}'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),   Directionality(
                    textDirection: translateName
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    child:
                    Padding(
                      padding:   EdgeInsets.all(8.0.sp),
                      child: TextField(
                        onChanged: (v) {
                          controller.message=v;

                        },
                        decoration: InputDecoration(
                            hintText: "write_a_note".tr,
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide:
                                BorderSide(color: Colors.black54, width: 3.w)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.sp),
                                borderSide:
                                BorderSide(color: Colors.black54, width: 3.w))),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 45.h,
                      width: 300.w,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.sp)),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            controller.addToCart(context,price:data.price,category: data.categoryId ,name:data.name,image:data.photo!.first);
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
                                size: 15,
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}

