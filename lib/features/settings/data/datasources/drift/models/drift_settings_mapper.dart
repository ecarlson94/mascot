import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

import '../../../../domain/entities/settings.dart';
import 'drift_settings.dart' show DriftSettings;

part 'drift_settings_mapper.mapper.g.dart';

@Mapper(useInjection: true)
abstract class DriftSettingsMapper {
  DriftSettings fromSettings(Settings settings);
  Settings toSettings(DriftSettings driftSettings);
}
