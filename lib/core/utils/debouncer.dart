import 'dart:async';

class Debouncer {
  final Duration duration;

  Debouncer({this.duration = const Duration(milliseconds: 300)});

  Timer? _timer;

  void run(void Function() action) {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}
