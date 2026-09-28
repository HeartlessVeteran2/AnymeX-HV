import 'package:anymex/hv/source_link/link_merge.dart';
import 'package:anymex/hv/source_link/models/hv_source_link.dart';
import 'package:flutter_test/flutter_test.dart';

HvSourceLink _link() => HvSourceLink()
  ..mediaId = 'm'
  ..mediaTypeIndex = 0
  ..serviceIndex = 0
  ..sourceId = 's'
  ..url = '/entry';

void main() {
  test('a link saved meanwhile for the same entry is merged, not dropped',
      () {
    // Saved by another fetch while this one was recording chapters: the
    // user picked this entry, and that fetch saw chapter c3.
    final saved = _link()
      ..userConfirmed = true
      ..matchScore = 1
      ..knownChapterKeys = ['c1', 'c2', 'c3']
      ..linkedAt = 100
      ..lastCheckedAt = 300
      ..lastNewChapterAt = 300
      ..latestChapterNumber = 3;
    // This fetch: an automatic match that started earlier.
    final link = _link()
      ..matchScore = 0.8
      ..knownChapterKeys = ['c1', 'c2']
      ..linkedAt = 200
      ..lastCheckedAt = 250
      ..latestChapterNumber = 2;

    hvMergeSavedLink(link, saved);

    expect(link.userConfirmed, isTrue);
    expect(link.matchScore, 1);
    expect(link.knownChapterKeys.toSet(), {'c1', 'c2', 'c3'});
    expect(link.linkedAt, 100);
    expect(link.lastCheckedAt, 300);
    expect(link.lastNewChapterAt, 300);
    // What this fetch found wins where the two can't be combined.
    expect(link.latestChapterNumber, 2);
  });

  test('unset fields are filled from the saved link', () {
    final saved = _link()
      ..linkedAt = 100
      ..lastCheckedAt = 300
      ..latestChapterNumber = 3;
    final link = _link();

    hvMergeSavedLink(link, saved);

    expect(link.linkedAt, 100);
    expect(link.lastCheckedAt, 300);
    expect(link.latestChapterNumber, 3);
    expect(link.userConfirmed, isFalse);
  });
}
