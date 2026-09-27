import 'dart:io';

import 'package:anymex/hv/library_update/ui/updates_screen.dart';
import 'package:anymex/utils/function.dart';
import 'package:anymex/utils/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// System notifications for new chapters. Android, Linux and Windows show a
/// system notification; elsewhere (iOS/macOS) the Updates badge and the
/// in-app message are used instead.
class HvNotifications {
  HvNotifications._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;
  static bool _available = false;

  static const int _newChaptersId = 4201;
  static const String _channelId = 'hv_library_updates';

  static bool get supported =>
      Platform.isAndroid || Platform.isLinux || Platform.isWindows;

  static Future<bool> _init() async {
    if (_initialized) return _available;
    _initialized = true;
    if (!supported) return false;
    try {
      const settings = InitializationSettings(
        android:
            AndroidInitializationSettings('@mipmap/ic_launcher_monochrome'),
        linux: LinuxInitializationSettings(defaultActionName: 'Open'),
        windows: WindowsInitializationSettings(
          appName: 'AnymeX',
          appUserModelId: 'com.ryan.anymex',
          guid: '6f4c2a7e-3b1d-4e8a-9c55-2d7b0e1f9a34',
        ),
      );
      await _plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: (_) =>
            navigate(() => const HvUpdatesScreen()),
      );
      _available = true;
    } catch (e) {
      Logger.e('HV: notifications unavailable: $e');
      _available = false;
    }
    return _available;
  }

  /// Asks for the Android 13+ notification permission. Returns false when
  /// denied or unsupported.
  static Future<bool> requestPermission() async {
    if (!await _init()) return false;
    if (!Platform.isAndroid) return true;
    try {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await android?.requestNotificationsPermission() ?? true;
    } catch (e) {
      Logger.e('HV: notification permission request failed: $e');
      return false;
    }
  }

  /// Shows (or replaces) the "new chapters" notification. Returns false when
  /// no system notification could be shown.
  static Future<bool> showNewChapters(int count, List<String> titles) async {
    if (count <= 0 || !await _init()) return false;
    final names = titles.toSet().toList();
    final body = names.length <= 3
        ? names.join(', ')
        : '${names.take(3).join(', ')} and ${names.length - 3} more';
    try {
      await _plugin.show(
        id: _newChaptersId,
        title: '$count new chapter${count == 1 ? '' : 's'}',
        body: body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            'Library updates',
            channelDescription: 'New chapters found in your library',
            importance: Importance.defaultImportance,
            priority: Priority.defaultPriority,
          ),
          linux: LinuxNotificationDetails(),
          windows: WindowsNotificationDetails(),
        ),
      );
      return true;
    } catch (e) {
      Logger.e('HV: showing notification failed: $e');
      return false;
    }
  }
}
