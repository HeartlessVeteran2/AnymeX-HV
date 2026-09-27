import 'package:anymex/hv/library_update/core/error_grouping.dart';
import 'package:anymex/hv/library_update/core/update_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('updateSkipReason', () {
    const reading = UpdateCandidate(
        lists: {'0|Reading'}, unreadCount: 0, status: 'RELEASING');

    test('no settings checks everything', () {
      expect(updateSkipReason(reading, const UpdateFilterSettings()), isNull);
    });

    test('exclude wins over include', () {
      const s = UpdateFilterSettings(
          includeLists: {'0|Reading'}, excludeLists: {'0|Reading'});
      expect(updateSkipReason(reading, s), 'In an excluded list');
    });

    test('include limits to the chosen lists', () {
      const s = UpdateFilterSettings(includeLists: {'0|Planning'});
      expect(updateSkipReason(reading, s), 'Not in an included list');
      const s2 = UpdateFilterSettings(includeLists: {'0|Planning', '0|Reading'});
      expect(updateSkipReason(reading, s2), isNull);
    });

    test('completed, not started and unread restrictions', () {
      const done = UpdateCandidate(lists: {}, status: 'FINISHED');
      const fresh = UpdateCandidate(lists: {}, started: false);
      const behind = UpdateCandidate(lists: {}, unreadCount: 3);
      const unknown = UpdateCandidate(lists: {}, unreadCount: null);
      const s = UpdateFilterSettings(
          skipCompleted: true, skipNotStarted: true, skipWithUnread: true);
      expect(updateSkipReason(done, s), 'Completed');
      expect(updateSkipReason(fresh, s), 'Not started');
      expect(updateSkipReason(behind, s), 'Has unread chapters');
      expect(updateSkipReason(unknown, s), isNull);
      expect(updateSkipReason(done, const UpdateFilterSettings()), isNull);
    });

    test('completed status spellings', () {
      expect(isCompletedStatus('FINISHED'), isTrue);
      expect(isCompletedStatus('Completed'), isTrue);
      expect(isCompletedStatus('RELEASING'), isFalse);
      expect(isCompletedStatus('??'), isFalse);
      expect(isCompletedStatus(null), isFalse);
    });
  });

  test('isAutoUpdateDue', () {
    const hour = 3600 * 1000;
    expect(isAutoUpdateDue(intervalHours: 0, lastRunAt: 0, now: 99 * hour),
        isFalse);
    expect(isAutoUpdateDue(intervalHours: 12, lastRunAt: 0, now: 11 * hour),
        isFalse);
    expect(isAutoUpdateDue(intervalHours: 12, lastRunAt: 0, now: 12 * hour),
        isTrue);
  });

  group('error grouping', () {
    test('messages differing only in urls and ids group together', () {
      expect(normalizeErrorMessage('HTTP 403 for https://a.com/x/1'),
          normalizeErrorMessage('HTTP 403 for https://a.com/y/2'));
      expect(normalizeErrorMessage('HTTP 403'),
          isNot(normalizeErrorMessage('HTTP 404')));
      expect(normalizeErrorMessage('manga 123456 not found'),
          'manga <n> not found');
    });

    test('biggest group first, newest item first', () {
      final errors = [
        (m: 'Timeout', t: 1),
        (m: 'HTTP 403 for https://x/1', t: 2),
        (m: 'HTTP 403 for https://x/2', t: 5),
      ];
      final groups =
          groupErrors(errors, message: (e) => e.m, timestamp: (e) => e.t);
      expect(groups.length, 2);
      expect(groups.first.message, 'HTTP 403 for <url>');
      expect(groups.first.items.map((e) => e.t).toList(), [5, 2]);
      expect(groups.last.message, 'Timeout');
    });
  });
}
