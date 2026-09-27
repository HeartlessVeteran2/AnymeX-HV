// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hv_chapter_update.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHvChapterUpdateCollection on Isar {
  IsarCollection<HvChapterUpdate> get hvChapterUpdates => this.collection();
}

const HvChapterUpdateSchema = CollectionSchema(
  name: r'HvChapterUpdate',
  id: -2953452406649399909,
  properties: {
    r'chapterLink': PropertySchema(
      id: 0,
      name: r'chapterLink',
      type: IsarType.string,
    ),
    r'chapterNumber': PropertySchema(
      id: 1,
      name: r'chapterNumber',
      type: IsarType.double,
    ),
    r'chapterTitle': PropertySchema(
      id: 2,
      name: r'chapterTitle',
      type: IsarType.string,
    ),
    r'dismissed': PropertySchema(
      id: 3,
      name: r'dismissed',
      type: IsarType.bool,
    ),
    r'foundAt': PropertySchema(
      id: 4,
      name: r'foundAt',
      type: IsarType.long,
    ),
    r'mediaId': PropertySchema(
      id: 5,
      name: r'mediaId',
      type: IsarType.string,
    ),
    r'mediaKey': PropertySchema(
      id: 6,
      name: r'mediaKey',
      type: IsarType.string,
    ),
    r'mediaTitle': PropertySchema(
      id: 7,
      name: r'mediaTitle',
      type: IsarType.string,
    ),
    r'mediaTypeIndex': PropertySchema(
      id: 8,
      name: r'mediaTypeIndex',
      type: IsarType.long,
    ),
    r'poster': PropertySchema(
      id: 9,
      name: r'poster',
      type: IsarType.string,
    ),
    r'releaseDate': PropertySchema(
      id: 10,
      name: r'releaseDate',
      type: IsarType.string,
    ),
    r'scanlator': PropertySchema(
      id: 11,
      name: r'scanlator',
      type: IsarType.string,
    ),
    r'sourceId': PropertySchema(
      id: 12,
      name: r'sourceId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 13,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'updateKey': PropertySchema(
      id: 14,
      name: r'updateKey',
      type: IsarType.string,
    )
  },
  estimateSize: _hvChapterUpdateEstimateSize,
  serialize: _hvChapterUpdateSerialize,
  deserialize: _hvChapterUpdateDeserialize,
  deserializeProp: _hvChapterUpdateDeserializeProp,
  idName: r'id',
  indexes: {
    r'updateKey': IndexSchema(
      id: -5689059472335773448,
      name: r'updateKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'updateKey',
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
    r'foundAt': IndexSchema(
      id: 7078297571956648664,
      name: r'foundAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'foundAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hvChapterUpdateGetId,
  getLinks: _hvChapterUpdateGetLinks,
  attach: _hvChapterUpdateAttach,
  version: '3.3.0-dev.3',
);

int _hvChapterUpdateEstimateSize(
  HvChapterUpdate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.chapterLink;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.chapterTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
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
    final value = object.poster;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.releaseDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.scanlator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.sourceId.length * 3;
  {
    final value = object.sourceName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.updateKey.length * 3;
  return bytesCount;
}

void _hvChapterUpdateSerialize(
  HvChapterUpdate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chapterLink);
  writer.writeDouble(offsets[1], object.chapterNumber);
  writer.writeString(offsets[2], object.chapterTitle);
  writer.writeBool(offsets[3], object.dismissed);
  writer.writeLong(offsets[4], object.foundAt);
  writer.writeString(offsets[5], object.mediaId);
  writer.writeString(offsets[6], object.mediaKey);
  writer.writeString(offsets[7], object.mediaTitle);
  writer.writeLong(offsets[8], object.mediaTypeIndex);
  writer.writeString(offsets[9], object.poster);
  writer.writeString(offsets[10], object.releaseDate);
  writer.writeString(offsets[11], object.scanlator);
  writer.writeString(offsets[12], object.sourceId);
  writer.writeString(offsets[13], object.sourceName);
  writer.writeString(offsets[14], object.updateKey);
}

HvChapterUpdate _hvChapterUpdateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HvChapterUpdate();
  object.chapterLink = reader.readStringOrNull(offsets[0]);
  object.chapterNumber = reader.readDoubleOrNull(offsets[1]);
  object.chapterTitle = reader.readStringOrNull(offsets[2]);
  object.dismissed = reader.readBool(offsets[3]);
  object.foundAt = reader.readLong(offsets[4]);
  object.id = id;
  object.mediaId = reader.readString(offsets[5]);
  object.mediaKey = reader.readString(offsets[6]);
  object.mediaTitle = reader.readStringOrNull(offsets[7]);
  object.mediaTypeIndex = reader.readLong(offsets[8]);
  object.poster = reader.readStringOrNull(offsets[9]);
  object.releaseDate = reader.readStringOrNull(offsets[10]);
  object.scanlator = reader.readStringOrNull(offsets[11]);
  object.sourceId = reader.readString(offsets[12]);
  object.sourceName = reader.readStringOrNull(offsets[13]);
  object.updateKey = reader.readString(offsets[14]);
  return object;
}

P _hvChapterUpdateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hvChapterUpdateGetId(HvChapterUpdate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hvChapterUpdateGetLinks(HvChapterUpdate object) {
  return [];
}

void _hvChapterUpdateAttach(
    IsarCollection<dynamic> col, Id id, HvChapterUpdate object) {
  object.id = id;
}

extension HvChapterUpdateByIndex on IsarCollection<HvChapterUpdate> {
  Future<HvChapterUpdate?> getByUpdateKey(String updateKey) {
    return getByIndex(r'updateKey', [updateKey]);
  }

  HvChapterUpdate? getByUpdateKeySync(String updateKey) {
    return getByIndexSync(r'updateKey', [updateKey]);
  }

  Future<bool> deleteByUpdateKey(String updateKey) {
    return deleteByIndex(r'updateKey', [updateKey]);
  }

  bool deleteByUpdateKeySync(String updateKey) {
    return deleteByIndexSync(r'updateKey', [updateKey]);
  }

  Future<List<HvChapterUpdate?>> getAllByUpdateKey(
      List<String> updateKeyValues) {
    final values = updateKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'updateKey', values);
  }

  List<HvChapterUpdate?> getAllByUpdateKeySync(List<String> updateKeyValues) {
    final values = updateKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'updateKey', values);
  }

  Future<int> deleteAllByUpdateKey(List<String> updateKeyValues) {
    final values = updateKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'updateKey', values);
  }

  int deleteAllByUpdateKeySync(List<String> updateKeyValues) {
    final values = updateKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'updateKey', values);
  }

  Future<Id> putByUpdateKey(HvChapterUpdate object) {
    return putByIndex(r'updateKey', object);
  }

  Id putByUpdateKeySync(HvChapterUpdate object, {bool saveLinks = true}) {
    return putByIndexSync(r'updateKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUpdateKey(List<HvChapterUpdate> objects) {
    return putAllByIndex(r'updateKey', objects);
  }

  List<Id> putAllByUpdateKeySync(List<HvChapterUpdate> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'updateKey', objects, saveLinks: saveLinks);
  }
}

extension HvChapterUpdateQueryWhereSort
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QWhere> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhere> anyFoundAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'foundAt'),
      );
    });
  }
}

extension HvChapterUpdateQueryWhere
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QWhereClause> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause> idBetween(
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      updateKeyEqualTo(String updateKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updateKey',
        value: [updateKey],
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      updateKeyNotEqualTo(String updateKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateKey',
              lower: [],
              upper: [updateKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateKey',
              lower: [updateKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateKey',
              lower: [updateKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updateKey',
              lower: [],
              upper: [updateKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      mediaKeyEqualTo(String mediaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mediaKey',
        value: [mediaKey],
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      foundAtEqualTo(int foundAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'foundAt',
        value: [foundAt],
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      foundAtNotEqualTo(int foundAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foundAt',
              lower: [],
              upper: [foundAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foundAt',
              lower: [foundAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foundAt',
              lower: [foundAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'foundAt',
              lower: [],
              upper: [foundAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      foundAtGreaterThan(
    int foundAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'foundAt',
        lower: [foundAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      foundAtLessThan(
    int foundAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'foundAt',
        lower: [],
        upper: [foundAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterWhereClause>
      foundAtBetween(
    int lowerFoundAt,
    int upperFoundAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'foundAt',
        lower: [lowerFoundAt],
        includeLower: includeLower,
        upper: [upperFoundAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HvChapterUpdateQueryFilter
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QFilterCondition> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterLink',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterLink',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterLink',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterLink',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterTitle',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterTitle',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      chapterTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      dismissedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dismissed',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      foundAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foundAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      foundAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foundAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      foundAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foundAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      foundAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foundAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      mediaTypeIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
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

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'poster',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poster',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      posterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'poster',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'releaseDate',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'releaseDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'releaseDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'releaseDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'releaseDate',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      releaseDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'releaseDate',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scanlator',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scanlator',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scanlator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scanlator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scanlator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scanlator',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      scanlatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scanlator',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterFilterCondition>
      updateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateKey',
        value: '',
      ));
    });
  }
}

extension HvChapterUpdateQueryObject
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QFilterCondition> {}

extension HvChapterUpdateQueryLinks
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QFilterCondition> {}

extension HvChapterUpdateQuerySortBy
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QSortBy> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterLink', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterLink', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissed', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByDismissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissed', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> sortByFoundAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foundAt', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByFoundAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foundAt', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> sortByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> sortByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByScanlator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByScanlatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByUpdateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateKey', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      sortByUpdateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateKey', Sort.desc);
    });
  }
}

extension HvChapterUpdateQuerySortThenBy
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QSortThenBy> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterLink', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterLink', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByChapterTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterTitle', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissed', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByDismissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dismissed', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> thenByFoundAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foundAt', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByFoundAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'foundAt', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> thenByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy> thenByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByReleaseDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByReleaseDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'releaseDate', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByScanlator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByScanlatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanlator', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByUpdateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateKey', Sort.asc);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QAfterSortBy>
      thenByUpdateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateKey', Sort.desc);
    });
  }
}

extension HvChapterUpdateQueryWhereDistinct
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> {
  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByChapterLink({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterNumber');
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByChapterTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByDismissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dismissed');
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByFoundAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'foundAt');
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctByMediaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctByMediaKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByMediaTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poster', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctByReleaseDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'releaseDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctByScanlator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scanlator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctBySourceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct>
      distinctBySourceName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvChapterUpdate, HvChapterUpdate, QDistinct> distinctByUpdateKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateKey', caseSensitive: caseSensitive);
    });
  }
}

extension HvChapterUpdateQueryProperty
    on QueryBuilder<HvChapterUpdate, HvChapterUpdate, QQueryProperty> {
  QueryBuilder<HvChapterUpdate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations>
      chapterLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterLink');
    });
  }

  QueryBuilder<HvChapterUpdate, double?, QQueryOperations>
      chapterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterNumber');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations>
      chapterTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterTitle');
    });
  }

  QueryBuilder<HvChapterUpdate, bool, QQueryOperations> dismissedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dismissed');
    });
  }

  QueryBuilder<HvChapterUpdate, int, QQueryOperations> foundAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'foundAt');
    });
  }

  QueryBuilder<HvChapterUpdate, String, QQueryOperations> mediaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaId');
    });
  }

  QueryBuilder<HvChapterUpdate, String, QQueryOperations> mediaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaKey');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations>
      mediaTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTitle');
    });
  }

  QueryBuilder<HvChapterUpdate, int, QQueryOperations>
      mediaTypeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poster');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations>
      releaseDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'releaseDate');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations> scanlatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scanlator');
    });
  }

  QueryBuilder<HvChapterUpdate, String, QQueryOperations> sourceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceId');
    });
  }

  QueryBuilder<HvChapterUpdate, String?, QQueryOperations>
      sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<HvChapterUpdate, String, QQueryOperations> updateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateKey');
    });
  }
}
