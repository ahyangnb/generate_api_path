import 'package:args/args.dart';
import 'package:generate_api_path/generate_api_path.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addOption('origin_file_path');
  parser.addOption('target_file_path');
  parser.addOption('mode');

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
  if (parsedArgs['mode'] == null) {
    throw Exception('mode is required');
  }
  if (parsedArgs['mode'] != "debug" && parsedArgs['mode'] != "release") {
    throw Exception('mode param is error');
  }
  final originFilePath = parsedArgs['origin_file_path'];
  final targetFilePath = parsedArgs['target_file_path'];
  final mode = parsedArgs['mode'];

  print(
    "originFilePath: $originFilePath\n"
    "target_file_path: $targetFilePath\n"
    "mode: ${parsedArgs['mode']}\n",
  );

  GenerateApiPath.run(
    originFilePath: originFilePath,
    targetFilePath: targetFilePath,
    mode: mode,
  );
}
