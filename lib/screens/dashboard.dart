import 'package:flutter/material.dart';
import 'package:app/providers/devices.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/devices.dart';
import 'package:app/providers/scan.dart';
import 'package:app/screens/device.dart';
import 'package:app/screens/scan.dart';

const List<String> arr = ['id', 'data'];

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String dropdownValue = arr.first;
  bool? sort;
  late TextEditingController _controller;
  late Future<void> _initialData;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _initialData = _loadEntries();
  }

  Future<void> _loadEntries() async {
    final devicesProvider = context.read<DevicesProvider>();
    await Future.wait([
      devicesProvider.fetchAndSetDevices(),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Consumer<ScanProvider>(
            builder: (context, value, child) =>
                Icon(value.scanItems[value.type]?.icon),
          ),
          onPressed: () {
            print(111);
            setState(() {
              Navigator.pushNamed(context, ScanScreen.routeName);
            });

            // setState(() {
            //   context.read<DevicesProvider>().fetchAndSetDevices2();
            // });
          },
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 9,
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                      child: Column(
                    children: context
                        .read<DevicesProvider>()
                        .device
                        .map((e) => ListTile(
                              title: Text(e.name),
                              subtitle: Text(e.type),
                              leading: Icon(Icons.abc),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DeviceScreen.routeName,
                                  arguments: e,
                                );
                              },
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert),
                                itemBuilder: (context) => [
                                  PopupMenuItem<String>(
                                    value: '备注',
                                    child: Text('出入库'),
                                    onTap: () {
                                      print(222);
                                    },
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ));
                },
                future: _initialData,
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                          value: dropdownValue,
                          items: arr
                              .map((e) => DropdownMenuItem<String>(
                                  value: e, child: Text(e)))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              sort = null;
                              dropdownValue = value!;
                              _controller.clear();
                            });
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 100,
                        height: 30,
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: dropdownValue),
                          onSubmitted: (value) {
                            setState(() {
                              context
                                  .read<DevicesProvider>()
                                  .fetchAndSetDevices2();
                            });
                          },
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (sort == null) {
                              sort = true;
                            } else {
                              sort = !sort!;
                            }
                            context
                                .read<DevicesProvider>()
                                .fetchAndSetDevices1();
                          });
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.keyboard_double_arrow_up,
                                color: sort != null && sort!
                                    ? Colors.green
                                    : Colors.black,
                                size: 15,
                              ),
                              Icon(
                                Icons.keyboard_double_arrow_down,
                                color: sort != null && !sort!
                                    ? Colors.green
                                    : Colors.black,
                                size: 15,
                              )
                            ]),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
