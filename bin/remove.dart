import 'package:args/args.dart';

void main(List<String> args) {
  final parser = ArgParser();

  parser.addOption('path');
  parser.addOption('flavor');

  final parsedArgs = parser.parse(args);
  print(
    "welcome to remove command\n"
    "Your param is $parsedArgs\n",
  );
}
