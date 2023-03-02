import 'package:get/get.dart';

class SettingsController extends GetxController{
  final enabled=true.obs;

  isClicked(){
    enabled.value = !enabled.value;

    print(enabled.value);
  }



}