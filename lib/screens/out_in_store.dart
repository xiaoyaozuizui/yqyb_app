import 'package:flutter/material.dart';
import 'package:app/providers/scan.dart';
import 'package:app/providers/store.dart';
import 'package:provider/provider.dart';
import 'device.dart';
import 'store.dart';

class OutInStore extends StatefulWidget {
  static const routeName = '/out_in_store';

  @override
  _OutInStore createState() => _OutInStore();
}

class _OutInStore extends State<OutInStore> {
  late Future<void> _initialData;
  @override
  void initState() {
    super.initState();
    _initialData = _loadEntries();
  }

  Future<void> _loadEntries() async {
    final storeProvider = context.read<StoreProvider>();
    await Future.wait([
      storeProvider.fetchAndSetDevices(),
    ]);
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
            setState(() {
              context.read<StoreProvider>().fetchAndSetDevices();
            });
          },
        ),
        body: FutureBuilder(
            future: _initialData,
            builder: (context, snapshot) {
              if (context.read<StoreProvider>().device.isNotEmpty) {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                          child: Column(
                        children: context.read<StoreProvider>().device.map((e) {
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text(e.store_status),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DeviceScreen.routeName,
                                arguments: e,
                              );
                            },
                          );
                        }).toList(),
                      )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                context
                                    .read<StoreProvider>()
                                    .fetchAndSetDevices1();
                              });
                            },
                            child: Text('清空'),
                          ),
                          if (context.read<StoreProvider>().in_store.isNotEmpty)
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  StoreScreen.routeName,
                                  arguments: context
                                      .read<StoreProvider>()
                                      .in_store
                                      .toList(),
                                );
                              },
                              child: Text('出库'),
                            ),
                          if (context
                              .read<StoreProvider>()
                              .out_store
                              .isNotEmpty)
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  StoreScreen.routeName,
                                  arguments: context
                                      .read<StoreProvider>()
                                      .out_store
                                      .toList(),
                                );
                              },
                              child: Text('入库'),
                            )
                        ],
                      ),
                    )
                  ],
                );
              }
              return const Center(
                child: Text('是否要出入库？请点扫描按钮！'),
              );
            }));
  }
}
