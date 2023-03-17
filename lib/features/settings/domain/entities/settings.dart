import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final int? favoriteMascotId;

  const Settings({required this.favoriteMascotId});

  @override
  List<Object?> get props => [favoriteMascotId];

  Settings copyWith({
    int? favoriteMascotId,
  }) =>
      Settings(
        favoriteMascotId: favoriteMascotId ?? this.favoriteMascotId,
      );

  static const Settings empty = Settings(favoriteMascotId: null);
}
