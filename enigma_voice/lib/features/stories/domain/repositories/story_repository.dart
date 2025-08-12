import '../entities/story.dart';

abstract class StoryRepository {
  Future<List<Story>> fetchStories();
  Future<Story?> getStoryById(String id);
}