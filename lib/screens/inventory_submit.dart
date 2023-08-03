import 'package:flutter/material.dart';
import 'package:app/models/device/devices.dart';

import 'package:app/theme/theme.dart';

class SubmitScreen extends StatefulWidget {
  static const routeName = '/submit';

  @override
  _SubmitScreen createState() => _SubmitScreen();
}

class _SubmitScreen extends State<SubmitScreen> {
  final _userController = TextEditingController();
  final Map<String, String> _Data = {
    'cause': '',
    'message': '',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Device> args =
        ModalRoute.of(context)!.settings.arguments as List<Device>;

    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('提交盘点记录')),
      body: Form(
          child: Flex(direction: Axis.vertical, children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: '盘点名称',
                    errorMaxLines: 1,
                    prefixIcon: const Icon(Icons.account_circle)),
                controller: _userController,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _Data['cause'] = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: '盘点说明',
                    errorMaxLines: 1,
                    prefixIcon: const Icon(Icons.account_circle)),
                controller: _userController,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _Data['message'] = value!;
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
                  Text('盘点设备')
                ],
              ),
            )),
        Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                  children: args
                      .map(
                        (e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.message ?? ''),
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
                '提交',
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
