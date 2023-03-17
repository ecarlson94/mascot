// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $MascotsTable extends Mascots with TableInfo<$MascotsTable, Mascot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MascotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? 'mascots';
  @override
  String get actualTableName => 'mascots';
  @override
  VerificationContext validateIntegrity(Insertable<Mascot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mascot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mascot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $MascotsTable createAlias(String alias) {
    return $MascotsTable(attachedDatabase, alias);
  }
}

class Mascot extends DataClass implements Insertable<Mascot> {
  final int id;
  final String name;
  const Mascot({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  MascotsCompanion toCompanion(bool nullToAbsent) {
    return MascotsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Mascot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mascot(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Mascot copyWith({int? id, String? name}) => Mascot(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Mascot(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mascot && other.id == this.id && other.name == this.name);
}

class MascotsCompanion extends UpdateCompanion<Mascot> {
  final Value<int> id;
  final Value<String> name;
  const MascotsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MascotsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Mascot> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MascotsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return MascotsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MascotsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $MascotExpressionMapsTable extends MascotExpressionMaps
    with TableInfo<$MascotExpressionMapsTable, MascotExpressionMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MascotExpressionMapsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mascotIdMeta =
      const VerificationMeta('mascotId');
  @override
  late final GeneratedColumn<int> mascotId = GeneratedColumn<int>(
      'mascot_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _expressionIdMeta =
      const VerificationMeta('expressionId');
  @override
  late final GeneratedColumn<int> expressionId = GeneratedColumn<int>(
      'expression_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [mascotId, expressionId];
  @override
  String get aliasedName => _alias ?? 'mascot_expression_maps';
  @override
  String get actualTableName => 'mascot_expression_maps';
  @override
  VerificationContext validateIntegrity(
      Insertable<MascotExpressionMap> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mascot_id')) {
      context.handle(_mascotIdMeta,
          mascotId.isAcceptableOrUnknown(data['mascot_id']!, _mascotIdMeta));
    } else if (isInserting) {
      context.missing(_mascotIdMeta);
    }
    if (data.containsKey('expression_id')) {
      context.handle(
          _expressionIdMeta,
          expressionId.isAcceptableOrUnknown(
              data['expression_id']!, _expressionIdMeta));
    } else if (isInserting) {
      context.missing(_expressionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {mascotId, expressionId},
      ];
  @override
  MascotExpressionMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MascotExpressionMap(
      mascotId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mascot_id'])!,
      expressionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}expression_id'])!,
    );
  }

  @override
  $MascotExpressionMapsTable createAlias(String alias) {
    return $MascotExpressionMapsTable(attachedDatabase, alias);
  }
}

class MascotExpressionMap extends DataClass
    implements Insertable<MascotExpressionMap> {
  final int mascotId;
  final int expressionId;
  const MascotExpressionMap(
      {required this.mascotId, required this.expressionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mascot_id'] = Variable<int>(mascotId);
    map['expression_id'] = Variable<int>(expressionId);
    return map;
  }

  MascotExpressionMapsCompanion toCompanion(bool nullToAbsent) {
    return MascotExpressionMapsCompanion(
      mascotId: Value(mascotId),
      expressionId: Value(expressionId),
    );
  }

  factory MascotExpressionMap.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MascotExpressionMap(
      mascotId: serializer.fromJson<int>(json['mascotId']),
      expressionId: serializer.fromJson<int>(json['expressionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mascotId': serializer.toJson<int>(mascotId),
      'expressionId': serializer.toJson<int>(expressionId),
    };
  }

  MascotExpressionMap copyWith({int? mascotId, int? expressionId}) =>
      MascotExpressionMap(
        mascotId: mascotId ?? this.mascotId,
        expressionId: expressionId ?? this.expressionId,
      );
  @override
  String toString() {
    return (StringBuffer('MascotExpressionMap(')
          ..write('mascotId: $mascotId, ')
          ..write('expressionId: $expressionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mascotId, expressionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MascotExpressionMap &&
          other.mascotId == this.mascotId &&
          other.expressionId == this.expressionId);
}

class MascotExpressionMapsCompanion
    extends UpdateCompanion<MascotExpressionMap> {
  final Value<int> mascotId;
  final Value<int> expressionId;
  const MascotExpressionMapsCompanion({
    this.mascotId = const Value.absent(),
    this.expressionId = const Value.absent(),
  });
  MascotExpressionMapsCompanion.insert({
    required int mascotId,
    required int expressionId,
  })  : mascotId = Value(mascotId),
        expressionId = Value(expressionId);
  static Insertable<MascotExpressionMap> custom({
    Expression<int>? mascotId,
    Expression<int>? expressionId,
  }) {
    return RawValuesInsertable({
      if (mascotId != null) 'mascot_id': mascotId,
      if (expressionId != null) 'expression_id': expressionId,
    });
  }

  MascotExpressionMapsCompanion copyWith(
      {Value<int>? mascotId, Value<int>? expressionId}) {
    return MascotExpressionMapsCompanion(
      mascotId: mascotId ?? this.mascotId,
      expressionId: expressionId ?? this.expressionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mascotId.present) {
      map['mascot_id'] = Variable<int>(mascotId.value);
    }
    if (expressionId.present) {
      map['expression_id'] = Variable<int>(expressionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MascotExpressionMapsCompanion(')
          ..write('mascotId: $mascotId, ')
          ..write('expressionId: $expressionId')
          ..write(')'))
        .toString();
  }
}

class $ExpressionsTable extends Expressions
    with TableInfo<$ExpressionsTable, DriftExpression> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpressionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, description, image];
  @override
  String get aliasedName => _alias ?? 'expressions';
  @override
  String get actualTableName => 'expressions';
  @override
  VerificationContext validateIntegrity(Insertable<DriftExpression> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftExpression map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftExpression(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image'])!,
    );
  }

  @override
  $ExpressionsTable createAlias(String alias) {
    return $ExpressionsTable(attachedDatabase, alias);
  }
}

class ExpressionsCompanion extends UpdateCompanion<DriftExpression> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<Uint8List> image;
  const ExpressionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
  });
  ExpressionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required Uint8List image,
  })  : name = Value(name),
        description = Value(description),
        image = Value(image);
  static Insertable<DriftExpression> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<Uint8List>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
    });
  }

  ExpressionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<Uint8List>? image}) {
    return ExpressionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpressionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, DriftSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _favoriteMascotIdMeta =
      const VerificationMeta('favoriteMascotId');
  @override
  late final GeneratedColumn<int> favoriteMascotId = GeneratedColumn<int>(
      'favorite_mascot_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, favoriteMascotId];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<DriftSettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('favorite_mascot_id')) {
      context.handle(
          _favoriteMascotIdMeta,
          favoriteMascotId.isAcceptableOrUnknown(
              data['favorite_mascot_id']!, _favoriteMascotIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftSettings(
      favoriteMascotId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}favorite_mascot_id']),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingsCompanion extends UpdateCompanion<DriftSettings> {
  final Value<int> id;
  final Value<int?> favoriteMascotId;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.favoriteMascotId = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.favoriteMascotId = const Value.absent(),
  });
  static Insertable<DriftSettings> custom({
    Expression<int>? id,
    Expression<int>? favoriteMascotId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (favoriteMascotId != null) 'favorite_mascot_id': favoriteMascotId,
    });
  }

  SettingsCompanion copyWith({Value<int>? id, Value<int?>? favoriteMascotId}) {
    return SettingsCompanion(
      id: id ?? this.id,
      favoriteMascotId: favoriteMascotId ?? this.favoriteMascotId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (favoriteMascotId.present) {
      map['favorite_mascot_id'] = Variable<int>(favoriteMascotId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('favoriteMascotId: $favoriteMascotId')
          ..write(')'))
        .toString();
  }
}

class MascotExpression extends DataClass {
  final int mascotId;
  final int expressionId;
  final String name;
  final String description;
  final Uint8List image;
  const MascotExpression(
      {required this.mascotId,
      required this.expressionId,
      required this.name,
      required this.description,
      required this.image});
  factory MascotExpression.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MascotExpression(
      mascotId: serializer.fromJson<int>(json['mascotId']),
      expressionId: serializer.fromJson<int>(json['expressionId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      image: serializer.fromJson<Uint8List>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mascotId': serializer.toJson<int>(mascotId),
      'expressionId': serializer.toJson<int>(expressionId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'image': serializer.toJson<Uint8List>(image),
    };
  }

  MascotExpression copyWith(
          {int? mascotId,
          int? expressionId,
          String? name,
          String? description,
          Uint8List? image}) =>
      MascotExpression(
        mascotId: mascotId ?? this.mascotId,
        expressionId: expressionId ?? this.expressionId,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('MascotExpression(')
          ..write('mascotId: $mascotId, ')
          ..write('expressionId: $expressionId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mascotId, expressionId, name, description,
      $driftBlobEquality.hash(image));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MascotExpression &&
          other.mascotId == this.mascotId &&
          other.expressionId == this.expressionId &&
          other.name == this.name &&
          other.description == this.description &&
          $driftBlobEquality.equals(other.image, this.image));
}

class $MascotExpressionsView
    extends ViewInfo<$MascotExpressionsView, MascotExpression>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$DriftyDatabase attachedDatabase;
  $MascotExpressionsView(this.attachedDatabase, [this._alias]);
  $MascotExpressionMapsTable get mascotExpressionMaps =>
      attachedDatabase.mascotExpressionMaps.createAlias('t0');
  $ExpressionsTable get expressions =>
      attachedDatabase.expressions.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns =>
      [mascotId, expressionId, name, description, image];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'mascot_expressions';
  @override
  String? get createViewStmt => null;
  @override
  $MascotExpressionsView get asDslTable => this;
  @override
  MascotExpression map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MascotExpression(
      mascotId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mascot_id'])!,
      expressionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}expression_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      image: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}image'])!,
    );
  }

  late final GeneratedColumn<int> mascotId = GeneratedColumn<int>(
      'mascot_id', aliasedName, false,
      generatedAs: GeneratedAs(mascotExpressionMaps.mascotId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<int> expressionId = GeneratedColumn<int>(
      'expression_id', aliasedName, false,
      generatedAs: GeneratedAs(mascotExpressionMaps.expressionId, false),
      type: DriftSqlType.int);
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      generatedAs: GeneratedAs(expressions.name, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      generatedAs: GeneratedAs(expressions.description, false),
      type: DriftSqlType.string);
  late final GeneratedColumn<Uint8List> image = GeneratedColumn<Uint8List>(
      'image', aliasedName, false,
      generatedAs: GeneratedAs(expressions.image, false),
      type: DriftSqlType.blob);
  @override
  $MascotExpressionsView createAlias(String alias) {
    return $MascotExpressionsView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(mascotExpressionMaps)..addColumns($columns))
          .join([
        innerJoin(expressions,
            expressions.id.equalsExp(mascotExpressionMaps.expressionId))
      ]);
  @override
  Set<String> get readTables => const {'mascot_expression_maps', 'expressions'};
}

abstract class _$DriftyDatabase extends GeneratedDatabase {
  _$DriftyDatabase(QueryExecutor e) : super(e);
  late final $MascotsTable mascots = $MascotsTable(this);
  late final $MascotExpressionMapsTable mascotExpressionMaps =
      $MascotExpressionMapsTable(this);
  late final $ExpressionsTable expressions = $ExpressionsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $MascotExpressionsView mascotExpressions =
      $MascotExpressionsView(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [mascots, mascotExpressionMaps, expressions, settings, mascotExpressions];
}
