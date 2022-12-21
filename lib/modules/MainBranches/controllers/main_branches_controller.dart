import 'package:arrows/modules/MainBranches/models/fireBase_branches.dart';
import 'package:arrows/modules/where_to_deliver/models/branches_addresses_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../helpers/shared_prefrences.dart';

class MainBranchesController extends GetxController{


FireBaseBranchesModel? mainBranchDropDownValue;
final isLoading=false.obs; //bool variable created
var  selectedValue ;


  RxList<FireBaseBranchesModel> firebaseBranches = [FireBaseBranchesModel(

      name_en: 'choose_branch_drop_down'.tr,
      dataBase: 'Demo DataBase',
      available:false,
      name_ar: 'choose_branch_drop_down'.tr,
      id: '',
      address_ar: '',
      address_en: '',
      lat: '',
      lng: ''
  )].obs;
  
  void getFirebaseBranches()async {
    isLoading.value=true;
    await FirebaseDatabase.instance.reference()
        .child('branches').get().then((snapShot){
      var values = snapShot.value;
      values.forEach((key, value){
        firebaseBranches.add(FireBaseBranchesModel.fromJson(value));
        print(value);
      });
      isLoading.value=false;

      update();
    });
   }
  @override
  void onInit() {
    mainBranchDropDownValue =   firebaseBranches[0];
    CacheHelper.saveDataToSharedPrefrence('restaurantBranchID',mainBranchDropDownValue!.id);
    firebaseBranches;
    getFirebaseBranches();
    super.onInit();
  }

  switchFunc(value){
      selectedValue=value;
      update();
   }
}
