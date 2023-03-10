import 'package:arrows/api_base/api_endpoints.dart';
import 'package:arrows/api_base/dio_helper.dart';
import 'package:arrows/modules/home/models/ProductModel.dart';
import 'package:arrows/modules/sub_categories/models/SubCategories.dart';
import 'package:dio/dio.dart';

class SubCategoriesService {
  // static Future<SubCategories?> getSubCategories(
  //     int mainCategoryId, int page) async {
  //   try {
  //     Response? response = await DioHelper.getData(
  //         url: "${endpoint[Endpoint.subCategories]}${mainCategoryId}/$page");
  //     print(response.data);
  //     return SubCategories.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  //   return null;
  // }
  Future<ProductModel?> getProducts(int id, int pageNumber) async {
    Response? response;
    try {
      response =
          await DioHelper.getData(url: "categories/products/$id/$pageNumber");
      print(response.data);
      print("object");
      return ProductModel.fromJson(response.data);
    } on DioError catch (e) {
      print("----------------");
      print("error : ${e.message}");
    }
    return null;
  }
}
