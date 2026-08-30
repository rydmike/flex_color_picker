// These functions are not supported on the web platform, so we make dummy
// functions for them on the unsupported web platform, where they are not
// even needed, thus it does not matter that they are not supported.
//
// These dummy functions get imported instead of the real ones on the web
// platform. On desktop, iOS and Android the real functions get imported.
//
// The functions listed here are not supported nor needed on web, so calls to
// them will do nothing when an app is built for web. We do need to include
// stubs for them though, so that the code is and reads the same regardless of
// what platform we build for.

/// Document directory for web apps.
///
/// Flutter web apps that store data typically use IndexedDB instead and
/// don't need a document path to store data.
///
/// This dummy version of [getAppDataDir] returns an empty string as the path.
Future<String> getAppDataDir() async {
  return '';
}
