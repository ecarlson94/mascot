part of 'expression_bloc.dart';

abstract class ExpressionEvent extends Equatable {
  const ExpressionEvent();

  @override
  List<Object?> get props => [];
}

class SaveExpressionEvent extends ExpressionEvent {
  final String name;
  final String description;
  final XFile image;

  const SaveExpressionEvent({
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  List<Object?> get props => [image];
}

class SetExpressionEvent extends ExpressionEvent {
  final Expression expression;

  const SetExpressionEvent({required this.expression});

  @override
  List<Object?> get props => [expression];
}

class GetExpressionEvent extends ExpressionEvent {
  final Id id;

  const GetExpressionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
