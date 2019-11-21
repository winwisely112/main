import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'flutter_json_localization_generator.dart';

Builder flutterJSONLocalization(BuilderOptions options) => SharedPartBuilder(
    <Generator>[const JSONLocalizationGenerator()], 'flutter_json_localization');
