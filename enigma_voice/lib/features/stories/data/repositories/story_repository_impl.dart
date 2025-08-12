import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';
import '../datasources/local_story_datasource.dart';

class StoryRepositoryImpl implements StoryRepository {
  final LocalStoryDataSource _local = LocalStoryDataSource();

  @override
  Future<List<Story>> fetchStories() => _local.loadStories();

  @override
  Future<Story?> getStoryById(String id) => _local.getById(id);
}