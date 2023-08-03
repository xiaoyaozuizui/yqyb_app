import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url, BuildContext context) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  final launched = await launchUrl(Uri.parse(url));
  if (!launched) {
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text('Could not open $url.')),
    );
  }
}
