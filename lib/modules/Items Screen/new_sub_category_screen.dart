import 'package:arrows/constants/colors.dart';
import 'package:arrows/modules/sub_categories/screens/sub_categories_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../components/arrows_app_bar.dart';
import '../search/search_screen.dart';
 import 'controller/new_sub_cat_controller.dart';

class NewSubCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewSubCategoryController());

    return Scaffold(
        appBar: ArrowsAppBar(
          'home'.tr,
        ),
        body: Obx(() => controller.loading.value
            ? Center(child: CircularProgressIndicator())
            : Row(children: [
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: controller.category!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding:   EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Obx(() => TextButton(
                                      onPressed: () {
                                        controller.onTap(index);
                                         controller.selected(index);},
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.sp),
                                          ),
                                        primary:  controller.selectedIndex.value == index
                                              ?mainColor.withOpacity(.5)
                                              : Colors.transparent,
                                          elevation: 0,
                                          minimumSize:
                                              const Size(double.infinity, 55)),
                                      child: Text(
                                        controller.category!.data![index].name!.tr,
                                        style:   TextStyle(
                                          fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                ),
                              ),
                              Obx(()=>Container(
                                margin: EdgeInsets.fromLTRB(5.h, 0, 10, 0),
                                height: 1,
                                width: double.infinity,
                                color:controller.selectedIndex.value == index
                                    ? Colors.transparent:Colors.grey.shade300

                              )
                              )
                            ],
                          );
                        })),
                SizedBox(
                  height: double.infinity,
                  width: 1,
                  child: Container(
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                ),
                Obx(() => controller.load.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        flex: 2,
                        child: controller.listSubCategory.isEmpty
                            ? Center(child:  Text("no_products_meal".tr),)
                            : GridView.builder(
                                padding:   EdgeInsets.only(top: 10.h,right: 5.w,left: 5.w),
                                itemCount: controller.listSubCategory.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (3),
                                  childAspectRatio: 8 / 10,),
                                itemBuilder: (context, index) {
                                  print(controller.listSubCategory[index].id!);
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => SubCategoriesScreen(
                                          id: controller
                                              .listSubCategory[index].id!,
                                          title: controller
                                              .listSubCategory[index].name!.tr));
                                    },
                                    child: Container(
                                        padding:   EdgeInsets.only( right: 2.w,left: 2.w),

                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.3)),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .listSubCategory[index]
                                                        .photo!,
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Center(
                                                              child: SizedBox(
                                                                height: 30,
                                                                width: 30,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: kPrimaryColor
                                                                      .withOpacity(
                                                                          0.6),
                                                                ),
                                                              ),
                                                            )),
                                              ),
                                            ),
                                            Text(
                                              controller
                                                  .listSubCategory[index].name!,
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              )))
              ])));
  }
}
