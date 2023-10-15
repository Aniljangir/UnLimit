import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unlimit_demo/data/local/app_storage.dart';

class AppStorageImpl implements AppStorage {
  static const _unLimitStorageName = 'un-limit-data-storage';
  static const _unLimitTableName = 'un-limit-data-table';

  @override
  Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    await BoxCollection.open(_unLimitStorageName, {_unLimitTableName},
        path: appDir.path);
  }

  @override
  Future<void> addJokeIntoAppStorage(String joke) async {
    final hiveBox = await Hive.openBox(_unLimitTableName);
    await hiveBox.add(joke);
    return Future.value();
  }

  @override
  Future<void> removeJokeFromAppStorage() async {
    final hiveBox = await Hive.openBox(_unLimitTableName);
    await hiveBox.deleteAt(0);
    return Future.value();
  }

  @override
  Future<List<String>> getAllJokes() async {
    final hiveBox = await Hive.openBox(_unLimitTableName);
    final jokeList = hiveBox.values.toList().map((e) => e as String).toList();
    return Future.value(jokeList);
  }

  @override
  Future<Stream<BoxEvent>> getJokesAsStream() async {
    final hiveBox = await Hive.openBox(_unLimitTableName);
    final stream = hiveBox.watch();
    return Future.value(stream);
  }

  @override
  Future<void> closeConnection() {
    return Hive.close();
  }
}
