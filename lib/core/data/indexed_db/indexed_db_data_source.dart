import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:idb_shim/idb_browser.dart';
import 'package:idb_shim/idb_client.dart';
import 'package:injectable/injectable.dart';

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
  Future<T> getObject(Id id);
  Future<List<T>> getObjects(Iterable<Id> ids);
  Future<int> putObject(T object);
  Future<void> deleteObject(Id id);
  Stream<T> streamObject(Id id);
  Stream<List<T>> streamObjects(Iterable<Id> ids);

  String get storeName;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T object);
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
  Future<T> getObject(Id id) async {
    final db = await openDb();
    final transaction = db.transaction(storeName, idbModeReadOnly);
    final store = transaction.objectStore(storeName);
    final value = await store.getObject(id);

    if (value != null) {
      var obj = fromJson(value as Map<String, dynamic>);
      _currentState[obj.id] = obj;
      return obj;
    } else {
      throw Exception('Object not found');
    }
  }

  @override
  Future<List<T>> getObjects(Iterable<Id> ids) async {
    final db = await openDb();
    final transaction = db.transaction(storeName, idbModeReadOnly);
    final store = transaction.objectStore(storeName);
    final values = await store.getAll(ids);

    if (values.isNotEmpty) {
      var objects = values.map((value) {
        var obj = fromJson(value as Map<String, dynamic>);
        _currentState[obj.id] = obj;
        return obj;
      }).toList();
      return objects;
    } else {
      throw Exception('Objects not found');
    }
  }

  @override
  Future<int> putObject(T object) async {
    final db = await openDb();
    final transaction = db.transaction(storeName, idbModeReadWrite);
    final store = transaction.objectStore(storeName);
    final id = await store.put(toJson(object));

    if (id is int) {
      _currentState[object.id] = object;
      _streamController.add(_currentState);
      return id;
    } else {
      throw Exception('Object could not be saved');
    }
  }

  @override
  Future<void> deleteObject(Id id) async {
    final db = await openDb();
    final transaction = db.transaction(storeName, idbModeReadWrite);
    final store = transaction.objectStore(storeName);
    await store.delete(id);
    _currentState.remove(id);
    _streamController.add(_currentState);
  }

  @override
  Stream<T> streamObject(Id id) {
    return _streamController.stream
        .map((data) => data[id])
        .where((item) => item != null)
        .cast<T>();
  }

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

  Future<Database> openDb() async {
    var factory = indexedDbFactory.factory;
    if (factory == null) {
      throw Exception('IndexedDbFactory is could not be initialized');
    }

    return factory.open(
      T.toString(),
      version: _settings.dbVersion,
      onUpgradeNeeded: (VersionChangeEvent event) {
        final db = event.database;
        db.createObjectStore(storeName, autoIncrement: true);
      },
    );
  }
}
