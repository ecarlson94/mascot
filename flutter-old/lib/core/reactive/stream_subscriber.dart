import 'dart:async';

import 'package:get_it/get_it.dart';

abstract class StreamSubcriber extends Disposable with SubscriptionDisposer {}

mixin SubscriptionDisposer {
  final List<StreamSubscription> subscriptions = List.empty(growable: true);

  FutureOr onDispose() async {
    for (final subscription in subscriptions) {
      await subscription.cancel();
    }
  }
}
