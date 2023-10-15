import 'package:unlimit_demo/bloc/base_state.dart';

class JokesState extends BaseState {
  final List<String> jokes;

  JokesState({
    required this.jokes,
  });
}
