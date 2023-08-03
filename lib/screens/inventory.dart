import 'package:flutter/material.dart';
import 'package:app/providers/scan.dart';
import 'package:app/providers/inventory.dart';
import 'package:provider/provider.dart';
import 'device.dart';
import 'inventory_submit.dart';

class Inventory extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _Inventory createState() => _Inventory();
}

class _Inventory extends State<Inventory> {
  late Future<void> _initialData;
  int _position = 0;
  List<bool> arr = [];
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _initialData = _loadEntries();
    _controller = TextEditingController();
  }

  Future<void> _loadEntries() async {
    final inventoryProvider = context.read<InventoryProvider>();

    await Future.wait([
      inventoryProvider.fetchAndSetDevices2(),
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
              if (context.read<InventoryProvider>().device.isEmpty) {
                context.read<InventoryProvider>().fetchAndSetDevices();
              } else {
                context.read<InventoryProvider>().fetchAndSetDevices1();
              }
            });
          },
        ),
        body: FutureBuilder(
            future: _initialData,
            builder: (context, snapshot) {
              if (context.read<InventoryProvider>().device.isNotEmpty) {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 9,
                      child: SingleChildScrollView(
                        child: ExpansionPanelList(
                            expansionCallback: (panelIndex, isExpanded) {
                              setState(() {
                                _position = isExpanded ? -1 : panelIndex;
                              });
                            },
                            expandedHeaderPadding: EdgeInsets.zero,
                            children: [
                              ExpansionPanel(
                                  isExpanded: _position == 0,
                                  headerBuilder: (context, isExpanded) => Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          const Icon(
                                              Icons.access_time_outlined),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '待盘点(共${context.read<InventoryProvider>().device.length}个)(已选${context.read<InventoryProvider>().checkedNum()}个)',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                  canTapOnHeader: true,
                                  body: Container(
                                      height: 350,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: context
                                            .read<InventoryProvider>()
                                            .device
                                            .map((e) {
                                          return ListTile(
                                            title: Text(e.name),
                                            leading: Checkbox(
                                              onChanged: (value) {
                                                if (value != null) {
                                                  setState(() {
                                                    e.checked = value;
                                                  });
                                                }
                                              },
                                              value: e.checked ?? false,
                                            ),
                                            subtitle: Text(e.message ?? ''),
                                            trailing: IconButton(
                                              icon:
                                                  const Icon(Icons.assignment),
                                              onPressed: () async {
                                                _controller =
                                                    TextEditingController(
                                                        text: e.message);
                                                return showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text(e.name),
                                                    content: TextField(
                                                      controller: _controller,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: '备注'),
                                                      onSubmitted: (value) {},
                                                    ),
                                                    actions: [
                                                      RawMaterialButton(
                                                        child: Text('确定'),
                                                        onPressed: () {
                                                          setState(() {
                                                            e.message =
                                                                _controller
                                                                    .text;
                                                          });

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('关闭'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                DeviceScreen.routeName,
                                                arguments: e,
                                              );
                                            },
                                          );
                                        }).toList(),
                                      )))),
                              ExpansionPanel(
                                  isExpanded: _position == 1,
                                  headerBuilder: (context, isExpanded) => Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.beenhere_outlined,
                                            color: context
                                                        .read<
                                                            InventoryProvider>()
                                                        .checkedNum() !=
                                                    0
                                                ? Colors.blue
                                                : Colors.black,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '已盘点(共${context.read<InventoryProvider>().device.length}个)',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                                color: context
                                                            .read<
                                                                InventoryProvider>()
                                                            .checkedNum() !=
                                                        0
                                                    ? Colors.blue
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                  canTapOnHeader: true,
                                  body: Container(
                                      height: 350,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: context
                                            .read<InventoryProvider>()
                                            .device
                                            .map((e) {
                                          return ListTile(
                                            textColor: e.checked!
                                                ? Colors.blue
                                                : Colors.black,
                                            title: Text(e.name),
                                            subtitle: Text(e.message ?? ''),
                                            trailing: PopupMenuButton(
                                              icon: const Icon(Icons.more_vert),
                                              onSelected: (value) async {
                                                if (value == '备注') {
                                                  _controller =
                                                      TextEditingController(
                                                          text: e.message);
                                                  return showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      title: Text(e.name),
                                                      content: TextField(
                                                        controller: _controller,
                                                        decoration: InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText: '备注'),
                                                        onSubmitted: (value) {},
                                                      ),
                                                      actions: [
                                                        RawMaterialButton(
                                                          child: Text('确定'),
                                                          onPressed: () {
                                                            setState(() {
                                                              e.message =
                                                                  _controller
                                                                      .text;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text('关闭'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                              onCanceled: () {
                                                print(111);
                                              },
                                              itemBuilder: (context) => [
                                                PopupMenuItem<String>(
                                                  value: '备注',
                                                  child: Text('修改备注'),
                                                  onTap: () {
                                                    print(222);
                                                  },
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: '盘点',
                                                  child: Text('撤销盘点'),
                                                )
                                              ],
                                            ),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                DeviceScreen.routeName,
                                                arguments: e,
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ))))
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              setState(() {
                                context
                                    .read<InventoryProvider>()
                                    .fetchAndSetDevices2();
                              });
                            },
                            child: Text('重新盘点'),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SubmitScreen.routeName,
                                arguments: context
                                    .read<InventoryProvider>()
                                    .device
                                    .toList(),
                              );
                            },
                            child: Text('提交盘点'),
                          ),
                          if (context
                              .read<InventoryProvider>()
                              .device[0]
                              .checked!)
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text('确认盘点'),
                            ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return const Center(
                child: Text('是否要开始盘点？请点扫描按钮！'),
              );
            }));
  }
}
