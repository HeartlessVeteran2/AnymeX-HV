import 'package:anymex/utils/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HvNetworkConditions {
  HvNetworkConditions._();

  /// True when on Wi-Fi or Ethernet. When the platform can't tell, returns
  /// true rather than blocking updates.
  static Future<bool> isUnmetered() async {
    try {
      final types = await Connectivity().checkConnectivity();
      if (types.isEmpty || types.contains(ConnectivityResult.none)) {
        return false;
      }
      return types.contains(ConnectivityResult.wifi) ||
          types.contains(ConnectivityResult.ethernet);
    } catch (e) {
      Logger.i('HV: connectivity check failed ($e); assuming unmetered');
      return true;
    }
  }
}
