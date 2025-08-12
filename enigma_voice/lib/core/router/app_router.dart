import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/stories/presentation/pages/story_list_page.dart';
import '../../features/stories/presentation/pages/story_reader_page.dart';
import '../../features/leaderboard/presentation/pages/leaderboard_page.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => const StoryListPage(),
          routes: <RouteBase>[
            GoRoute(
              path: 'story/:id',
              builder: (BuildContext context, GoRouterState state) {
                final id = state.pathParameters['id']!;
                return StoryReaderPage(storyId: id);
              },
            ),
            GoRoute(
              path: 'leaderboard',
              builder: (BuildContext context, GoRouterState state) => const LeaderboardPage(),
            ),
          ],
        ),
      ],
    );
  }
}