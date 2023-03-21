// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/mascot_database.dart' as _i6;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i11;
import 'package:mascot/features/expressions/data/datasources/drift/models/drift_expression_mapper.dart'
    as _i3;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i12;
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot_mapper.dart'
    as _i4;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i14;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i13;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i19;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i15;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i17;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i18;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i20;
import 'package:mascot/features/settings/data/datasources/drift/models/drift_settings_mapper.dart'
    as _i5;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i7;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i9;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i8;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i10;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i16;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.DriftExpressionMapper>(
      () => _i3.DriftExpressionMapperImpl());
  gh.lazySingleton<_i4.DriftMascotMapper>(() => _i4.DriftMascotMapperImpl());
  gh.lazySingleton<_i5.DriftSettingsMapper>(
      () => _i5.DriftSettingsMapperImpl());
  gh.singleton<_i6.MascotDatabase>(_i6.MascotDatabase());
  gh.factory<_i7.SettingsDriftDataSource>(
      () => _i7.SettingsDriftDataSourceImpl(gh<_i6.MascotDatabase>()));
  gh.factory<_i8.SettingsRepository>(() => _i9.SettingsRepositoryImpl(
        gh<_i7.SettingsDriftDataSource>(),
        gh<_i5.DriftSettingsMapper>(),
      ));
  gh.factory<_i10.StreamSettings>(
      () => _i10.StreamSettings(gh<_i8.SettingsRepository>()));
  gh.factory<_i11.ExpressionsDriftDataSource>(
      () => _i11.ExpressionsDriftDataSourceImpl(gh<_i6.MascotDatabase>()));
  gh.factory<_i12.MascotsDriftDataSource>(() => _i12.MascotsDriftDataSourceImpl(
        gh<_i6.MascotDatabase>(),
        gh<_i11.ExpressionsDriftDataSource>(),
      ));
  gh.factory<_i13.MascotsRepository>(() => _i14.MascotsRepositoryImpl(
        gh<_i12.MascotsDriftDataSource>(),
        gh<_i4.DriftMascotMapper>(),
      ));
  gh.factory<_i15.SaveMascot>(() => _i15.SaveMascot(
        gh<_i13.MascotsRepository>(),
        gh<_i8.SettingsRepository>(),
      ));
  gh.factory<_i16.SettingsBloc>(
      () => _i16.SettingsBloc(gh<_i10.StreamSettings>()));
  gh.factory<_i17.StreamMascot>(
      () => _i17.StreamMascot(gh<_i13.MascotsRepository>()));
  gh.factory<_i18.CreateMascotBloc>(
      () => _i18.CreateMascotBloc(gh<_i15.SaveMascot>()));
  gh.factory<_i19.GetMascot>(
      () => _i19.GetMascot(gh<_i13.MascotsRepository>()));
  gh.factory<_i20.MascotAnimatorBloc>(
      () => _i20.MascotAnimatorBloc(gh<_i17.StreamMascot>()));
  return getIt;
}
