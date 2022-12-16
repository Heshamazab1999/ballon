import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.grey),
        elevation: 1,
        centerTitle: true,
        title:
          Text('search'.tr,
          style: TextStyle(color: Colors.grey,
          fontSize: 25),),
      ),
      body: Column(
        children: [
          TextFormField(

            decoration:   InputDecoration(
              label: Text('search'.tr),
              prefixIcon: Icon(Icons.search),),
            keyboardType: TextInputType.text,
            validator: (String ?value) {
              if (value!.isEmpty) {
                return 'Please enter something to search';
              }
              return null;
            },
          ),


        ],
      ),
    );;
  }
}
