import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_shim/idb_client.dart';
import 'package:injectable/injectable.dart';
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
  Future<int> putObject(T object);
  Future<void> deleteObject(Id id);
  Stream<T> streamObject(Id id);
  Stream<List<T>> streamObjects(Iterable<Id> ids);

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
      (option) => option.getOrElse(() => throw Exception('Object not found')));

  @override
  Single<Option<T>> getOptionObject(Id id) =>
      _openObjectStore(mode: idbModeReadOnly)
          .zipWith(
              Single.value(id), (store, id) => store.getObject(id).asSingle())
          .singleOrError()
          .map<Option<T>>(_createOption);

  @override
  Single<List<T>> getObjects(List<Id> ids) => Stream.fromIterable(ids)
      .zipWith(_openObjectStore(mode: idbModeReadOnly),
          (id, store) => store.getObject(id).asSingle())
      .switchMap((value) => value)
      .whereNotNull()
      .map(_fromJson)
      .toList()
      .asSingle();

  @override
  Single<Id> putObjectSingle(T object) {
    var test = Single.value(object).map<Map<String, dynamic>>(toJson).zipWith(
            _openObjectStore(mode: idbModeReadWrite),
            (json, store) => Pair(json, json['id'] == 0 ? store.add(json): store.put(json, json['id'] as int)),
          ).singleOrError().switchMap((value) {
            return value.second.asSingle().map((event) {
              value.first['id'] = event;
              return value.first;
            });
          });

    return test
  }

  @override
  Future<Id> putObject(T object) async {
    final db = await _openDb();
    final transaction = db.transaction(storeName, idbModeReadWrite);
    final store = transaction.objectStore(storeName);

    final jsonObject = toJson(object);
    if (jsonObject['id'] == 0) {
      var id = await store.add('');
      jsonObject['id'] = id;
    }

    final id = await store.put(jsonObject, jsonObject['id'] as int);

    if (id is Id) {
      _currentState[id] = fromJson(jsonObject);
      _streamController.add(_currentState);
      return id;
    } else {
      throw Exception('Object could not be saved');
    }
  }

  @override
  Future<void> deleteObject(Id id) async {
    final db = await _openDb();
    final transaction = db.transaction(storeName, idbModeReadWrite);
    final store = transaction.objectStore(storeName);
    await store.delete(id);
    _currentState.remove(id);
    _streamController.add(_currentState);
  }

  @override
  Stream<T> streamObject(Id id) {
    return getObject(id).asSingle().concatWith([
      _streamController.stream
          .map((data) => data[id])
          .whereNotNull()
          .cast<Object>()
          .map(_fromJson)
          .cast<T>()
    ]);
  }

  // TODO: find a way to remove the stream controller
  @override
  Stream<List<T>> streamObjects(Iterable<Id> ids) {
    return _streamController.stream.map(
      (data) =>
          data.values.where((item) => ids.contains(item.id)).cast<T>().toList(),
    );
  }

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
      return some(obj);
    } else {
      return none();
    }
  }

  T _fromJson(Object value) => fromJson(_toStringKeyMap(value));

  Map<String, dynamic> _toStringKeyMap(Object? object) =>
      (object as Map<dynamic, dynamic>)
          .map((key, value) => MapEntry(key as String, value));
}
