import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $init(getIt);
