// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mascot/core/data/drift/drift_database.dart' as _i3;
import 'package:mascot/features/expressions/data/datasources/drift/expressions_drift_data_source.dart'
    as _i4;
import 'package:mascot/features/expressions/data/datasources/drift/models/map_expression_to_drift_expression.dart'
    as _i5;
import 'package:mascot/features/mascot/data/datasources/drift/mascots_drift_data_source.dart'
    as _i8;
import 'package:mascot/features/mascot/data/datasources/drift/models/map_mascot_to_drift_mascot.dart'
    as _i6;
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart'
    as _i10;
import 'package:mascot/features/mascot/domain/repositories/mascots_repository.dart'
    as _i9;
import 'package:mascot/features/mascot/domain/usecases/get_mascot.dart' as _i16;
import 'package:mascot/features/mascot/domain/usecases/save_mascot.dart'
    as _i18;
import 'package:mascot/features/mascot/domain/usecases/stream_mascot.dart'
    as _i14;
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart'
    as _i20;
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator_bloc.dart'
    as _i17;
import 'package:mascot/features/settings/data/datasources/drift/models/map_settings_to_drift_settings.dart'
    as _i7;
import 'package:mascot/features/settings/data/datasources/drift/settings_drift_data_source.dart'
    as _i11;
import 'package:mascot/features/settings/data/repositories/settings_repository_impl.dart'
    as _i13;
import 'package:mascot/features/settings/domain/repositories/settings_repository.dart'
    as _i12;
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart'
    as _i15;
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart'
    as _i19;

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
  gh.singleton<_i3.DriftyDatabase>(_i3.DriftyDatabase());
  gh.factory<_i4.ExpressionsDriftDataSource>(
      () => _i4.ExpressionsDriftDataSourceImpl(gh<_i3.DriftyDatabase>()));
  gh.factory<_i5.MapExpressionToDriftExpression>(
      () => _i5.MapExpressionToDriftExpression());
  gh.factory<_i6.MapMascotToDriftMascot>(() =>
      _i6.MapMascotToDriftMascot(gh<_i5.MapExpressionToDriftExpression>()));
  gh.factory<_i7.MapSettingsToDriftSettings>(
      () => _i7.MapSettingsToDriftSettings());
  gh.factory<_i8.MascotsDriftDataSource>(() => _i8.MascotsDriftDataSourceImpl(
        gh<_i3.DriftyDatabase>(),
        gh<_i4.ExpressionsDriftDataSource>(),
      ));
  gh.factory<_i9.MascotsRepository>(() => _i10.MascotsRepositoryImpl(
        gh<_i8.MascotsDriftDataSource>(),
        gh<_i6.MapMascotToDriftMascot>(),
      ));
  gh.factory<_i11.SettingsDriftDataSource>(
      () => _i11.SettingsDriftDataSourceImpl(gh<_i3.DriftyDatabase>()));
  gh.factory<_i12.SettingsRepository>(() => _i13.SettingsRepositoryImpl(
        gh<_i11.SettingsDriftDataSource>(),
        gh<_i7.MapSettingsToDriftSettings>(),
      ));
  gh.factory<_i14.StreamMascot>(
      () => _i14.StreamMascot(gh<_i9.MascotsRepository>()));
  gh.factory<_i15.StreamSettings>(
      () => _i15.StreamSettings(gh<_i12.SettingsRepository>()));
  gh.factory<_i16.GetMascot>(() => _i16.GetMascot(gh<_i9.MascotsRepository>()));
  gh.factory<_i17.MascotAnimatorBloc>(
      () => _i17.MascotAnimatorBloc(gh<_i14.StreamMascot>()));
  gh.factory<_i18.SaveMascot>(() => _i18.SaveMascot(
        gh<_i9.MascotsRepository>(),
        gh<_i12.SettingsRepository>(),
      ));
  gh.factory<_i19.SettingsBloc>(
      () => _i19.SettingsBloc(gh<_i15.StreamSettings>()));
  gh.factory<_i20.CreateMascotBloc>(() => _i20.CreateMascotBloc(
        gh<_i18.SaveMascot>(),
        gh<_i16.GetMascot>(),
      ));
  return getIt;
}
