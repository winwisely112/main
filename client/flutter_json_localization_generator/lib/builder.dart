import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter_json_localization_generator/flutter_json_localization_generator.dart';

Builder flutterJSONLocalization(BuilderOptions options) => SharedPartBuilder(
    <Generator>[JSONLocalizationGenerator()], 'flutter_json_localization');
