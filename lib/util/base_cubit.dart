import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_state.dart';

/// short hand for defining a data cubit class with loading, error and success states
class BaseCubit<T> = Cubit<BaseState<T>> with CubitUtilsMixin<T>;

/// Util mixins that make it easier and quicker to emit initial, loading, error and success states
mixin CubitUtilsMixin<T> on Cubit<BaseState<T>> {
  T? get data => state.data;

  void emitError(String error) {
    if (isClosed) return;
    emit(ErrorState(error: error, data: state.data));
  }

  void emitLoading({T? data, nullifyError = true}) {
    if (isClosed) return;
    emit(LoadingState(data: data ?? state.data));
  }

  void emitSuccess({T? data}) {
    if (isClosed) return;
    emit(SuccessState(data: data??data));
  }

  /// this emits data to a non-special state ie: initial
  void emitInitial(T? data, {nullifyData = false}) {
    if (isClosed) return;
    emit(InitialState());
  }
}
