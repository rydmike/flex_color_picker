import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../utils/store.dart';

/// Provider "Pods" observer used to store the state of selected Riverpod
/// providers and debugPrint changes to them in debug mode.
class PodsObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase<dynamic, dynamic> provider, Object? newValue) {
    // If it is one of the StateProviders that we are interested in,
    // it will be of type StateController.
    if (newValue is StateController) {
      // If it is one that we have a named key for, we will store it in Hive.
      if (Keys.defaults.containsKey(provider.name)) {
        // Log the new value, just a debugPrint in DebugMode only.
        if (kDebugMode) {
          debugPrint('Pod: ${provider.name ?? provider.runtimeType} '
              'value: ${newValue.state}');
        }
        // Store the new value in our Hive box, that is already open.
        final Box<dynamic> box = Hive.box<dynamic>(Keys.box);
        box.put(provider.name, newValue.state);
      }
    }
  }
}
