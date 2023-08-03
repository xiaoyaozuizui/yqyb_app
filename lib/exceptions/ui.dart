import 'dart:developer';

import 'package:flutter/material.dart';

import 'http_exception.dart';

void showErrorDialog(dynamic exception, BuildContext context) {
  log('showErrorDialog: ');
  log(exception.toString());
  log('=====================');

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('出错了!'),
      content: Text(exception.toString()),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

void showHttpExceptionErrorDialog(
    AppHttpException exception, BuildContext context) async {
  log('showHttpExceptionErrorDialog: ');
  log(exception.toString());
  log('-------------------');

  final List<Widget> errorList = [];
  for (final key in exception.errors!.keys) {
    // Error headers
    // Ensure that the error heading first letter is capitalized.
    final String errorHeaderMsg =
        key[0].toUpperCase() + key.substring(1, key.length);

    errorList.add(
      Text(
        errorHeaderMsg,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    // Error messages
    if (exception.errors![key] is String) {
      errorList.add(Text(exception.errors![key]));
    } else {
      for (final value in exception.errors![key]) {
        errorList.add(Text(value));
      }
    }
    errorList.add(const SizedBox(height: 8));
  }

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('出错了!'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [...errorList],
      ),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(ctx).closeButtonLabel),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );

  // This call serves no purpose The dialog above doesn't seem to show
  // unless this dummy call is present
  // showDialog(context: context, builder: (context) => Container());
}
