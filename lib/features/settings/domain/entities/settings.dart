import '../../../../core/clean_architecture/entity.dart';

class Settings extends EquatableEntity {
  final int favoriteMascotId;

  const Settings({super.id = 1, this.favoriteMascotId = 0});

  @override
  List<Object?> get props => [id, favoriteMascotId];

  Settings copyWith({
    int? id,
    int? favoriteMascotId,
  }) =>
      Settings(
        id: id ?? this.id,
        favoriteMascotId: favoriteMascotId ?? this.favoriteMascotId,
      );

  factory Settings.empty() => const Settings(id: 1);

  @override
  Settings copyWithId(Id id) => Settings(
        id: id,
        favoriteMascotId: favoriteMascotId,
      );
}