import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/login_response/user_profile_model.dart';

class ProfileController extends GetxController {
  UserProfileModel? _cachedUserProfile;

  UserProfileModel? get cachedUserProfile =>
      _cachedUserProfile ?? getProfileFromHiveBox();

  /// Deletes the profile from the hive box and resets the cached profile
  /// to null.
  Future<void> deleteProfileFromHiveBox() async {
    _cachedUserProfile = null;
    await Hive.box('Profile').clear();
  }

  /// Gets the user profile from the hive box.
  ///
  /// If the box contains key 'Profile', it will return the user profile
  /// from the box. Otherwise, it will return null.
  ///
  /// The cached user profile is also reset to the returned value.
  UserProfileModel? getProfileFromHiveBox() {
    var data = Hive.box('Profile').get('Profile');
    _cachedUserProfile = Hive.box('Profile').containsKey("Profile")
        ? UserProfileModel.fromJson(jsonDecode(data))
        : null;
    return _cachedUserProfile;
  }

  /// Saves the given user profile to the hive box.
  ///
  /// The user profile is serialized to a json string and stored in the
  /// 'Profile' box with the key 'Profile'.
  ///
  /// This method also calls [update] to notify the widgets that depend on
  /// this controller to rebuild.
  void saveProfileToHiveBox(UserProfileModel cachedUserProfile) {
    update();
    Hive.box('Profile').put('Profile', jsonEncode(cachedUserProfile.toJson()));
  }
}
