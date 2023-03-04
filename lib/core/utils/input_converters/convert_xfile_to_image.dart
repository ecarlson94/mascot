import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../features/images/domain/entities/image.dart';
import '../../error/failure.dart';
import 'input_converter.dart';

@singleton
class ConvertXfileToImage extends InputConverter<XFile, Image> {
  @override
  Future<Either<Failure, Image>> call(XFile input) async {
    if (input.name.isEmpty) return Left(InvalidInputFailure());
    var data = await input.readAsBytes();
    if (data.isEmpty) return Left(InvalidInputFailure());

    return Right(
      Image(
        id: 0,
        name: input.name,
        data: data,
      ),
    );
  }
}
