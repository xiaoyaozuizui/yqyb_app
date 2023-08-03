import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/device/devices.dart';
import 'base_provider.dart';
import 'dart:convert';

class StoreProvider with ChangeNotifier {
  final AppBaseProvider baseProvider;
  StoreProvider(this.baseProvider);

  static const PROFILE_URL = 'userprofile';
  static const VERIFY_EMAIL = 'verify-email';

  List<Device> device = [];
  List<Device> in_store = [];
  List<Device> out_store = [];

  /// Clear the current profile

  /// Fetch the current user's profile
  Future<void> fetchAndSetDevices() async {
    var aaa = await rootBundle.loadString('mock/devices.json');
    List userData = json.decode(aaa);
    try {
      device = userData.map((e) => (Device.fromJson(e))).toList();
      out_store =
          device.where((element) => element.store_status == '离库').toList();
      in_store =
          device.where((element) => element.store_status == '在库').toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDevices1() async {
    var aaa = await rootBundle.loadString('mock/devices1.json');
    List userData = json.decode(aaa);
    try {
      device = [];
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
