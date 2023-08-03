import 'package:flutter/material.dart';
import 'package:app/models/device/devices.dart';

class DeviceScreen extends StatelessWidget {
  static const routeName = '/device';
  @override
  Widget build(BuildContext context) {
    final Device args = ModalRoute.of(context)!.settings.arguments as Device;
    return Scaffold(
      appBar: AppBar(title: Text(args.name)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Text(args.name),
            leading: const Text(
              '设备名称:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.id),
            leading: const Text(
              '设备ID:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.type),
            leading: const Text(
              '设备类型:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.status),
            leading: const Text(
              '设备状态:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.store_status),
            leading: const Text(
              '设备出入库状态:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.message ?? '无'),
            leading: const Text(
              '备注:',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      )),
    );
  }
}
