class State<T> {
  State._();
  factory State.success(T data) = SuccessState<T>;
  factory State.error(T msg) = ErrorState<T>;
}

class ErrorState<T> extends State<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends State<T> {
  SuccessState(this.data) : super._();
  final T data;
}
