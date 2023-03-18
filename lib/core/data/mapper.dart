abstract class Mapper<TIn, TOut> {
  TOut map(TIn input);
  TIn reverse(TOut input);
}
