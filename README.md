# Generate api path.

a plugin can be generated different api path file.

## Usage

import the `generate_api_path` and `analyzer` plugin in `pubspec.yaml` file.

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  # This one.
  generate_api_path: ^0.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  # This one.
  analyzer: ^6.2.0
```

make a file `origin.txt` on `material` directory, and write the api path in it.

the key is code and the value is the path.

```txt
00000000-00000000-00000-000000000000 -> /user/info
00000000-00000000-00000-000000000001 -> /system/hi/notice
00000000-00000000-00000-000000000002 -> /flower/hi/good
```

then run the command:

```shell
dart run generate_api_path:create --origin_file_path material/origin.txt --target_file_path lib/gen/http/api_mapping_generate.dart --mode debug
```

or

```shell
dart run generate_api_path:create --origin_file_path material/origin.txt --target_file_path lib/gen/api_mapping_generate.dart --mode release
```

it will generate a file `api_mapping_generate.dart` in `lib/gen` directory and the content is:

```dart
class UrlGenerator {
  static const String userInfo = '/user/info';
  static const String systemHiNotice = '/system/hi/notice';
  static const String flowerHiGood = '/flower/hi/good';
}
```

more detail see the [example](example) directory.