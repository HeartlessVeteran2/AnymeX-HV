/// The extension runtime bridge the app uses: our fork of
/// RyanYuuki/AnymeXExtensionRuntimeBridge. `pubspec.yaml` builds against it,
/// and the plugin manager reads its releases (the Android runtime host APK /
/// desktop jar), which a workflow in the fork copies from upstream.
const hvBridgeRepo = 'HeartlessVeteran2/AnymeXExtensionRuntimeBridge-HV';
