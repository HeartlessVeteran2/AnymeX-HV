import 'package:anymex/hv/extensions/extension_errors.dart';
import 'package:anymex/widgets/non_widgets/snackbar.dart';

export 'package:anymex/hv/extensions/extension_errors.dart'
    show HvExtensionAction;

/// Shows why an extension install, update or removal failed.
void hvShowExtensionError(
    Object error, String? sourceName, HvExtensionAction action) {
  snackBar(
    hvExtensionErrorMessage(error, sourceName: sourceName, action: action),
    duration: 4000,
    maxLines: 3,
  );
}

/// After "Update all": names the extensions that failed, in one message.
void hvShowUpdateFailures(List<String> failedNames) {
  final message = hvUpdateFailuresMessage(failedNames);
  if (message != null) snackBar(message, duration: 4000, maxLines: 3);
}
