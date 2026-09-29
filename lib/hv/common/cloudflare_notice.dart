import 'package:anymex/hv/common/core/rate_gate.dart';

final _gate = HvRateGate(const Duration(minutes: 1));

/// Whether to show the "Detected Cloudflare protection" message for [url].
///
/// The network layer showed it for every blocked request, so an update
/// check or a search across all sources hitting one protected site stacked
/// up a message per request. Now it's once a minute per site.
bool hvShouldShowCloudflareNotice(String url) =>
    _gate.allow(Uri.tryParse(url)?.host ?? url);
