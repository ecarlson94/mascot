import '../../clean_architecture/entity.dart';

abstract class HiveModel<T> implements Entity {
  T copyWithId(Id id);
}
