import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../features/expressions/domain/entities/image.dart';
import '../../error/failure.dart';
import 'input_converter.dart';

@injectable
class ConvertXfileToImage extends InputConverter<XFile, Image> {
  @override
  Future<Either<Failure, Image>> call(XFile input) async {
    if (input.name.isEmpty) return Left(InvalidInputFailure());
    var data = await input.readAsBytes();
    if (data.isEmpty) return Left(InvalidInputFailure());

    return Right(
      Image(
        name: input.name,
        data: data,
      ),
    );
  }
}
