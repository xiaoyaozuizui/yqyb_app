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
          ),
          ListTile(
            title: Text(args.message ?? 'No.001'),
            leading: const Text(
              '标签id:',
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
            title: Text(args.message ?? '未录入'),
            leading: const Text(
              'RFID:',
              style: TextStyle(fontSize: 15),
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: '备注',
                  child: Text('录入RFID'),
                  onTap: () {
                    print(222);
                  },
                ),
                PopupMenuItem<String>(
                  value: '备注',
                  child: Text('清除RFID'),
                  onTap: () {
                    print(222);
                  },
                  enabled: false,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
