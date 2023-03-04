import '../../../../core/clean_architecture/entity.dart';
import '../../../images/domain/entities/image.dart';

class Mascot extends EquatableEntity {
  final String name;
  final Image neutralFace;
  final Image? talkingFace;
  final Image? blinkingFace;
  final Image? talkingBlinkingFace;

  const Mascot({
    super.id,
    required this.name,
    required this.neutralFace,
    this.blinkingFace,
    this.talkingFace,
    this.talkingBlinkingFace,
  });
}
