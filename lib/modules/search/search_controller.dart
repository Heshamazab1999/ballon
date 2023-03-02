import 'package:arrows/modules/search/SearchModel.dart';
import 'package:arrows/modules/search/search_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/models/ProductModel.dart';

class SearchController extends GetxController {
  final services = SearchService();

  final loading = false.obs;
  final searchList = <Data>[].obs;
  // final searchListProductData = <ProductData>[].obs;
  final pageNumber = 0.obs;
  final search = ''.obs;
  final RefreshController refreshController = RefreshController();
TextEditingController searchController=TextEditingController();
  @override
  onInit() {
    super.onInit();
    search.value='';


  }
  loadMore() async {
    if (searchList.isNotEmpty) {
      pageNumber.value++;
      SearchModel? data =
          await services.searchProduct(search.value, pageNumber.value);
      searchList.addAll(await data!.data!);
      print(searchList.length);
      print("loading");
      print(pageNumber.value);
    } else {
      print("no subcategories");
    }
  }

searchData() async {
    loading.value = true;
    SearchModel data =
    (await services.searchProduct(search.value, pageNumber.value))!;
     if (data.data != null) {
      searchList.assignAll(await data.data ?? []);
       // loading.value = false;
    } else if (data.data == null) {
       searchList.value=[];
       // loading.value = false;

       searchList.clear();
    }
    else if(search.value.isEmpty){
      // loading.value = false;
      print('search is emptyyyyy');
    }
    loading.value = false;

    print(searchList.length);
    return searchList;
   }
@override
  void dispose() {
  searchController.clear();
    super.dispose();
  }
}
