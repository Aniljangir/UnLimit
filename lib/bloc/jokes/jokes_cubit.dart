import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:unlimit_demo/bloc/base_state.dart';
import 'package:unlimit_demo/bloc/jokes/jokes_state.dart';
import 'package:unlimit_demo/configs/logging_utils.dart';
import 'package:unlimit_demo/data/local/app_storage_impl.dart';
import 'package:unlimit_demo/data/model/joke_model.dart';
import 'package:unlimit_demo/repository/jokes/jokes_repository.dart';
import 'dart:math' as math;

class JokesCubit extends Cubit<BaseState> {
  final JokesRepository jokesRepository;
  final AppStorageImpl localStorage;
  bool isFetching = false;
  Timer? _apiTimer;
  final int _apiTimerDurationInMin = 1;

  List<Color> jokeColorList = [
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
  ];

  JokesCubit({
    required this.jokesRepository,
    required this.localStorage,
  }) : super(InitialState()) {
    /// fetch jokes from local storage
    _fetchAllJokes();

    /// start observing joke database changes
    _observingNewJokes();
  }

  void _updateJokesFromApi() async {
    Logging().logger.e('fetching data');
    emit(LoadingState());
    final query = {
      'format': 'json',
    };
    final response = await jokesRepository.getJokes(query: query);
    Logging().logger.e('fetchRemoteJoke response ${response.toJson()}');
    if (response.status) {
      final model = JokeModel.fromJson(Map.from(response.data));
      if (model.joke.isNotEmpty) {
        final jokes = await localStorage.getAllJokes();
        if (jokes.length == 10) {
          await localStorage.removeJokeFromAppStorage();
        }
        await localStorage.addJokeIntoAppStorage(model.joke);
      }
    } else {
      emit(ErrorState(response.errorMessage));
    }

    /// initiate api timer
    _initiateApiTimer();
  }

  /// fetch the jokes from local storage
  void _fetchAllJokes() async {
    List<String> list = await localStorage.getAllJokes();
    postUpdatedData(list);
    _updateJokesFromApi();
  }

  /// start observing joke database changes
  void _observingNewJokes() async {
    final Stream<BoxEvent> stream = await localStorage.getJokesAsStream();
    final Stream<Future<List<String>>> streamMapper = stream.map((event) async {
      final jokeList = await localStorage.getAllJokes();
      return jokeList;
    });
    streamMapper.listen((event) async {
      List<String> list = await event;
      postUpdatedData(list);
    });
  }

  void _initiateApiTimer() {
    _apiTimer = Timer.periodic(Duration(minutes: _apiTimerDurationInMin),
        (Timer timer) {
      _apiTimer?.cancel();
      _updateJokesFromApi();
    });
  }

  @override
  Future<void> close() {
    _apiTimer?.cancel();
    return super.close();
  }

  void postUpdatedData(List<String> list) {
    emit(JokesState(
      jokes: list,
    ));
  }
}
