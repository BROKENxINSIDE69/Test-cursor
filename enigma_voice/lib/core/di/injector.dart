import 'package:get_it/get_it.dart';

import '../services/tts_service.dart';
import '../services/gemini_service.dart';
import '../services/hive_service.dart';
import '../../features/stories/data/repositories/story_repository_impl.dart';
import '../../features/stories/domain/repositories/story_repository.dart';

void setupInjector(GetIt getIt) {
  if (getIt.isRegistered<TtsService>()) return;

  // Core services
  getIt.registerLazySingleton<TtsService>(() => TtsService());
  getIt.registerLazySingleton<GeminiService>(() => GeminiService());
  getIt.registerLazySingleton<HiveService>(() => HiveService());

  // Feature repositories
  getIt.registerLazySingleton<StoryRepository>(() => StoryRepositoryImpl());
}