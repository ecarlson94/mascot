part of 'expression_bloc.dart';

abstract class ExpressionState extends Equatable {
  const ExpressionState();

  @override
  List<Object> get props => [];
}

class ExpressionInitial extends ExpressionState {}

class ExpressionLoaded extends ExpressionState {
  final Expression expression;

  const ExpressionLoaded(this.expression);

  @override
  List<Object> get props => [expression];
}

class SavingExpression extends ExpressionState {}

class SaveExpressionError extends ExpressionState implements ErrorState {
  @override
  final int code;

  const SaveExpressionError(this.code);

  @override
  List<Object> get props => [code];
}

class GettingExpression extends ExpressionState {}

class GetExpressionError extends ExpressionState implements ErrorState {
  @override
  final int code;

  const GetExpressionError(this.code);

  @override
  List<Object> get props => [code];
}
