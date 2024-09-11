import 'package:args/args.dart';
import 'package:generate_api_path/generate_api_path.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addOption('logPath');
  parser.addOption('mode');

  final parsedArgs = parser.parse(args);
  print(
    "welcome to create command\n"
    "Your param is $parsedArgs\n",
  );

  if (parsedArgs['logPath'] == null) {
    throw Exception('logPath is required');
  }
  if (parsedArgs['mode'] == null) {
    throw Exception('mode is required');
  }
  if (parsedArgs['mode'] != "debug" && parsedArgs['mode'] != "release") {
    throw Exception('mode param is error');
  }
  final logPath = parsedArgs['logPath'];
  final mode = parsedArgs['mode'];

  print(
    "logPath: $logPath\n"
    "mode: ${parsedArgs['mode']}\n",
  );

  // GenerateApiPath.run(
  //   originFilePath: originFilePath,
  //   targetFilePath: targetFilePath,
  //   mode: mode,
  //   apiPath: apiPath,
  //   imPath: imPath,
  //   logPath: logPath,
  // );
}
