import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String storiesBox = 'stories_box';
  static const String progressBox = 'progress_box';

  static Future<void> ensureCoreBoxes() async {
    await Future.wait([
      Hive.openBox(storiesBox),
      Hive.openBox(progressBox),
    ]);
  }
}