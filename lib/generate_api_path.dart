library generate_api_path;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

/// A Calculator.
class GenerateApiPath {
  static Future<void> run({
    required String originFilePath,
    required String targetFilePath,
    required String mode,
    required String apiPath,
    required String? imPath,
    required String? logPath,
    required String? className,
    required bool skipIfContainsPostV2,
    required String? removeStartWIth,
    required String? removeEndWIth,
  }) async {
    final file = File(originFilePath);
    if (!file.existsSync()) {
      throw Exception('the originFilePath File not found');
    }
    String fileContentString = file.readAsStringSync();

    fileContentString = fileContentString.replaceAll('\n', '",\n"');
    fileContentString = fileContentString.replaceAll(' -> ', '":"');
    fileContentString = "{\"$fileContentString\"}";
    fileContentString = fileContentString.replaceAll('""', "");
    fileContentString = "const methodMappingMap = $fileContentString;";

    print(
      "fileContentString::\n"
      "$fileContentString",
    );

    var parseResult =
        parseString(content: fileContentString, throwIfDiagnostics: false);
    var unit = parseResult.unit;

    for (var declaration in unit.declarations) {
      if (declaration is TopLevelVariableDeclaration) {
        var firstVariable = declaration.variables.variables.first;
        var value = firstVariable.initializer;
        handleFile(
          json.decode(value.toString()),
          mode: mode,
          targetFilePath: targetFilePath,
          apiPath: apiPath,
          imPath: imPath,
          logPath: logPath,
          className: className,
          skipIfContainsPostV2: skipIfContainsPostV2,
          removeStartWIth: removeStartWIth,
          removeEndWIth: removeEndWIth,
        );
        break;
      }
    }
  }

  static void handleFile(
    Map<String, dynamic> mapValue, {
    required String mode,
    required String targetFilePath,
    required String apiPath,
    required String? imPath,
    required String? logPath,
    required String? className,
    required bool skipIfContainsPostV2,
    required String? removeStartWIth,
    required String? removeEndWIth,
  }) {
    final buffer = StringBuffer();
    buffer.writeln("// GENERATED CODE - DO NOT MODIFY BY HAND");

    buffer.writeln("");
    buffer.writeln("""
// **************************************************************************
// Q1 generate_api_path - UrlGenerator
// **************************************************************************
""");
    buffer.writeln("");
    buffer.writeln('const String apiUrl = \'$apiPath\';');
    if (imPath != null) {
      buffer.writeln('const String imPath = \'$imPath\';');
    }
    if (logPath != null) {
      buffer.writeln('const String logPath = \'$logPath\';');
    }
    buffer.writeln("");
    buffer.writeln('class ${className ?? "UrlGenerator"} {');
    try {
      mapValue.forEach(
        (key, value) {
          String constantName = value!
              .replaceAll('/', '_')
              .replaceAll('-', '_')
              .replaceAll('{', '_')
              .replaceAll('-', '_')
              .replaceAll('}', '_');

          /// Remove all of the special characters and Set the first letter to uppercase.
          constantName = constantName
              .split('_')
              .where((word) => word.isNotEmpty)
              .map((word) {
            return word[0].toUpperCase() + word.substring(1);
          }).join('');

          /// Lowercase the first letter
          constantName =
              constantName[0].toLowerCase() + constantName.substring(1);
          final runInDebug = mode == "debug";

          final resultValue = "'${runInDebug ? value : "/$key"}';";
          if (skipIfContainsPostV2) {
            final useToCheck =
                '${resultValue.substring(1, resultValue.length - 2)}PostV2';
            if (mapValue.containsValue(useToCheck)) {
              print('mapValue contains $resultValue/PostV2, just jump');
            } else {
              writeToLine(constantName, resultValue, buffer,
                  removeStartWIth: removeStartWIth,
                  removeEndWIth: removeEndWIth);
            }
          } else {
            writeToLine(constantName, resultValue, buffer,
                removeStartWIth: removeStartWIth, removeEndWIth: removeEndWIth);
          }
        },
      );
    } catch (e) {
      buffer.writeln('// Some error happen ${e.toString()}');
    }
    buffer.writeln('}');

    final resultContent = buffer.toString();

    File file = File(targetFilePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(resultContent);
  }

  static void writeToLine(
    String constantName,
    String resultValue,
    StringBuffer buffer, {
    required String? removeStartWIth,
    required String? removeEndWIth,
  }) {
    if (removeStartWIth != null) {
      for (var element in removeStartWIth.split(",")) {
        if (resultValue.substring(1).startsWith(element.trim())) {
          return;
        }
      }
    }
    if (removeEndWIth != null) {
      for (var element in removeEndWIth.split(",")) {
        final subs = resultValue.substring(0, resultValue.length - 2);
        if (subs.endsWith(element.trim())) {
          return;
        }
      }
    }
    buffer.writeln('  static const String $constantName = $resultValue');
  }
}
