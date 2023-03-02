import 'package:arrows/api_base/dio_helper.dart';
import 'package:dio/dio.dart';
import '../../../api_base/api_endpoints.dart';
import '../model/fav_model.dart';

class FavoriteServices{



  // static Future<Response?>setFavoriteProduct(FavoriteBody favoriteBody)async{
  //
  //   Response? response;
  //   response = await DioHelper.postData(url: endpoint[Endpoint.setFavourite] ,
  //       query: favoriteBody.toJson());
  //   print(response.data);
  //   return response;
  // }




  // static Future <FavoriteModel?> getFavourite(  uid) async {
  //   try {
  //     Response? response = await DioHelper.getData(
  //         url: "${endpoint[Endpoint.getFavourite]}${uid}");
  //     print(response.data);
  //     return FavoriteModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  //   return null;
  // }

}