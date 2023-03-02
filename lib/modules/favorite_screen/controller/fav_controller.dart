import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../helpers/shared_prefrences.dart';
import '../model/fav_body.dart';
import '../model/fav_model.dart';
import '../services/services.dart';

class FavoriteController extends GetxController {
  final visible = false.obs;
FavoriteModel favoriteModel=FavoriteModel();



onInit(){
  getFavourite();
  super.onInit();

}
  Future<void> addToFavorite(BuildContext context, id) async {
    final uid =   FirebaseAuth.instance.currentUser!.uid;
    FavoriteBody favoriteBody = await FavoriteBody(
      userId: uid,
      productId: id,
    );
    dio.Response? response;
    // response = await FavoriteServices.setFavoriteProduct(favoriteBody);
    print(response);
  }

  changevisibility() {
    visible.value = !visible.value;
    update();
  }

  getFavourite() async {
    final uid =   FirebaseAuth.instance.currentUser!.uid;

    // favoriteModel = (await FavoriteServices.getFavourite(uid))!;
    print(favoriteModel.data);

    update();
    return favoriteModel;
  }
}
