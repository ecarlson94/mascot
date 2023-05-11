import 'package:rxdart/rxdart.dart';

extension IterableExtensions<T> on Iterable<T> {
  /// Returns a [Stream] that emits the items in this [Iterable].
  Stream<T> get stream => Stream.fromIterable(this);
}

extension StreamIterableExtensions<T> on Iterable<Stream<T>> {
  Stream<T> mergeStreams() => MergeStream(this);
  Stream<T> concatStreams() => ConcatStream(this);
  Stream<List<T>> compineLatest() => CombineLatestStream.list(this).share();
}
