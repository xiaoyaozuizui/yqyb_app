import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum ItemType { tiao, er, rfid }

class scanItem {
  final String title;
  final IconData icon;
  scanItem(this.title, this.icon);
}

class ScanProvider with ChangeNotifier {
  ItemType type = ItemType.tiao;
  final Map<ItemType, scanItem> scanItems = {
    ItemType.tiao: scanItem('设备码扫描', Icons.center_focus_strong),
    // ItemType.er: scanItem('二维码码扫描', Icons.qr_code_scanner),
    ItemType.rfid: scanItem('RFID扫描', Icons.settings_remote),
  };
  ScanProvider();

  Future<void> setType(ItemType a) async {
    type = a;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    try {
      final b = json.encode({
        'scanType': type.index,
      });
      prefs.setString('scanType', b);
    } catch (erro) {
      rethrow;
    }
  }

  Future<void> getType() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('scanType')) {
      type = ItemType.tiao;
      return;
    }
    final extractedUserData = json.decode(prefs.getString('scanType')!);

    type = ItemType.values[extractedUserData['scanType']];
  }
}
