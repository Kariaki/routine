extension MapWithIndexExtension<E> on Iterable<E> {
  Iterable<T> mapWithIndex<T>(T Function(E element, int index) f) sync* {
    var index = 0;
    for (final element in this) {
      yield f(element, index);
      index++;
    }
  }
}
