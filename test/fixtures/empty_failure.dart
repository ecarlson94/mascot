import 'package:mascot/core/error/failure.dart';

class EmptyFailure extends Failure {
  const EmptyFailure(super.exception);

  @override
  List<Object?> get props => [];
}
