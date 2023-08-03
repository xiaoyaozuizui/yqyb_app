import 'package:flutter/material.dart';
import 'package:app/models/device/devices.dart';

import 'package:app/theme/theme.dart';

class StoreScreen extends StatefulWidget {
  static const routeName = '/store';

  @override
  _StoreScreen createState() => _StoreScreen();
}

class _StoreScreen extends State<StoreScreen> {
  final _userController = TextEditingController();
  final Map<String, String> _Data = {'user': '', 'cause': '', 'phone': ''};
  Set<Device> _list = {};
  List<bool> arr = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Device> args =
        ModalRoute.of(context)!.settings.arguments as List<Device>;
    final String message = args[0].store_status == '在库' ? '出库' : '入库';

    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(message)),
      body: Form(
          child: Flex(direction: Axis.vertical, children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: '使用人',
                    errorMaxLines: 1,
                    prefixIcon: const Icon(Icons.account_circle)),
                controller: _userController,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _Data['user'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '联系方式',
                    errorMaxLines: 1,
                    prefixIcon: const Icon(Icons.account_circle)),
                controller: _userController,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _Data['phone'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '$message事由',
                    errorMaxLines: 1,
                    prefixIcon: const Icon(Icons.account_circle)),
                controller: _userController,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _Data['cause'] = value!;
                },
              ),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: ListTile(
              title: Row(
                children: [
                  Icon(Icons.abc),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                      '$message设备(${arr.isEmpty ? args.length : _list.length})')
                ],
              ),
            )),
        Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                  children: args
                      .map(
                        (e) => CheckboxListTile(
                          value: arr.isEmpty ? true : arr[args.indexOf(e)],
                          title: Text(e.name),
                          onChanged: (value) {
                            if (arr.isEmpty) {
                              arr = args.map((e) => true).toList();
                              _list = args.toSet();
                            }
                            setState(() {
                              if (value != null) arr[args.indexOf(e)] = value;
                              if (value == true) {
                                _list.add(e);
                              }
                              if (value == false) {
                                _list.remove(e);
                              }
                              print(_list);
                            });
                          },
                        ),
                      )
                      .toList()),
            )),
        GestureDetector(
          onTap: () {},
          child: Container(
            key: const Key('actionButton'),
            width: double.infinity,
            height: 0.065 * deviceSize.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: wgerPrimaryColor,
            ),
            child: Center(
              child: Text(
                '$message',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
