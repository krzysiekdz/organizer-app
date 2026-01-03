import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'generator.dart';

Builder myJsonBuilder(BuilderOptions options) =>
    PartBuilder([MyJsonGenerator()], '.json.dart');

Builder myCopyWithBuilder(BuilderOptions options) =>
    PartBuilder([MyCopyWithGenerator()], '.copy_with.dart');
