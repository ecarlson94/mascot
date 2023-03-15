import '../../../../core/data/mapper.dart';
import '../../domain/entities/mascot.dart';
import 'mascot_model.dart';

abstract class MapMascotToMascotModel extends Mapper<Mascot, MascotModel> {
  MapMascotToMascotModel();

  @override
  Mascot reverse(MascotModel input) => Mascot(
        id: input.id,
        name: input.name,
        expressions: input.expressions,
      );
}
