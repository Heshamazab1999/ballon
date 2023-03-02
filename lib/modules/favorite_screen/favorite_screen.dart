import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../helpers/shared_prefrences.dart';
import '../product_details2/product_details.dart';
import 'controller/fav_controller.dart';

class FavoriteScreen extends StatelessWidget {
    FavoriteScreen({Key? key}) : super(key: key);
final controller=Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     itemCount:
          //     controller.favoriteModel.data!.length,
          //     itemBuilder: (context, index) {
          //       final translateName =
          //       CacheHelper.getDataToSharedPrefrence(
          //           "localeIsArabic"); //
          //       print(controller.product.length);
          //       return InkWell(
          //         onTap: () async {
          //           Get.to(() => ProductDetails(
          //             data: controller
          //                 .product[index],
          //           ));
          //         },
          //         child: Card(
          //             elevation: 5,
          //             color: mainColor,
          //             shadowColor: mainColor,
          //             shape: RoundedRectangleBorder(
          //                 side: BorderSide(
          //                     color: mainColor, width: 3),
          //                 borderRadius:
          //                 BorderRadius.circular(15)),
          //             child: Row(
          //               mainAxisAlignment:
          //               MainAxisAlignment.end,
          //               children: [
          //                 Expanded(
          //                   child: Column(
          //                     mainAxisAlignment:
          //                     MainAxisAlignment.start,
          //                     children: [
          //                       Row(children: [
          //                         IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.white,size: 20.sp,),padding: EdgeInsets.zero,constraints: BoxConstraints(),),
          //                         Spacer(),
          //
          //                         Text(
          //                           controller
          //                               .product[index]
          //                               .name ??
          //                               "",
          //                           style: TextStyle(
          //                             fontSize:
          //                             controller
          //                                 .product[
          //                             index]
          //                                 .availability ==
          //                                 0
          //                                 ? 22.sp
          //                                 : 18.sp,
          //                             color: controller
          //                                 .product[
          //                             index]
          //                                 .availability ==
          //                                 1
          //                                 ? Colors.white
          //                                 : Colors.grey,
          //                             decoration:
          //                             controller
          //                                 .product[
          //                             index]
          //                                 .availability ==
          //                                 0
          //                                 ? TextDecoration
          //                                 .lineThrough
          //                                 : null,
          //                             fontWeight:
          //                             FontWeight.w600,
          //                             overflow:
          //                             TextOverflow.ellipsis,
          //
          //                           ),
          //                         ),
          //                         Spacer(),
          //
          //                       ],),
          //                       Container(
          //                         height: 80.h,
          //                         decoration: BoxDecoration(
          //                             color: Colors.white,
          //                             borderRadius: translateName
          //                                 ? BorderRadius.only(
          //                                 bottomRight:
          //                                 Radius
          //                                     .circular(
          //                                     15))
          //                                 : BorderRadius.only(
          //                                 bottomLeft: Radius
          //                                     .circular(
          //                                     15))),
          //                         child: Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceEvenly,
          //                           children: [
          //                             Text(
          //                               'coin_jordan'.tr,
          //                               style: TextStyle(
          //                                   color:
          //                                   Colors.black,
          //                                   fontWeight:
          //                                   FontWeight
          //                                       .bold,
          //                                   fontSize: 20.sp),
          //                             ),                                                        SizedBox(width: 20.w),
          //                             Text(
          //                               "${replaceFarsiNumber(controller.product[index].price.toString() ?? "")} ",
          //                               style: TextStyle(
          //                                   fontSize: 25.sp),
          //                             ),
          //                             SizedBox(width: 20.w),
          //                             Text(
          //                               'price'.tr,
          //                               style: TextStyle(
          //                                   color:
          //                                   Colors.black,
          //                                   fontWeight:
          //                                   FontWeight
          //                                       .bold,
          //                                   fontSize: 20.sp),
          //                             ),
          //                             SizedBox(width: 20.w),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 ClipRRect(
          //                   borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(15),
          //                       bottomLeft:
          //                       Radius.circular(15)),
          //                   child: CachedNetworkImage(
          //                       height: 120.h,
          //                       width: 150.w,
          //                       imageUrl:
          //                       controller
          //                           .product[index]
          //                           .photo![0] ??
          //                           "",
          //                       fit: BoxFit.cover,
          //                       errorWidget:
          //                           (context, url, error) =>
          //                           Center(
          //                             child: SizedBox(
          //                               height: 30,
          //                               width: 30,
          //                               child:
          //                               CircularProgressIndicator(
          //                                 color: kPrimaryColor
          //                                     .withOpacity(
          //                                     0.6),
          //                               ),
          //                             ),
          //                           )),
          //                 ),
          //               ],
          //             )),
          //       );
          //     }),
        ],
      ),
    );
  }
}
