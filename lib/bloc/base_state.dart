abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class ErrorState extends BaseState {
  final String msg;
  ErrorState(this.msg);
}
