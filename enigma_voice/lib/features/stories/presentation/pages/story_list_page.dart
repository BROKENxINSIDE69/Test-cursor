import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../stories/domain/entities/story.dart';
import '../../../stories/domain/repositories/story_repository.dart';

class StoryListPage extends StatefulWidget {
  const StoryListPage({super.key});

  @override
  State<StoryListPage> createState() => _StoryListPageState();
}

class _StoryListPageState extends State<StoryListPage> {
  late Future<List<Story>> _future;

  @override
  void initState() {
    super.initState();
    _future = GetIt.I<StoryRepository>().fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enigma Voice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            onPressed: () => context.push('/leaderboard'),
          ),
        ],
      ),
      body: FutureBuilder<List<Story>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final stories = snapshot.data!;
          return ListView.separated(
            itemCount: stories.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final s = stories[index];
              return ListTile(
                title: Text(s.title),
                subtitle: Text(s.author),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/story/${s.id}'),
              );
            },
          );
        },
      ),
    );
  }
}