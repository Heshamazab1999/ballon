import 'package:arrows/constants/colors.dart';
import 'package:arrows/modules/sub_categories/screens/sub_categories_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../components/sub_cat_componant.dart';
import '../search_screen.dart';
import 'controller.dart';

class NewSubCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewSubCategoryController());

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 25.sp,
                )),
          ],
          toolbarHeight: 60,
          title: Image.asset(
            'assets/images/logo99.png',
            fit: BoxFit.fill,
            height: 80.h,
          ),
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
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Obx(
                                  () => TextButton(
                                      onPressed: () {
                                        controller.onTap(index);
                                        // controller.changeScreens(index);
                                        // controller.isClicked(index);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          backgroundColor:
                                              controller.checkIsClicked.value
                                                  ? Colors.grey
                                                  : Colors.white12,
                                          elevation: 0,
                                          minimumSize:
                                              const Size(double.infinity, 55)),
                                      child: Text(
                                        controller.category!.data![index].name!,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
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
                            ? Center(child: Text("no data"))
                            : GridView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: controller.listSubCategory.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (3),
                                  childAspectRatio: 8 / 10,
                                  // childAspectRatio: MediaQuery.of(context).size.width /
                                  //     (MediaQuery.of(context).size.height / 0.7),
                                ),
                                itemBuilder: (context, index) {
                                  print(controller.listSubCategory[index].id!);
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => SubCategoriesScreen(
                                          id: controller
                                              .listSubCategory[index].id!,
                                          title: controller
                                              .listSubCategory[index].name!));
                                    },
                                    child: Container(
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
