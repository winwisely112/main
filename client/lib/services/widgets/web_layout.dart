import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  const WebLayout({this.mobileLayout, this.webLayout});

  final Widget mobileLayout;
  final Widget webLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (kIsWeb ||
            debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
          return webLayout;
        } else {
          return mobileLayout;
        }
      },
    );
  }
}
