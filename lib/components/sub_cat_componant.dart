import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/Items Screen/controller/new_sub_cat_controller.dart';


class testScreen extends StatelessWidget {
  String imgPath;
  int contentNo;
   testScreen({
    required this.imgPath,
    required this.contentNo,
     Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewSubCategoryController controller = Get.put(NewSubCategoryController());
    if (controller.currentIndex != null){
      return Scaffold(
        body: GridView.builder(
          padding:  const EdgeInsets.all(0),
          itemCount: controller.items[controller.currentIndex!]['Category']['ItemsCount'],
          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (3),
          ),

          itemBuilder: (context,index){
            return Column(
              children: [
                Container(
                   child: Card(

                    child: Image.asset(
                      controller.items[controller.currentIndex!]['Category']['ImagePath'],
                      fit: BoxFit.contain,
                      height: 50,
                      width:100,
                    ),
                  ),
                ),
                Text('${controller.items[controller.currentIndex!]['Category']['ItemsLabel']}'),
              ],
            );
          },
        ),
      );
    }else {
      return SizedBox();
    }
  }
}