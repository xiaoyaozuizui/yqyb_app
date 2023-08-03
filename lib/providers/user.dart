import 'dart:async';
// import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app/models/user/profile.dart';
import 'base_provider.dart';

class UserProvider with ChangeNotifier {
  final AppBaseProvider baseProvider;
  UserProvider(this.baseProvider);

  static const PROFILE_URL = 'userprofile';
  static const VERIFY_EMAIL = 'verify-email';

  Profile? profile;

  /// Clear the current profile
  void clear() {
    profile = null;
  }

  /// Fetch the current user's profile
  Future<void> fetchAndSetProfile() async {
    print(baseProvider.makeUrl(PROFILE_URL));
    final userData =
        await baseProvider.fetch(baseProvider.makeUrl(PROFILE_URL));
    try {
      profile = Profile.fromJson(userData);
      print(profile?.username);
    } catch (error) {
      rethrow;
    }
  }

  /// Save the user's profile to the server
  Future<void> saveProfile() async {
    final data = await baseProvider.post(
      profile!.toJson(),
      baseProvider.makeUrl(PROFILE_URL),
    );
  }

  /// Verify the user's email
  Future<void> verifyEmail() async {
    final verificationData = await baseProvider.fetch(baseProvider.makeUrl(
      PROFILE_URL,
      objectMethod: VERIFY_EMAIL,
    ));
    //log(verificationData.toString());
  }
}
