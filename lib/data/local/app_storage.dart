import 'package:hive/hive.dart';

abstract class AppStorage {
  Future<void> init();

  Future<void> addJokeIntoAppStorage(String joke);

  Future<void> removeJokeFromAppStorage();

  Future<List<String>> getAllJokes();

  Future<Stream<BoxEvent>> getJokesAsStream();

  Future<void> closeConnection();
}
