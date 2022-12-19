import 'package:arrows/constants/colors.dart';
import 'package:arrows/helpers/shared_prefrences.dart';
import 'package:arrows/modules/product_details2/product_details.dart';
import 'package:arrows/modules/search/search_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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

    final controller = Get.put(SearchController());
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              onChanged: (v) {
                controller.search.value = v;
                controller.searchData();
              },
              decoration: InputDecoration(
                label: Text('search'.tr),
              ),
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter something to search';
                }
                return null;
              },
            ),
            Obx(() => controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : controller.searchList.isEmpty
                    ? SizedBox()
                    : SizedBox(
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
                                  onTap: () async {
                                    // Get.to(() => ProductDetails(
                                    //       data: controller.data!.data!.product[index],
                                    //     ));
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
                                                        ? Colors.black
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
                                                                kPrimaryColor,
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
                                                        .photo ??
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
                        )))
          ],
        ),
      ),
    );
    ;
  }
}
