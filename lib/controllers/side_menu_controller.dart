import 'package:get/get.dart';

/// This class is a controller for the side menu in the app.
///
/// It exposes an observable string called [currentPage] that stores the
/// current page name in the side menu. The page name is updated when the
/// user navigates to a different page.
class SideMenuController extends GetxController {
  /// The current page name in the side menu.
  ///
  /// This is an observable string that is updated when the user navigates to
  /// a different page. It is used to display the current page name in the side
  /// menu.
  var currentPage = ''.obs;

  /// Updates the current page name in the side menu.
  ///
  /// This method is used to update the current page name in the side menu
  /// when the user navigates to a different page. The page name is stored
  /// in the [currentPage] variable, which is an observable string.
  ///
  /// [pageName] is the name of the page that the user is navigating to.
  ///
  /// This method is called by the [Get] framework when the user navigates to
  /// a different page.
  void updatePage(String pageName) {
    currentPage.value = pageName;
  }
}
