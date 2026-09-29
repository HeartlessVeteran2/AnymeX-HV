import 'package:anymex/hv/extensions/core/serial_queue.dart';
import 'package:anymex_extension_runtime_bridge/Services/Aniyomi/Models/Source.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';

final _hostQueue = HvSerialQueue();

/// Runs an install, update or removal of [source].
///
/// APK extensions (Mihon/Aniyomi) are installed through Android's package
/// installer by the install_plugin package, which keeps a single pending
/// reply. Two installs at once ("Update all", or two quick taps) overwrote
/// it: the first never finished, and the second reply to the same call made
/// Flutter throw "Reply already submitted" on Android's main thread, which
/// crashed the app. Those, and the other extensions the runtime host loads
/// (CloudStream, Kotatsu), now run one at a time; Mangayomi, Sora and
/// Legado extensions are plain downloads and still run in parallel.
///
/// Our bridge fork now also runs APK installs and removals one at a time
/// itself (AnymeXExtensionRuntimeBridge-HV#5). This queue stays, because it
/// covers CloudStream and Kotatsu too.
Future<T> hvRunExtensionAction<T>(Source source, Future<T> Function() action) =>
    source is ASource || source is CloudStreamSource || source is KotatsuSource
        ? _hostQueue.run(action)
        : action();
