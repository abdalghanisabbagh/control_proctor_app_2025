import 'package:get/get.dart';

class SideMenuController extends GetxController {
  var currentPage = ''.obs;

  void updatePage(String pageName) {
    currentPage.value = pageName;
  }
}
