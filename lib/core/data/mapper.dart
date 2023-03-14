import 'dart:async';

abstract class Mapper<TIn, TOut> {
  FutureOr<TOut> map(TIn input);
  FutureOr<TIn> reverse(TOut input);
}
