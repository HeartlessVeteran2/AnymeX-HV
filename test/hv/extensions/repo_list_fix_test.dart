import 'dart:convert';

import 'package:anymex/hv/extensions/repo_list_fix.dart';
import 'package:anymex_extension_runtime_bridge/anymex_extension_runtime_bridge.dart';
import 'package:flutter_test/flutter_test.dart';

/// A manager that implements nothing but its identity and type support; the
/// repo lists come from the real [Extension] base class.
class _FakeManager extends Extension {
  _FakeManager(this.id, {this.supportsNovel = true});

  @override
  final String id;

  @override
  String get name => id;

  @override
  final bool supportsNovel;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

String _stored(String url) =>
    jsonEncode(Repo(url: url, managerId: 'm').toJson());

void main() {
  test('fills an empty repo list from storage', () {
    final m = _FakeManager('mangayomi');
    final store = {
      'mangayomimangaRepos': [_stored('https://a/index.json')],
      'mangayomianimeRepos': [
        _stored('https://b/anime.json'),
        _stored('https://c/anime.json'),
      ],
    };

    restoreRepoLists([m], (key) => store[key]);

    expect(m.getReposRx(ItemType.manga).value.map((r) => r.url),
        ['https://a/index.json']);
    expect(m.getReposRx(ItemType.anime).value.map((r) => r.url),
        ['https://b/anime.json', 'https://c/anime.json']);
    expect(m.getReposRx(ItemType.novel).value, isEmpty);
  });

  test('leaves a list the manager already filled untouched', () {
    final m = _FakeManager('aniyomi');
    final own = [Repo(url: 'https://own/repo')];
    m.getReposRx(ItemType.manga).value = own;

    restoreRepoLists(
        [m], (key) => [_stored('https://stale/repo')]);

    expect(identical(m.getReposRx(ItemType.manga).value, own), isTrue);
  });

  test('skips types the manager does not support', () {
    final m = _FakeManager('cloudstream', supportsNovel: false);
    final asked = <String>[];

    restoreRepoLists([m], (key) {
      asked.add(key);
      return [_stored('https://x/repo')];
    });

    expect(asked, isNot(contains('cloudstreamnovelRepos')));
    expect(m.getReposRx(ItemType.novel).value, isEmpty);
  });

  test('decodeStoredRepos drops malformed entries', () {
    final repos = decodeStoredRepos([
      'not json',
      jsonEncode({'name': 'no url'}),
      _stored('https://ok/repo'),
    ]);
    expect(repos.map((r) => r.url), ['https://ok/repo']);
    expect(decodeStoredRepos(null), isEmpty);
  });

  test('gives entries saved without a manager id the owning manager', () {
    final m = _FakeManager('mangayomi');
    restoreRepoLists([m], (key) => [jsonEncode({'url': 'https://old/repo'})]);

    // Removing a repo finds its manager by this id.
    expect(m.getReposRx(ItemType.manga).value.single.managerId, 'mangayomi');
  });

  test('uses the same key the bridge stores under', () {
    expect(repoStorageKey('mangayomi', ItemType.manga), 'mangayomimangaRepos');
  });
}
