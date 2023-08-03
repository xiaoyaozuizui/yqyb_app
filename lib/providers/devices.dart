import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/device/devices.dart';
import 'base_provider.dart';
import 'dart:convert';

class DevicesProvider with ChangeNotifier {
  final AppBaseProvider baseProvider;
  DevicesProvider(this.baseProvider);

  static const PROFILE_URL = 'userprofile';
  static const VERIFY_EMAIL = 'verify-email';

  List<Device> device = [];

  /// Clear the current profile

  /// Fetch the current user's profile
  Future<void> fetchAndSetDevices() async {
    var aaa = await rootBundle.loadString('mock/devices.json');
    List userData = json.decode(aaa);
    try {
      device = userData.map((e) => (Device.fromJson(e))).toList();
      print(device);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDevices1() async {
    var aaa = await rootBundle.loadString('mock/devices1.json');
    List userData = json.decode(aaa);
    try {
      device = userData.map((e) => (Device.fromJson(e))).toList();
      print(device);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDevices2() async {
    var aaa = await rootBundle.loadString('mock/devices2.json');
    List userData = json.decode(aaa);
    try {
      device = userData.map((e) => (Device.fromJson(e))).toList();
      print(device);
    } catch (error) {
      rethrow;
    }
  }

  /// Save the user's profile to the server
  // Future<void> saveProfile() async {
  //   final data = await baseProvider.post(
  //     device!.toJson(),
  //     baseProvider.makeUrl(PROFILE_URL),
  //   );
  // }

  /// Verify the user's email
  Future<void> verifyEmail() async {
    final verificationData = await baseProvider.fetch(baseProvider.makeUrl(
      PROFILE_URL,
      objectMethod: VERIFY_EMAIL,
    ));
    //log(verificationData.toString());
  }
}
