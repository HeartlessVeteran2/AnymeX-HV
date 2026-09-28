// The bridge (our fork) must hand Mangayomi sources their apiUrl and date
// format; the fork ignores its own test/ folder, so the check lives here.
import 'dart:convert';

import 'package:anymex_extension_runtime_bridge/Services/Mangayomi/Models/Source.dart';
import 'package:flutter_test/flutter_test.dart';

// Entries as they appear in the Mangayomi index.json.
final _mangadex = {
  'name': 'MangaDex',
  'id': 202373705,
  'baseUrl': 'https://mangadex.org',
  'lang': 'en',
  'typeSource': 'single',
  'iconUrl': '',
  'dateFormat': '',
  'dateFormatLocale': '',
  'isNsfw': true,
  'hasCloudflare': false,
  'sourceCodeUrl': 'https://example.org/mangadex.js',
  'apiUrl': 'https://api.mangadex.org',
  'version': '0.1.0',
  'isManga': true,
  'itemType': 0,
  'isFullData': false,
  'appMinVerReq': '0.5.0',
  'additionalParams': '',
  'sourceCodeLanguage': 1,
  'notes': '',
};

final _madara = {
  ..._mangadex,
  'name': 'MangaRead.org',
  'id': 120353492,
  'apiUrl': '',
  'dateFormat': 'dd.MM.yyy',
  'dateFormatLocale': 'en_us',
  'typeSource': 'madara',
  'sourceCodeLanguage': 0,
};

void main() {
  test('the extension gets the api url and date format from the index', () {
    final api = MSource.fromJson(_mangadex).toMSource();
    expect(api.apiUrl, 'https://api.mangadex.org');
    expect(api.baseUrl, 'https://mangadex.org');

    final madara = MSource.fromJson(_madara).toMSource();
    expect(madara.dateFormat, 'dd.MM.yyy');
    expect(madara.dateFormatLocale, 'en_us');
    expect(madara.additionalParams, '');
  });

  test('the fields survive being saved as an installed source', () {
    final saved = jsonDecode(jsonEncode(MSource.fromJson(_mangadex).toJson()));
    final m = MSource.fromJson(saved).toMSource();
    expect(m.apiUrl, 'https://api.mangadex.org');
    expect(m.isFullData, isFalse);
  });

  test('a source installed without them gets them from its repo entry', () {
    final old = Map<String, dynamic>.from(_madara)
      ..remove('apiUrl')
      ..remove('dateFormat')
      ..remove('dateFormatLocale')
      ..remove('additionalParams')
      ..remove('notes')
      ..remove('hasCloudflare')
      ..remove('isFullData');
    final installed = MSource.fromJson(old);
    expect(installed.toMSource().dateFormat, isNull);

    expect(installed.fillMissingFrom(MSource.fromJson(_madara)), isTrue);
    expect(installed.toMSource().dateFormat, 'dd.MM.yyy');
    // Already complete: nothing to change.
    expect(installed.fillMissingFrom(MSource.fromJson(_madara)), isFalse);
  });
}
