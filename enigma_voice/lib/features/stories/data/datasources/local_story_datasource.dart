import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/services/hive_service.dart';
import '../../domain/entities/story.dart';

class LocalStoryDataSource {
  final Box _storiesBox = Hive.box(HiveService.storiesBox);

  Future<List<Story>> loadStories() async {
    final cached = _storiesBox.get('stories_json') as String?;
    if (cached != null) {
      return _decodeStoriesJson(cached);
    }
    // Fallback to asset sample on first run
    final sampleText = await rootBundle.loadString('assets/stories/sample_story.txt');
    final sample = Story(
      id: 'sample-001',
      title: 'हवेली का रहस्य',
      author: 'Enigma Voice',
      languageCode: 'hi',
      text: sampleText,
      solution: 'हत्यारा बटलर था',
    );
    final list = [sample];
    final jsonString = jsonEncode(list.map((s) => {
          'id': s.id,
          'title': s.title,
          'author': s.author,
          'languageCode': s.languageCode,
          'text': s.text,
          'solution': s.solution,
        }).toList());
    await _storiesBox.put('stories_json', jsonString);
    return list;
  }

  Future<Story?> getById(String id) async {
    final all = await loadStories();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Story> _decodeStoriesJson(String jsonString) {
    final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => Story(
              id: e['id'] as String,
              title: e['title'] as String,
              author: e['author'] as String,
              languageCode: e['languageCode'] as String,
              text: e['text'] as String,
              solution: e['solution'] as String,
            ))
        .toList();
  }
}