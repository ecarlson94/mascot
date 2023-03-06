import 'dart:async';

abstract class Mapper<TIn, TOut> {
  FutureOr<TOut> call(TIn input);
  FutureOr<TIn> reverse(TOut input);
}
