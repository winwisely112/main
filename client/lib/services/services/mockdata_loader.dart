import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<Map<String, dynamic>>> loadFile(final String fileName) async {
  final List<dynamic> list = await rootBundle
      .loadString('assets/mockData/$fileName/$fileName.json')
      .then((String fileContent) => json.decode(fileContent));
  return <Map<String, dynamic>>[
    for (dynamic item in list) Map<String, dynamic>.from(item)
  ];
}
