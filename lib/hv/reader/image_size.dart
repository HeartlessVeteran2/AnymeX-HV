import 'package:flutter/widgets.dart';

/// Reports [image]'s size in pixels to [onSize] once it has decoded, then
/// stops listening.
///
/// The reader added a listener to a local page's image stream on every build
/// and never removed it. A stream that still has a listener is never
/// released, so every downloaded page shown in the continuous reader stayed
/// decoded in memory until the app closed, even after the image cache let
/// it go. This listener removes itself after the first image or error.
void hvReportImageSize(
    ImageProvider image, void Function(double width, double height)? onSize) {
  if (onSize == null) return;
  final stream = image.resolve(ImageConfiguration.empty);
  late final ImageStreamListener listener;
  listener = ImageStreamListener(
    (info, _) {
      stream.removeListener(listener);
      final width = info.image.width.toDouble();
      final height = info.image.height.toDouble();
      info.dispose();
      onSize(width, height);
    },
    onError: (error, stack) {
      stream.removeListener(listener);
      // Rethrown as is, so the error is reported like before: an error
      // listener that returns normally marks the error as handled.
      Error.throwWithStackTrace(error, stack ?? StackTrace.current);
    },
  );
  stream.addListener(listener);
}
