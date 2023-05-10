import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/data/failure_or_id_future.dart';
import '../entities/mascot.dart';

typedef MascotSingle = Single<Mascot>;
typedef MascotStream = Stream<Mascot>;

abstract class MascotsRepository {
  /// Adds a mascot
  IdSingle saveMascot(Mascot mascot);

  /// Gets a mascot by Id
  MascotSingle getMascot(Id id);

  /// Stream of a specific mascot
  MascotStream streamMascot(Id id);
}
