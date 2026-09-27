import 'package:anymex/hv/discovery/core/feed_rows.dart';
import 'package:anymex/hv/discovery/core/rec_ranking.dart';
import 'package:flutter_test/flutter_test.dart';

RecEdge e(String from, int id, int rating, {int? mal, int? score}) => RecEdge(
    fromTitle: from,
    mediaId: id,
    idMal: mal,
    title: 'T$id',
    rating: rating,
    averageScore: score);

void main() {
  group('rankRecommendations', () {
    test('most recommending titles first, then rating', () {
      final ranked = rankRecommendations([
        e('A', 1, 10),
        e('B', 1, 5),
        e('A', 2, 100),
        e('C', 3, 50),
      ]);
      expect(ranked.map((r) => r.mediaId).toList(), [1, 2, 3]);
      expect(ranked.first.because, ['A', 'B']);
      expect(ranked.first.ratingSum, 15);
    });

    test('titles already in the library are left out by either id', () {
      final ranked = rankRecommendations(
        [e('A', 1, 10), e('A', 2, 10, mal: 22), e('A', 3, 10)],
        excludeIds: {1},
        excludeMalIds: {22},
      );
      expect(ranked.map((r) => r.mediaId), [3]);
    });

    test('downvoted recommendations are ignored', () {
      final ranked = rankRecommendations([e('A', 1, -3), e('B', 2, 0)]);
      expect(ranked.map((r) => r.mediaId), [2]);
    });

    test('the same library title recommending twice counts once', () {
      final ranked = rankRecommendations([e('A', 1, 1), e('A', 1, 1)]);
      expect(ranked.single.count, 1);
    });

    test('json round trip', () {
      final r = rankRecommendations([e('A', 7, 3, mal: 70, score: 81)]).single;
      final back = RankedRec.fromJson(r.toJson())!;
      expect(back.mediaId, 7);
      expect(back.idMal, 70);
      expect(back.averageScore, 81);
      expect(back.because, ['A']);
      expect(RankedRec.fromJson({'id': 'x'}), isNull);
    });
  });

  group('feed rows', () {
    const latest = FeedRow(id: 'a', typeIndex: 0, sourceId: 's', sourceName: 'S');
    const search = FeedRow(
        id: 'b', typeIndex: 0, sourceId: 's', sourceName: 'S', query: 'Isekai');

    test('json round trip and malformed rows skipped', () {
      final rows = decodeFeedRows([search.toJson(), 'junk', {'id': 1}]);
      expect(rows.length, 1);
      expect(rows.single.query, 'Isekai');
      expect(rows.single.isSearch, isTrue);
      expect(latest.isSearch, isFalse);
    });

    test('duplicates are not added (search compared case-insensitively)', () {
      var rows = addFeedRow(const [], latest);
      rows = addFeedRow(rows, search);
      rows = addFeedRow(
          rows,
          const FeedRow(
              id: 'c', typeIndex: 0, sourceId: 's', sourceName: 'S', query: ' isekai '));
      expect(rows.map((r) => r.id), ['a', 'b']);
    });

    test('move clamps to the list', () {
      final rows = [latest, search];
      expect(moveFeedRow(rows, 'b', -1).map((r) => r.id), ['b', 'a']);
      expect(moveFeedRow(rows, 'b', 5).map((r) => r.id), ['a', 'b']);
      expect(moveFeedRow(rows, 'zz', 1), same(rows));
    });
  });
}
