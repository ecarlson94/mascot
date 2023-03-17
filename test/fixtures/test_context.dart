import 'package:mascot/core/data/drift/mascot_database.dart';

import 'mocks.dart';
import 'test_data.dart';

class TestContext {
  final Mocks mocks = Mocks();
  final TestData data = TestData();

  MascotDatabase? _database;
  MascotDatabase get database => _database ??= MascotDatabase.memory();
}
