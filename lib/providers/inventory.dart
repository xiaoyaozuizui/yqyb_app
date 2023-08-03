import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/models/device/devices.dart';
import 'base_provider.dart';
import 'dart:convert';

class InventoryProvider with ChangeNotifier {
  final AppBaseProvider baseProvider;
  InventoryProvider(this.baseProvider);

  static const PROFILE_URL = 'userprofile';
  static const VERIFY_EMAIL = 'verify-email';

  List<Device> device = [];

  int checkedNum() {
    int i = 0;
    device.forEach((element) {
      if (element.checked!) i++;
    });
    return i;
  }

  /// Clear the current profile

  /// Fetch the current user's profile
  Future<void> fetchAndSetDevices() async {
    var aaa = await rootBundle.loadString('mock/devices.json');
    List userData = json.decode(aaa);
    try {
      device = userData.map((e) => (Device.fromJson(e))).toList();
      device.forEach((element) {
        element.checked = false;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDevices1() async {
    var aaa = await rootBundle.loadString('mock/devices1.json');
    List bbb = json.decode(aaa);

    try {
      bbb.forEach((element) {
        var index = device.indexWhere(
            (element1) => element1.id == Device.fromJson(element).id);
        device[index].checked = true;
        device.insert(0, device.removeAt(index));
        ;
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchAndSetDevices2() async {
    var aaa = await rootBundle.loadString('mock/devices1.json');
    var bbb = json.decode(aaa);
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
