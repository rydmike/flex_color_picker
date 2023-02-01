/// Conditional imports based on if 'dart.io' is supported.
///
/// We export lib 'dart_io_not_supported.dart', but if dart.io is supported
/// then we export 'dart_io_supported.dart' instead.
library;

export 'dart_io_not_supported.dart'
    if (dart.library.io) 'dart_io_supported.dart';
