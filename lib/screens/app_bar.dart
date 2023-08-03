import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth.dart';
import 'package:app/providers/user.dart';
import 'package:app/models/user/profile.dart';
import 'package:app/widgets/scan_radio.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MainAppBar extends StatefulWidget with PreferredSizeWidget {
  final String _title;
  final Profile _profile;
  MainAppBar(this._title, this._profile);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  _MainAppBar createState() => _MainAppBar();
}

class _MainAppBar extends State<MainAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget._title),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () async {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget._profile.username,
                          key: ValueKey('dialog'),
                        ),
                        Icon(Icons.person),
                      ],
                    ),
                    actions: [
                      TextButton(
                        key: ValueKey("increment"),
                        child: Text('关闭'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                    contentPadding: EdgeInsets.zero,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          //dense: true,
                          leading: const Icon(Icons.exit_to_app),
                          title: Text('蓝牙连接'),
                          onTap: () async {
                            await FlutterBluePlus.startScan(
                                timeout: Duration(seconds: 4));
                            FlutterBluePlus.scanResults.listen((results) {
                              // do something with scan results
                              print(results);
                              for (ScanResult r in results) {
                                print(
                                    '${r.device.name} found! rssi: ${r.rssi}');
                              }
                            });
                            // FlutterBluePlus.stopScan();
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Row(
                            children: [
                              Icon(Icons.account_tree_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('扫描方式：'),
                            ],
                          ),
                        ),
                        Scan_radio(),
                        const Divider(),
                        ListTile(
                          //dense: true,
                          leading: const Icon(Icons.exit_to_app),
                          title: Text('退出登录'),
                          onTap: () {
                            context.read<AuthProvider>().logout();

                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ],
    );
  }
}

/// App bar that only displays a title
class EmptyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String _title;

  EmptyAppBar(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
