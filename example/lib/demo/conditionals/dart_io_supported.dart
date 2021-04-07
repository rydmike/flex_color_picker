import 'dart:io' show Directory;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart' as path_provider;

// This is a collection of unsupported functions in Flutter WEB that are all
// behind the dart.io package. They will only be imported on platforms
// that support compiling them, basically all except WEB platform.

/// The [getAppDataDir] is a custom made folder/directory getter for different
/// platforms that uses package path_provider.dart.
Future<String> getAppDataDir() async {
  // "Web" should not happen in this import branch, but let's check for it
  // anyway, on actual web build this return will be via the
  // 'dart_io_not_supported.dart' import file.
  if (kIsWeb) {
    return ''; // WEB return empty string
  } else {
    // Other platforms, use path provider and their app support folder.
    final Directory dir = await path_provider.getApplicationSupportDirectory();
    return dir.path;
  }
}
