import 'dart:io';
import 'package:intl/intl.dart';

void main() async {
  const filename = 'pubspec.yaml';
  final file = File(filename);
  String content = await file.readAsString();

  RegExp versionPattern = RegExp(r'version: (\d+\.\d+\.\d+)\+(\d+)');
  Match? match = versionPattern.firstMatch(content);

  if (match != null) {
    String baseVersion = match.group(1)!;
    String timestamp = DateFormat('yyMMddHHmm').format(DateTime.now());
    int intTimestamp = int.parse(timestamp);

    String newVersion = 'version: $baseVersion+$intTimestamp';

    content = content.replaceAll(versionPattern, newVersion);
    await file.writeAsString(content);

    print('Updated version to $newVersion');
  } else {
    print('Version pattern not found in pubspec.yaml');
  }
}
