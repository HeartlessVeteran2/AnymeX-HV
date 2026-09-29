import 'dart:async';

import 'package:anymex/hv/common/core/latest_only.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a load is current until a newer one starts', () {
    final loads = HvLatestOnly();
    final first = loads.begin();
    expect(loads.isCurrent(first), isTrue);

    final second = loads.begin();
    expect(loads.isCurrent(first), isFalse);
    expect(loads.isCurrent(second), isTrue);
  });

  test('a slow load that finishes last does not apply its result', () async {
    // Chapter A's pages are slow; the user opens chapter B meanwhile, which
    // loads first. A's late result must not replace B's.
    final loads = HvLatestOnly();
    String? shown;
    final slow = Completer<String>();

    Future<void> load(Future<String> pages) async {
      final me = loads.begin();
      final result = await pages;
      if (loads.isCurrent(me)) shown = result;
    }

    final a = load(slow.future);
    await load(Future.value('chapter B'));
    slow.complete('chapter A');
    await a;

    expect(shown, 'chapter B');
  });
}
