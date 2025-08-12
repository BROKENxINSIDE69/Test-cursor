// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:enigma_voice/app.dart';
import 'package:enigma_voice/features/stories/domain/entities/story.dart';
import 'package:enigma_voice/features/stories/domain/repositories/story_repository.dart';

class _FakeStoryRepository implements StoryRepository {
  final List<Story> _stories = const [
    Story(
      id: 't-1',
      title: 'टेस्ट कथा',
      author: 'Test',
      languageCode: 'hi',
      text: 'यह एक परीक्षण कथा है।',
      solution: 'समाधान',
    )
  ];

  @override
  Future<List<Story>> fetchStories() async => _stories;

  @override
  Future<Story?> getStoryById(String id) async => _stories.first;
}

void main() {
  setUp(() async {
    await GetIt.I.reset();
    GetIt.I.registerLazySingleton<StoryRepository>(() => _FakeStoryRepository());
  });

  testWidgets('App builds and shows title', (WidgetTester tester) async {
    await tester.pumpWidget(const EnigmaVoiceApp());
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Enigma Voice'), findsOneWidget);
  });
}
