import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../stories/domain/entities/story.dart';
import '../../../stories/domain/repositories/story_repository.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/services/gemini_service.dart';

class StoryReaderPage extends StatefulWidget {
  final String storyId;
  const StoryReaderPage({super.key, required this.storyId});

  @override
  State<StoryReaderPage> createState() => _StoryReaderPageState();
}

class _StoryReaderPageState extends State<StoryReaderPage> {
  Story? story;
  bool speaking = false;
  final TextEditingController _answerCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    story = await GetIt.I<StoryRepository>().getStoryById(widget.storyId);
    setState(() {});
  }

  Future<void> _speak() async {
    if (story == null) return;
    await GetIt.I<TtsService>().speak(story!.text);
    setState(() => speaking = true);
  }

  Future<void> _stop() async {
    await GetIt.I<TtsService>().stop();
    setState(() => speaking = false);
  }

  Future<void> _validate() async {
    if (story == null) return;
    final result = await GetIt.I<GeminiService>().validateAnswer(
      storyText: story!.text,
      userAnswer: _answerCtrl.text,
    );
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result.isCorrect ? 'सही उत्तर' : 'गलत उत्तर'),
        content: Text(result.explanation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ठीक है'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (story == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(story!.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  story!.text,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: speaking ? _stop : _speak,
                  icon: Icon(speaking ? Icons.stop : Icons.play_arrow),
                  label: Text(speaking ? 'रोकें' : 'सुनें'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _answerCtrl,
                    decoration: const InputDecoration(
                      hintText: 'आपका समाधान (हिंदी में)',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _validate,
                  child: const Text('जाँचें'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}