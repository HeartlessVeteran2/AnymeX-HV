import 'package:anymex/hv/common/read_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('page completion follows the upstream rule', () {
    expect(hvIsPageComplete(null, 20), isFalse);
    expect(hvIsPageComplete(5, 0), isFalse);
    expect(hvIsPageComplete(10, 20), isFalse);
    expect(hvIsPageComplete(19, 20), isTrue); // second-to-last page
    expect(hvIsPageComplete(20, 20), isTrue);
    expect(hvIsPageComplete(96, 100), isTrue);
  });

  test('matches by link first, then by number', () {
    final saved = <HvSavedChapter>[
      (link: '/c/1', number: 1, page: 20, total: 20),
      (link: '/c/2', number: 2, page: 3, total: 20),
    ];
    expect(hvIsChapterRead(saved, link: '/c/1'), isTrue);
    expect(hvIsChapterRead(saved, link: '/c/2', number: 1), isFalse);
    expect(hvIsChapterRead(saved, link: '/other', number: 1), isTrue);
    expect(hvIsChapterRead(saved, number: 3), isFalse);
  });

  test('a chapter is read when any copy of it is finished', () {
    final chapters = <HvSavedChapter>[
      // An older visit's saved progress comes first...
      (link: '/a/5', number: 5, page: 3, total: 20),
      // ...and this session finished it (or another source's copy).
      (link: '/b/5', number: 5, page: 20, total: 20),
      (link: '/a/6', number: 6, page: 2, total: 20),
    ];
    expect(hvIsNumberRead(chapters, 5), isTrue);
    // The first match alone would say unread.
    expect(hvIsChapterRead(chapters, number: 5), isFalse);
    expect(hvIsNumberRead(chapters, 6), isFalse);
    expect(hvIsNumberRead(chapters, 7), isFalse);
  });
}
