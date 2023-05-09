import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_shim/idb_client.dart';
import 'package:injectable/injectable.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../clean_architecture/entity.dart';

@lazySingleton
class IndexedDbFactory {
  IdbFactory? _factory;
  IdbFactory? get factory => _factory ??= getIdbFactory();
}

@lazySingleton
class IndexDbSettings {
  final int dbVersion = 1;
}

abstract class IndexedDbDataSource<T extends Entity> {
  Single<T> getObject(Id id);
  Single<Option<T>> getOptionObject(Id id);
  Single<List<T>> getObjects(List<Id> ids);
  Single<int> putObject(T object);
  Single<void> deleteObject(Id id);
  Stream<T> streamObject(Id id);
  Stream<List<T>> streamObjects(List<Id> ids);

  String get storeName;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T object);
}

class Pair<T1, T2> extends Equatable {
  final T1 first;
  final T2 second;

  const Pair(this.first, this.second);

  @override
  List<Object?> get props => [first, second];
}

abstract class IndexedDbDataSourceImpl<T extends Entity>
    implements IndexedDbDataSource<T>, Disposable {
  final IndexedDbFactory indexedDbFactory;
  final IndexDbSettings _settings;
  final StreamController<Map<Id, T>> _streamController =
      StreamController.broadcast();
  final Map<Id, T> _currentState = {};

  IndexedDbDataSourceImpl(this.indexedDbFactory, this._settings);

  @override
  String get storeName => T.toString();

  @override
  Single<T> getObject(Id id) => getOptionObject(id).map(
      (option) => option.getOrElse(() => throw ObjectNotFoundException(id, T)));

  @override
  Single<Option<T>> getOptionObject(Id id) => Single.value(id)
      .zipWith(
        _openObjectStore(mode: idbModeReadOnly),
        (id, store) => store.getObject(id).asSingle(),
      )
      .singleOrError()
      .map<Option<T>>(_createOption);

  @override
  Single<List<T>> getObjects(List<Id> ids) => Stream.fromIterable(ids)
      .zipWith(
        _openObjectStore(mode: idbModeReadOnly),
        (id, store) => store.getObject(id).asSingle(),
      )
      .switchMap((value) => value)
      .onErrorResume((e, s) => Single.error(LocalDataSourceException(e, s)))
      .whereNotNull()
      .map(_fromJson)
      .toList()
      .asSingle();

  @override
  Single<Id> putObject(T object) => Single.value(object)
      .map<Map<String, dynamic>>(toJson)
      .zipWith(_openObjectStore(mode: idbModeReadWrite), _saveObject)
      .switchMap((value) => value)
      .onErrorResume((e, s) => Single.error(LocalDataSourceException(e, s)))
      .singleOrError();

  @override
  Single<void> deleteObject(Id id) => _openObjectStore(mode: idbModeReadWrite)
      .switchMapSingle((store) => store.delete(id).asSingle())
      .doOnDone(() {
        _currentState.remove(id);
        _streamController.add(_currentState);
      })
      .onErrorResume((e, s) => Single.error(LocalDataSourceException(e, s)))
      .singleOrError();

  @override
  Stream<T> streamObject(Id id) => getObject(id).concatWith([
        _streamController.stream
            .map((data) => data[id])
            .whereNotNull()
            .cast<Object>()
            .map(_fromJson)
            .cast<T>()
      ]);

  @override
  Stream<List<T>> streamObjects(List<Id> ids) => getObjects(ids).concatWith([
        _streamController.stream.map((data) =>
            data.values.where((item) => ids.contains(item.id)).toList())
      ]);

  @override
  void onDispose() {
    _streamController.close();
  }

  Single<Database> _openDb() {
    var factory = indexedDbFactory.factory;
    if (factory == null) {
      throw Exception('IndexedDbFactory could not be initialized');
    }

    return factory.open(
      T.toString(),
      version: _settings.dbVersion,
      onUpgradeNeeded: (VersionChangeEvent event) {
        final db = event.database;
        db.createObjectStore(storeName, autoIncrement: true);
      },
    ).asSingle();
  }

  Single<Transaction> _openTransaction({String mode = idbModeReadWrite}) =>
      _openDb().map((db) => db.transaction(storeName, mode));

  Single<ObjectStore> _openObjectStore({String mode = idbModeReadWrite}) =>
      _openTransaction(mode: mode)
          .map((transaction) => transaction.objectStore(storeName));

  Option<T> _createOption(Object? value) {
    if (value != null) {
      var obj = _fromJson(value);
      _currentState[obj.id] = obj;
      _streamController.add(_currentState);
      return some(obj);
    } else {
      return none();
    }
  }

  T _fromJson(Object value) => fromJson(_toStringKeyMap(value));

  Map<String, dynamic> _toStringKeyMap(Object? object) =>
      (object as Map<dynamic, dynamic>)
          .map((key, value) => MapEntry(key as String, value));

  Single<Id> _saveObject(Map<String, dynamic> json, ObjectStore store) {
    var jsonSingle = json['id'] == 0
        ? store.add('').asSingle().map((id) => json..['id'] = id)
        : Single.value(json);

    return jsonSingle.switchMapSingle(
      (json) => store
          .put(
            json,
            json['id'] as Id,
          )
          .asSingle()
          .map((id) => id as Id),
    );
  }
}
