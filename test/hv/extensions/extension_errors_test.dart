import 'package:anymex/hv/extensions/extension_errors.dart';
import 'package:anymex/hv/extensions/source_calls.dart';
import 'package:flutter_test/flutter_test.dart';

String msg(Object e, {HvExtensionAction a = HvExtensionAction.install}) =>
    hvExtensionErrorMessage(e, sourceName: 'Foo', action: a);

void main() {
  group('hvExtensionErrorMessage', () {
    test('offline', () {
      expect(msg(Exception('SocketException: Failed host lookup: x.com')),
          contains('no connection'));
    });

    test('CloudStream plugin without a download link', () {
      expect(msg(Exception('Plugin URL is required for installation.')),
          contains('no download link'));
    });

    test('Aniyomi APK without a download link (Future.error string)', () {
      expect(msg('Source APK URL is required for installation.'),
          contains('no download link'));
    });

    test('HTTP failure keeps the status code', () {
      expect(msg(Exception('Failed to download APK: HTTP 404')),
          "Couldn't download Foo (HTTP 404). The repo may be out of date.");
    });

    test('Android refused the APK', () {
      expect(
          msg(Exception('Installation failed: INSTALL_FAILED_USER_RESTRICTED')),
          contains('install unknown apps'));
    });

    test('internal loading failure is not confused with a system install', () {
      final m = msg(Exception('Internal installation failed for Foo'));
      expect(m, contains('internal loading off'));
      expect(m, isNot(contains('unknown apps')));
    });

    test('runtime bridge missing', () {
      expect(
          msg(Exception('MissingPluginException(No implementation found)')),
          contains('extension bridge'));
    });

    test('uninstall cancelled', () {
      expect(
          msg(Exception('Uninstallation timed out or was cancelled by user.'),
              a: HvExtensionAction.uninstall),
          'Removing Foo was cancelled.');
    });

    test('anything else is shown, trimmed to one short line', () {
      final m = msg(Exception('Exception: weird\nstack line'),
          a: HvExtensionAction.update);
      expect(m, "Couldn't update Foo: weird");
      final long = msg(Exception('x' * 500));
      expect(long.length, lessThan(200));
    });

    test('missing source name', () {
      expect(
          hvExtensionErrorMessage(Exception('boom'),
              sourceName: null, action: HvExtensionAction.install),
          "Couldn't install this extension: boom");
    });
  });

  group('hvUpdateFailuresMessage', () {
    test('nothing failed', () {
      expect(hvUpdateFailuresMessage([]), isNull);
    });

    test('names up to three and counts the rest', () {
      expect(hvUpdateFailuresMessage(['A']),
          startsWith("Couldn't update 1 extension: A."));
      expect(hvUpdateFailuresMessage(['A', 'B', 'C', 'D', 'E']),
          startsWith("Couldn't update 5 extensions: A, B, C and 2 more."));
    });
  });

  group('hvPageLoadErrorMessage', () {
    test('offline', () {
      expect(
          hvPageLoadErrorMessage(
              Exception('ClientException with SocketException: Failed host lookup')),
          'No connection. Check your internet and try again.');
    });

    test('our own readable errors are shown in full', () {
      for (final e in [
        const HvSourceTimeoutException('Loading pages', Duration(seconds: 60)),
        const HvNoSourceException(),
      ]) {
        expect(hvPageLoadErrorMessage(e), e.toString());
      }
    });

    test("keeps the reader's own message as it was", () {
      expect(
          hvPageLoadErrorMessage(Exception('No pages found for this chapter')),
          'No pages found for this chapter');
    });

    test('a long error over several lines becomes one short line', () {
      final message = hvPageLoadErrorMessage(
          'SourceCodeException: Fatal parsing errors for the direct source:\n'
          "- Expected to find ';'. (ligne 1, colonne 1)\n"
          "- Expected to find ';'. (ligne 1, colonne 6)");
      expect(message,
          'SourceCodeException: Fatal parsing errors for the direct source:');
      expect(
          hvPageLoadErrorMessage('x' * 500), hasLength(lessThanOrEqualTo(140)));
    });
  });
}
