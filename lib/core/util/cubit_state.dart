abstract class BaseState<T> {
  final T? data;
  final String? error;

  const BaseState({this.data, this.error});

  bool get hasData => data != null;

  bool get isSuccess => this is SuccessState<T>;

  bool get isLoading => this is LoadingState<T>;

  bool get isError => this is ErrorState<T>;

  @override
  String toString() {
    // TODO: implement toString
    return 'Data state';
  }
}

class LoadingState<T> extends BaseState<T> {
  const LoadingState({super.data});

  @override
  String toString() {
    // TODO: implement toString
    return 'Data loading';
  }
}

class InitialState<T> extends BaseState<T> {
  const InitialState({super.data});

  @override
  String toString() {
    return 'initial';
  }
}

class SuccessState<T> extends BaseState<T> {
  const SuccessState({super.data});

  @override
  String toString() {
    return 'Data success';
  }
}

class ErrorState<T> extends BaseState<T> {
  const ErrorState({super.data, super.error});

  @override
  String toString() {
    // TODO: implement toString
    return 'Data failed: $error';
  }
}
