import 'package:reactive_forms/reactive_forms.dart';

extension FormGroupExtensions on FormGroup {
  T controlValue<T>(String controlName) {
    return controls.containsKey(controlName)
        ? control(controlName).value as T
        : throw ArgumentError('The control $controlName does not exist');
  }
}
