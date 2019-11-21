import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'services_provider.dart';

void main() {
  if (kIsWeb) {
    runApp(ServicesProvider());
  } else {
    runApp(DevicePreview(
      builder: (BuildContext context) => ServicesProvider(),
    ));
  }
}
