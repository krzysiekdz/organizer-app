import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotations.dart';

class MyJsonGenerator extends GeneratorForAnnotation<MyJsonSerializable> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';

    final className = element.name;
    final fields = element.fields
        .where((f) => !f.isStatic && f.isPublic)
        .map((f) => "    '${f.name}': ${f.name},")
        .join('\n');

    return '''
extension ${className}JsonSerializable on $className {
  Map<String, dynamic> toJson() => {
$fields
  };
}
''';
  }
}

class MyCopyWithGenerator extends GeneratorForAnnotation<MyCopyWith> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) return '';

    final className = element.name;
    final fieldList = element.fields
        .where((f) => !f.isStatic && f.isPublic)
        .toList();

    final copyWithParams = fieldList
        .map((f) => "    ${f.type}? ${f.name},")
        .join('\n');

    final copyWithBody = fieldList
        .map((f) => "      ${f.name}: ${f.name} ?? this.${f.name},")
        .join('\n');

    return '''
extension ${className}CopyWith on $className {
  $className copyWith({
$copyWithParams
  }) {
    return $className(
$copyWithBody
    );
  }
}
''';
  }
}
