part of 'mascot_bloc.dart';

abstract class MascotState extends Equatable {
  const MascotState();
  
  @override
  List<Object> get props => [];
}

class MascotInitial extends MascotState {}
