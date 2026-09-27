// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hv_page_bookmark.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHvPageBookmarkCollection on Isar {
  IsarCollection<HvPageBookmark> get hvPageBookmarks => this.collection();
}

const HvPageBookmarkSchema = CollectionSchema(
  name: r'HvPageBookmark',
  id: -5962468974274865123,
  properties: {
    r'bookmarkKey': PropertySchema(
      id: 0,
      name: r'bookmarkKey',
      type: IsarType.string,
    ),
    r'chapterKey': PropertySchema(
      id: 1,
      name: r'chapterKey',
      type: IsarType.string,
    ),
    r'chapterNumber': PropertySchema(
      id: 2,
      name: r'chapterNumber',
      type: IsarType.double,
    ),
    r'chapterTitle': PropertySchema(
      id: 3,
      name: r'chapterTitle',
      type: IsarType.string,
    ),
    r'collectionId': PropertySchema(
      id: 4,
      name: r'collectionId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'headerKeys': PropertySchema(
      id: 6,
      name: r'headerKeys',
      type: IsarType.stringList,
    ),
    r'headerValues': PropertySchema(
      id: 7,
      name: r'headerValues',
      type: IsarType.stringList,
    ),
    r'mediaId': PropertySchema(
      id: 8,
      name: r'mediaId',
      type: IsarType.string,
    ),
    r'mediaKey': PropertySchema(
      id: 9,
      name: r'mediaKey',
      type: IsarType.string,
    ),
    r'mediaTitle': PropertySchema(
      id: 10,
      name: r'mediaTitle',
      type: IsarType.string,
    ),
    r'mediaTypeIndex': PropertySchema(
      id: 11,
      name: r'mediaTypeIndex',
      type: IsarType.long,
    ),
    r'note': PropertySchema(
      id: 12,
      name: r'note',
      type: IsarType.string,
    ),
    r'pageNumber': PropertySchema(
      id: 13,
      name: r'pageNumber',
      type: IsarType.long,
    ),
    r'pageUrl': PropertySchema(
      id: 14,
      name: r'pageUrl',
      type: IsarType.string,
    ),
    r'poster': PropertySchema(
      id: 15,
      name: r'poster',
      type: IsarType.string,
    )
  },
  estimateSize: _hvPageBookmarkEstimateSize,
  serialize: _hvPageBookmarkSerialize,
  deserialize: _hvPageBookmarkDeserialize,
  deserializeProp: _hvPageBookmarkDeserializeProp,
  idName: r'id',
  indexes: {
    r'bookmarkKey': IndexSchema(
      id: 2045294644863421943,
      name: r'bookmarkKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'bookmarkKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'mediaKey': IndexSchema(
      id: 1283343194331584075,
      name: r'mediaKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'mediaKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hvPageBookmarkGetId,
  getLinks: _hvPageBookmarkGetLinks,
  attach: _hvPageBookmarkAttach,
  version: '3.3.0-dev.3',
);

int _hvPageBookmarkEstimateSize(
  HvPageBookmark object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookmarkKey.length * 3;
  bytesCount += 3 + object.chapterKey.length * 3;
  {
    final value = object.chapterTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.headerKeys;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.headerValues;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.mediaId.length * 3;
  bytesCount += 3 + object.mediaKey.length * 3;
  {
    final value = object.mediaTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.poster;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _hvPageBookmarkSerialize(
  HvPageBookmark object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bookmarkKey);
  writer.writeString(offsets[1], object.chapterKey);
  writer.writeDouble(offsets[2], object.chapterNumber);
  writer.writeString(offsets[3], object.chapterTitle);
  writer.writeLong(offsets[4], object.collectionId);
  writer.writeLong(offsets[5], object.createdAt);
  writer.writeStringList(offsets[6], object.headerKeys);
  writer.writeStringList(offsets[7], object.headerValues);
  writer.writeString(offsets[8], object.mediaId);
  writer.writeString(offsets[9], object.mediaKey);
  writer.writeString(offsets[10], object.mediaTitle);
  writer.writeLong(offsets[11], object.mediaTypeIndex);
  writer.writeString(offsets[12], object.note);
  writer.writeLong(offsets[13], object.pageNumber);
  writer.writeString(offsets[14], object.pageUrl);
  writer.writeString(offsets[15], object.poster);
}

HvPageBookmark _hvPageBookmarkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HvPageBookmark();
  object.bookmarkKey = reader.readString(offsets[0]);
  object.chapterKey = reader.readString(offsets[1]);
  object.chapterNumber = reader.readDoubleOrNull(offsets[2]);
  object.chapterTitle = reader.readStringOrNull(offsets[3]);
  object.collectionId = reader.readLongOrNull(offsets[4]);
  object.createdAt = reader.readLong(offsets[5]);
  object.headerKeys = reader.readStringList(offsets[6]);
  object.headerValues = reader.readStringList(offsets[7]);
  object.id = id;
  object.mediaId = reader.readString(offsets[8]);
  object.mediaKey = reader.readString(offsets[9]);
  object.mediaTitle = reader.readStringOrNull(offsets[10]);
  object.mediaTypeIndex = reader.readLong(offsets[11]);
  object.note = reader.readStringOrNull(offsets[12]);
  object.pageNumber = reader.readLong(offsets[13]);
  object.pageUrl = reader.readStringOrNull(offsets[14]);
  object.poster = reader.readStringOrNull(offsets[15]);
  return object;
}

P _hvPageBookmarkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringList(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hvPageBookmarkGetId(HvPageBookmark object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hvPageBookmarkGetLinks(HvPageBookmark object) {
  return [];
}

void _hvPageBookmarkAttach(
    IsarCollection<dynamic> col, Id id, HvPageBookmark object) {
  object.id = id;
}

extension HvPageBookmarkByIndex on IsarCollection<HvPageBookmark> {
  Future<HvPageBookmark?> getByBookmarkKey(String bookmarkKey) {
    return getByIndex(r'bookmarkKey', [bookmarkKey]);
  }

  HvPageBookmark? getByBookmarkKeySync(String bookmarkKey) {
    return getByIndexSync(r'bookmarkKey', [bookmarkKey]);
  }

  Future<bool> deleteByBookmarkKey(String bookmarkKey) {
    return deleteByIndex(r'bookmarkKey', [bookmarkKey]);
  }

  bool deleteByBookmarkKeySync(String bookmarkKey) {
    return deleteByIndexSync(r'bookmarkKey', [bookmarkKey]);
  }

  Future<List<HvPageBookmark?>> getAllByBookmarkKey(
      List<String> bookmarkKeyValues) {
    final values = bookmarkKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'bookmarkKey', values);
  }

  List<HvPageBookmark?> getAllByBookmarkKeySync(
      List<String> bookmarkKeyValues) {
    final values = bookmarkKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'bookmarkKey', values);
  }

  Future<int> deleteAllByBookmarkKey(List<String> bookmarkKeyValues) {
    final values = bookmarkKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'bookmarkKey', values);
  }

  int deleteAllByBookmarkKeySync(List<String> bookmarkKeyValues) {
    final values = bookmarkKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'bookmarkKey', values);
  }

  Future<Id> putByBookmarkKey(HvPageBookmark object) {
    return putByIndex(r'bookmarkKey', object);
  }

  Id putByBookmarkKeySync(HvPageBookmark object, {bool saveLinks = true}) {
    return putByIndexSync(r'bookmarkKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByBookmarkKey(List<HvPageBookmark> objects) {
    return putAllByIndex(r'bookmarkKey', objects);
  }

  List<Id> putAllByBookmarkKeySync(List<HvPageBookmark> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'bookmarkKey', objects, saveLinks: saveLinks);
  }
}

extension HvPageBookmarkQueryWhereSort
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QWhere> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension HvPageBookmarkQueryWhere
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QWhereClause> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      bookmarkKeyEqualTo(String bookmarkKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'bookmarkKey',
        value: [bookmarkKey],
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      bookmarkKeyNotEqualTo(String bookmarkKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkKey',
              lower: [],
              upper: [bookmarkKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkKey',
              lower: [bookmarkKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkKey',
              lower: [bookmarkKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'bookmarkKey',
              lower: [],
              upper: [bookmarkKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      mediaKeyEqualTo(String mediaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mediaKey',
        value: [mediaKey],
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      mediaKeyNotEqualTo(String mediaKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaKey',
              lower: [],
              upper: [mediaKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaKey',
              lower: [mediaKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaKey',
              lower: [mediaKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaKey',
              lower: [],
              upper: [mediaKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      createdAtEqualTo(int createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      createdAtNotEqualTo(int createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      createdAtGreaterThan(
    int createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      createdAtLessThan(
    int createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterWhereClause>
      createdAtBetween(
    int lowerCreatedAt,
    int upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HvPageBookmarkQueryFilter
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QFilterCondition> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookmarkKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookmarkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookmarkKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarkKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      bookmarkKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookmarkKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterNumberBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterTitle',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterTitle',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      chapterTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'collectionId',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'collectionId',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'collectionId',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'collectionId',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'collectionId',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      collectionIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'collectionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      createdAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      createdAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      createdAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      createdAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'headerKeys',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'headerKeys',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headerKeys',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headerKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headerKeys',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headerKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerKeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerKeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'headerValues',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'headerValues',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headerValues',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headerValues',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headerValues',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headerValues',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headerValues',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      headerValuesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'headerValues',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaTitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTypeIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTypeIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTypeIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      mediaTypeIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mediaTypeIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pageUrl',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pageUrl',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      pageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'poster',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'poster',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poster',
        value: '',
      ));
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterFilterCondition>
      posterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'poster',
        value: '',
      ));
    });
  }
}

extension HvPageBookmarkQueryObject
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QFilterCondition> {}

extension HvPageBookmarkQueryLinks
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QFilterCondition> {}

extension HvPageBookmarkQuerySortBy
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QSortBy> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByBookmarkKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByBookmarkKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByPageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageUrl', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByPageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageUrl', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> sortByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      sortByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }
}

extension HvPageBookmarkQuerySortThenBy
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QSortThenBy> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByBookmarkKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByBookmarkKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarkKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByCollectionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionId', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByPageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageUrl', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByPageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageUrl', Sort.desc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy> thenByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QAfterSortBy>
      thenByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }
}

extension HvPageBookmarkQueryWhereDistinct
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> {
  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByBookmarkKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarkKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByChapterKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterNumber');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByChapterTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByCollectionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'collectionId');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByHeaderKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'headerKeys');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByHeaderValues() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'headerValues');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByMediaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByMediaKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByMediaTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct>
      distinctByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageNumber');
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByPageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvPageBookmark, HvPageBookmark, QDistinct> distinctByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poster', caseSensitive: caseSensitive);
    });
  }
}

extension HvPageBookmarkQueryProperty
    on QueryBuilder<HvPageBookmark, HvPageBookmark, QQueryProperty> {
  QueryBuilder<HvPageBookmark, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HvPageBookmark, String, QQueryOperations> bookmarkKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarkKey');
    });
  }

  QueryBuilder<HvPageBookmark, String, QQueryOperations> chapterKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterKey');
    });
  }

  QueryBuilder<HvPageBookmark, double?, QQueryOperations>
      chapterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterNumber');
    });
  }

  QueryBuilder<HvPageBookmark, String?, QQueryOperations>
      chapterTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterTitle');
    });
  }

  QueryBuilder<HvPageBookmark, int?, QQueryOperations> collectionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionId');
    });
  }

  QueryBuilder<HvPageBookmark, int, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<HvPageBookmark, List<String>?, QQueryOperations>
      headerKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headerKeys');
    });
  }

  QueryBuilder<HvPageBookmark, List<String>?, QQueryOperations>
      headerValuesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headerValues');
    });
  }

  QueryBuilder<HvPageBookmark, String, QQueryOperations> mediaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaId');
    });
  }

  QueryBuilder<HvPageBookmark, String, QQueryOperations> mediaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaKey');
    });
  }

  QueryBuilder<HvPageBookmark, String?, QQueryOperations> mediaTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTitle');
    });
  }

  QueryBuilder<HvPageBookmark, int, QQueryOperations> mediaTypeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvPageBookmark, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<HvPageBookmark, int, QQueryOperations> pageNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageNumber');
    });
  }

  QueryBuilder<HvPageBookmark, String?, QQueryOperations> pageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageUrl');
    });
  }

  QueryBuilder<HvPageBookmark, String?, QQueryOperations> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poster');
    });
  }
}
