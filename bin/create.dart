import 'package:args/args.dart';

// dart run generate_api_path:create --origin_file_path material/pairuplater.xyz.txt --target_file_path lib/gen/http/api_mapping_ok.dart --mode debug
// dart run generate_api_path:create --origin_file_path material/pairuplater.xyz.txt --target_file_path lib/gen/http/api_mapping_ok.dart --mode release
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

  print(
    "origin_file_path: ${parsedArgs['origin_file_path']}\n"
    "target_file_path: ${parsedArgs['target_file_path']}\n"
    "mode: ${parsedArgs['mode']}\n",
  );
}
