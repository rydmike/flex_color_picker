// These functions are not supported on the Web platform, so we make dummy
// functions for them on the unsupported Web platform, where they are not
// even needed, thus it does not matter that they are not supported.
//
// These dummy functions get imported instead of the real ones on the WEB
// platform. On desktops iOS and Android the real functions get imported,
//
// The functions listed here are not supported nor needed on Web, so calls to
// them will do nothing when an app is built for Web. We do need to include
// stubs for them though, so that the code is and reads the same regardless of
// what platform we build for.

/// Document directory for WEB apps.
///
/// Flutter Web apps that store data typically use Web IndexDB instead and
/// don't need a document path to store data.
///
/// This dummy version of [getAppDataDir] returns an empty string as the path.
Future<String> getAppDataDir() async {
  return '';
}
