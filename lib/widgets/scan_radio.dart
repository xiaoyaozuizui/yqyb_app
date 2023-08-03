import 'package:flutter/material.dart';
import 'package:app/providers/scan.dart';
import 'package:provider/provider.dart';

// class scanItem {
//   final String title;
//   final IconData icon;
//   scanItem(this.title, this.icon);
// }

// enum ItemType { tiao, er, rfid }

class Scan_radio extends StatefulWidget {
  const Scan_radio({Key? key}) : super(key: key);
  @override
  _Scan_radio createState() => _Scan_radio();
}

class _Scan_radio extends State<Scan_radio> {
  late Map<ItemType, scanItem> scanItems;
  late ItemType _type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanItems = context.read<ScanProvider>().scanItems;
    _type = context.read<ScanProvider>().type;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: scanItems.keys
              .map((e) => RadioListTile<ItemType>(
                  value: e,
                  title: Text(scanItems[e]!.title),
                  selected: _type == e,
                  secondary: Icon(scanItems[e]!.icon),
                  groupValue: _type,
                  onChanged: (ItemType? e) => setState(() {
                        _type = e ?? _type;
                        context.read<ScanProvider>().setType(_type);
                      })))
              .toList()),
    );
  }
}
