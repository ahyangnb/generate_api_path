import 'package:args/args.dart';
import 'package:generate_api_path/generate_api_path.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addOption('origin_file_path');
  parser.addOption('target_file_path');
  parser.addOption('apiPath');
  parser.addOption('imPath');
  parser.addOption('logPath');
  parser.addOption('mode');
  parser.addOption('className');
  parser.addOption("skipIfContainsPostV2");
  parser.addOption("removeStartWIth");
  parser.addOption("removeEndWIth");

  final parsedArgs = parser.parse(args);
  print(
    "welcome to create command\n"
    "Your param is $parsedArgs\n",
  );

  if (parsedArgs['origin_file_path'] == null) {
    throw Exception('origin_file_path is required');
  }
  if (parsedArgs['target_file_path'] == null) {
    throw Exception('target_file_path is required');
  }
  if (parsedArgs['apiPath'] == null) {
    throw Exception('apiPath is required');
  }
  if (parsedArgs['mode'] == null) {
    throw Exception('mode is required');
  }
  if (parsedArgs['mode'] != "debug" && parsedArgs['mode'] != "release") {
    throw Exception('mode param is error');
  }
  final originFilePath = parsedArgs['origin_file_path'];
  final targetFilePath = parsedArgs['target_file_path'];
  final apiPath = parsedArgs['apiPath'];
  final imPath = parsedArgs['imPath'];
  final logPath = parsedArgs['logPath'];
  final mode = parsedArgs['mode'];
  final className = parsedArgs['className'];
  final bool skipIfContainsPostV2 =
      int.parse("${parsedArgs['skipIfContainsPostV2'] ?? "0"}") == 1;

  /// String, divided by ","
  final removeStartWIth = parsedArgs['removeStartWIth'];
  final removeEndWIth = parsedArgs['removeEndWIth'];

  print(
    "originFilePath: $originFilePath\n"
    "target_file_path: $targetFilePath\n"
    "apiPath: $apiPath\n"
    "imPath: $imPath\n"
    "logPath: $logPath\n"
    "mode: $mode\n"
    "className: $className\n"
    "skipIfContainsPostV2: $skipIfContainsPostV2\n"
    "removeStartWIth: $removeStartWIth\n"
    "removeEndWIth: $removeEndWIth\n",
  );

  GenerateApiPath.run(
    originFilePath: originFilePath,
    targetFilePath: targetFilePath,
    mode: mode,
    apiPath: apiPath,
    imPath: imPath,
    logPath: logPath,
    className: className,
    skipIfContainsPostV2: skipIfContainsPostV2,
    removeStartWIth: removeStartWIth,
    removeEndWIth: removeEndWIth,
  );
}
