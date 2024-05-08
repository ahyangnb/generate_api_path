import 'package:args/args.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addOption('path');
  parser.addOption('flavor');
  parser.addOption('flavors');

  final parsedArgs = parser.parse(args);
  print(
    "welcome to create command\n"
    "Your param is $parsedArgs\n",
  );

  if (parsedArgs['flavor'] != null && parsedArgs['flavors'] != null) {
    throw Exception('Cannot use both flavor and flavors arguments');
  }
}
