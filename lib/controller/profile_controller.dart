import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/login_response/user_profile_model.dart';

class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  // bool canAccessWidget({required String widgetId}) {
  //   return (cachedUserProfile?.roles
  //           ?.map((role) => role.screens
  //               ?.map((screen) => screen.frontId)
  //               .contains(widgetId))
  //           .firstOrNull ??
  //       false);
  // }

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }

  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    await Hive.box('Profile').clear();
  }
}
