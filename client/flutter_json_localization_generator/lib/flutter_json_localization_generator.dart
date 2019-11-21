import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import 'package:analyzer/dart/element/element.dart';

import 'flutter_json_localization.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

import 'src/builder.dart';
import 'src/localizations.dart';

class JSONLocalizationGenerator
    extends GeneratorForAnnotation<JSONLocalization> {
  const JSONLocalizationGenerator();

  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (!element.name.endsWith('Delegate')) {
      final String name = element.name;
      throw InvalidGenerationSourceError(
          'Generator for target `$name` should be and end with `Delegate`.',
          todo:
          'Refactor the class name `$name` for a name ending with `Delegate` (example: `${name}Delegate`).',
          element: element);
    }
    final ClassElement classElement = element;

    final InterfaceType localizationDelegateSupertype = classElement
        .allSupertypes
        .firstWhere((dynamic x) => x.name == 'LocalizationsDelegate');
    if (localizationDelegateSupertype != null) {
      final String path =
      annotation.objectValue.getField('path').toStringValue();
      Localizations localizations = await _generateLocalizations(path);

      localizations = localizations.copyWith(
          name: classElement.name.replaceAll('Delegate', ''));
      final DartBuilder builder = DartBuilder();
      return builder.build(localizations);
    }
  }
}

Future<Map<String, dynamic>> localesJSON(List<FileSystemEntity> files) async {
  final Map<String, dynamic> localizationsJSON = <String, dynamic>{};
  final List<FileSystemEntity> overrideFiles = files
      .where((FileSystemEntity file) => file.path.contains('human'))
      .toList();
  files.removeWhere((FileSystemEntity file) => file.path.contains('human'));
  for (File file in files) {
    final String filePath = file.path;
    final String fileName = p.basename(filePath);
    final String language = RegExp(r'([^\s|^\.]+)').firstMatch(fileName).group(0);
    final Map<String, dynamic> fileContents = await File(filePath)
        .readAsString()
        .then((String fileContent) => json.decode(fileContent));
    localizationsJSON.addAll(<String, dynamic>{language: fileContents});
  }
  if (overrideFiles.isNotEmpty) {
    for (File file in overrideFiles) {
      final String filePath = file.path;
      final String fileName = p.basename(filePath);
      final String language = RegExp(r'([^\s]+)').stringMatch(fileName);
      final Map<String, dynamic> fileContents = await File(filePath)
          .readAsString()
          .then((String fileContent) => json.decode(fileContent));
      fileContents.removeWhere((String key, dynamic value) => value.isEmpty);
      localizationsJSON[language].addAll(fileContents);
    }
  }
  return localizationsJSON;
}

Future<dynamic> _generateLocalizations(String path) async {
  try {
    final Directory directory =
    Directory(path);
    final List<FileSystemEntity> files = directory.listSync().toList();
    final Map<String, dynamic> localizationsJSON = await localesJSON(files);
    final List<String> index = localizationsJSON.keys.toList()..insert(0, "Key");
    final List<List<String>> localizations = <List<String>>[index];
    final List<dynamic> values = localizationsJSON.values.toList();
    final List<String> valueKeys = values[0].keys.toList();
    for (String key in valueKeys) {
      final List<String> locales = <String>[key];
      for (dynamic value in values) {
        locales.add(value[key]);
      }
      localizations.add(locales);
    }

    final Localizations result = Localizations(
        supportedLanguageCodes: index
            .skip(1)
            .cast<String>()
            .map((String x) => x.trimRight().replaceAll("\n", ""))
            .takeWhile((String x) => x != null && x.isNotEmpty)
            .toList());

    for (int i = 1; i < localizations.length; i++) {
      final List<String> row = localizations[i];
      if (row.length > 1) {
        final String path = row[0].toString().trim();
        if (path.isNotEmpty) {
          final List<Translation> translations = row
              .asMap()
              .entries
              .skip(1)
              .take(result.supportedLanguageCodes.length)
              .map((e) => Translation(index[e.key], e.value))
              .toList();
          result.insert(path, translations);
        }
      }
    }
    return result;
  } catch (error) {
    log.info(error);
  }
}
