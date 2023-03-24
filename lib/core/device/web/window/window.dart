import 'package:injectable/injectable.dart';
import 'package:universal_html/html.dart';

@module
abstract class WindowModule {
  @lazySingleton
  Window getWindow() => window;
}
