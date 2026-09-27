// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hv_source_link.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHvSourceLinkCollection on Isar {
  IsarCollection<HvSourceLink> get hvSourceLinks => this.collection();
}

const HvSourceLinkSchema = CollectionSchema(
  name: r'HvSourceLink',
  id: 1335146113882557668,
  properties: {
    r'knownChapterKeys': PropertySchema(
      id: 0,
      name: r'knownChapterKeys',
      type: IsarType.stringList,
    ),
    r'lastCheckedAt': PropertySchema(
      id: 1,
      name: r'lastCheckedAt',
      type: IsarType.long,
    ),
    r'lastNewChapterAt': PropertySchema(
      id: 2,
      name: r'lastNewChapterAt',
      type: IsarType.long,
    ),
    r'latestChapterNumber': PropertySchema(
      id: 3,
      name: r'latestChapterNumber',
      type: IsarType.double,
    ),
    r'linkKey': PropertySchema(
      id: 4,
      name: r'linkKey',
      type: IsarType.string,
    ),
    r'linkedAt': PropertySchema(
      id: 5,
      name: r'linkedAt',
      type: IsarType.long,
    ),
    r'matchScore': PropertySchema(
      id: 6,
      name: r'matchScore',
      type: IsarType.double,
    ),
    r'mediaId': PropertySchema(
      id: 7,
      name: r'mediaId',
      type: IsarType.string,
    ),
    r'mediaTypeIndex': PropertySchema(
      id: 8,
      name: r'mediaTypeIndex',
      type: IsarType.long,
    ),
    r'serviceIndex': PropertySchema(
      id: 9,
      name: r'serviceIndex',
      type: IsarType.long,
    ),
    r'sourceId': PropertySchema(
      id: 10,
      name: r'sourceId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 11,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 12,
      name: r'title',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 13,
      name: r'url',
      type: IsarType.string,
    ),
    r'userConfirmed': PropertySchema(
      id: 14,
      name: r'userConfirmed',
      type: IsarType.bool,
    )
  },
  estimateSize: _hvSourceLinkEstimateSize,
  serialize: _hvSourceLinkSerialize,
  deserialize: _hvSourceLinkDeserialize,
  deserializeProp: _hvSourceLinkDeserializeProp,
  idName: r'id',
  indexes: {
    r'linkKey': IndexSchema(
      id: 7263477011456965770,
      name: r'linkKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'linkKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'mediaId': IndexSchema(
      id: -8001372983137409759,
      name: r'mediaId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'mediaId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hvSourceLinkGetId,
  getLinks: _hvSourceLinkGetLinks,
  attach: _hvSourceLinkAttach,
  version: '3.3.0-dev.3',
);

int _hvSourceLinkEstimateSize(
  HvSourceLink object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.knownChapterKeys.length * 3;
  {
    for (var i = 0; i < object.knownChapterKeys.length; i++) {
      final value = object.knownChapterKeys[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.linkKey.length * 3;
  bytesCount += 3 + object.mediaId.length * 3;
  bytesCount += 3 + object.sourceId.length * 3;
  {
    final value = object.sourceName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _hvSourceLinkSerialize(
  HvSourceLink object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.knownChapterKeys);
  writer.writeLong(offsets[1], object.lastCheckedAt);
  writer.writeLong(offsets[2], object.lastNewChapterAt);
  writer.writeDouble(offsets[3], object.latestChapterNumber);
  writer.writeString(offsets[4], object.linkKey);
  writer.writeLong(offsets[5], object.linkedAt);
  writer.writeDouble(offsets[6], object.matchScore);
  writer.writeString(offsets[7], object.mediaId);
  writer.writeLong(offsets[8], object.mediaTypeIndex);
  writer.writeLong(offsets[9], object.serviceIndex);
  writer.writeString(offsets[10], object.sourceId);
  writer.writeString(offsets[11], object.sourceName);
  writer.writeString(offsets[12], object.title);
  writer.writeString(offsets[13], object.url);
  writer.writeBool(offsets[14], object.userConfirmed);
}

HvSourceLink _hvSourceLinkDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HvSourceLink();
  object.id = id;
  object.knownChapterKeys = reader.readStringList(offsets[0]) ?? [];
  object.lastCheckedAt = reader.readLongOrNull(offsets[1]);
  object.lastNewChapterAt = reader.readLongOrNull(offsets[2]);
  object.latestChapterNumber = reader.readDoubleOrNull(offsets[3]);
  object.linkKey = reader.readString(offsets[4]);
  object.linkedAt = reader.readLong(offsets[5]);
  object.matchScore = reader.readDouble(offsets[6]);
  object.mediaId = reader.readString(offsets[7]);
  object.mediaTypeIndex = reader.readLong(offsets[8]);
  object.serviceIndex = reader.readLong(offsets[9]);
  object.sourceId = reader.readString(offsets[10]);
  object.sourceName = reader.readStringOrNull(offsets[11]);
  object.title = reader.readStringOrNull(offsets[12]);
  object.url = reader.readString(offsets[13]);
  object.userConfirmed = reader.readBool(offsets[14]);
  return object;
}

P _hvSourceLinkDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hvSourceLinkGetId(HvSourceLink object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hvSourceLinkGetLinks(HvSourceLink object) {
  return [];
}

void _hvSourceLinkAttach(
    IsarCollection<dynamic> col, Id id, HvSourceLink object) {
  object.id = id;
}

extension HvSourceLinkByIndex on IsarCollection<HvSourceLink> {
  Future<HvSourceLink?> getByLinkKey(String linkKey) {
    return getByIndex(r'linkKey', [linkKey]);
  }

  HvSourceLink? getByLinkKeySync(String linkKey) {
    return getByIndexSync(r'linkKey', [linkKey]);
  }

  Future<bool> deleteByLinkKey(String linkKey) {
    return deleteByIndex(r'linkKey', [linkKey]);
  }

  bool deleteByLinkKeySync(String linkKey) {
    return deleteByIndexSync(r'linkKey', [linkKey]);
  }

  Future<List<HvSourceLink?>> getAllByLinkKey(List<String> linkKeyValues) {
    final values = linkKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'linkKey', values);
  }

  List<HvSourceLink?> getAllByLinkKeySync(List<String> linkKeyValues) {
    final values = linkKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'linkKey', values);
  }

  Future<int> deleteAllByLinkKey(List<String> linkKeyValues) {
    final values = linkKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'linkKey', values);
  }

  int deleteAllByLinkKeySync(List<String> linkKeyValues) {
    final values = linkKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'linkKey', values);
  }

  Future<Id> putByLinkKey(HvSourceLink object) {
    return putByIndex(r'linkKey', object);
  }

  Id putByLinkKeySync(HvSourceLink object, {bool saveLinks = true}) {
    return putByIndexSync(r'linkKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLinkKey(List<HvSourceLink> objects) {
    return putAllByIndex(r'linkKey', objects);
  }

  List<Id> putAllByLinkKeySync(List<HvSourceLink> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'linkKey', objects, saveLinks: saveLinks);
  }
}

extension HvSourceLinkQueryWhereSort
    on QueryBuilder<HvSourceLink, HvSourceLink, QWhere> {
  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HvSourceLinkQueryWhere
    on QueryBuilder<HvSourceLink, HvSourceLink, QWhereClause> {
  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> idBetween(
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> linkKeyEqualTo(
      String linkKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'linkKey',
        value: [linkKey],
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> linkKeyNotEqualTo(
      String linkKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'linkKey',
              lower: [],
              upper: [linkKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'linkKey',
              lower: [linkKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'linkKey',
              lower: [linkKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'linkKey',
              lower: [],
              upper: [linkKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> mediaIdEqualTo(
      String mediaId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mediaId',
        value: [mediaId],
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterWhereClause> mediaIdNotEqualTo(
      String mediaId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaId',
              lower: [],
              upper: [mediaId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaId',
              lower: [mediaId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaId',
              lower: [mediaId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mediaId',
              lower: [],
              upper: [mediaId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension HvSourceLinkQueryFilter
    on QueryBuilder<HvSourceLink, HvSourceLink, QFilterCondition> {
  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'knownChapterKeys',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'knownChapterKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'knownChapterKeys',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'knownChapterKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'knownChapterKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      knownChapterKeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'knownChapterKeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCheckedAt',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCheckedAt',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCheckedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastCheckedAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCheckedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastNewChapterAt',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastNewChapterAt',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastNewChapterAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastNewChapterAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastNewChapterAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      lastNewChapterAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastNewChapterAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'latestChapterNumber',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'latestChapterNumber',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latestChapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latestChapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latestChapterNumber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      latestChapterNumberBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latestChapterNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'linkKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'linkKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'linkKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'linkedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'linkedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'linkedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      linkedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'linkedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      matchScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      matchScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      matchScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      matchScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      mediaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      mediaIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      mediaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      mediaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      mediaTypeIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      serviceIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      serviceIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serviceIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      serviceIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serviceIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      serviceIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serviceIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
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

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterFilterCondition>
      userConfirmedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userConfirmed',
        value: value,
      ));
    });
  }
}

extension HvSourceLinkQueryObject
    on QueryBuilder<HvSourceLink, HvSourceLink, QFilterCondition> {}

extension HvSourceLinkQueryLinks
    on QueryBuilder<HvSourceLink, HvSourceLink, QFilterCondition> {}

extension HvSourceLinkQuerySortBy
    on QueryBuilder<HvSourceLink, HvSourceLink, QSortBy> {
  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByLastCheckedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByLastNewChapterAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNewChapterAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByLastNewChapterAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNewChapterAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByLatestChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestChapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByLatestChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestChapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByLinkKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkKey', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByLinkKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkKey', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByLinkedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByLinkedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByMatchScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchScore', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByMatchScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchScore', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByServiceIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceIndex', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByServiceIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceIndex', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> sortByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      sortByUserConfirmedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.desc);
    });
  }
}

extension HvSourceLinkQuerySortThenBy
    on QueryBuilder<HvSourceLink, HvSourceLink, QSortThenBy> {
  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByLastCheckedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCheckedAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByLastNewChapterAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNewChapterAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByLastNewChapterAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastNewChapterAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByLatestChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestChapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByLatestChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latestChapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByLinkKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkKey', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByLinkKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkKey', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByLinkedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAt', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByLinkedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'linkedAt', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByMatchScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchScore', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByMatchScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchScore', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByServiceIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceIndex', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByServiceIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceIndex', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'url', Sort.desc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy> thenByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.asc);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QAfterSortBy>
      thenByUserConfirmedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.desc);
    });
  }
}

extension HvSourceLinkQueryWhereDistinct
    on QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> {
  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByKnownChapterKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'knownChapterKeys');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByLastCheckedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCheckedAt');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByLastNewChapterAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastNewChapterAt');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByLatestChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latestChapterNumber');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByLinkKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByLinkedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'linkedAt');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByMatchScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchScore');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByMediaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByServiceIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serviceIndex');
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctBySourceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctBySourceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct> distinctByUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvSourceLink, HvSourceLink, QDistinct>
      distinctByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userConfirmed');
    });
  }
}

extension HvSourceLinkQueryProperty
    on QueryBuilder<HvSourceLink, HvSourceLink, QQueryProperty> {
  QueryBuilder<HvSourceLink, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HvSourceLink, List<String>, QQueryOperations>
      knownChapterKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'knownChapterKeys');
    });
  }

  QueryBuilder<HvSourceLink, int?, QQueryOperations> lastCheckedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCheckedAt');
    });
  }

  QueryBuilder<HvSourceLink, int?, QQueryOperations>
      lastNewChapterAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastNewChapterAt');
    });
  }

  QueryBuilder<HvSourceLink, double?, QQueryOperations>
      latestChapterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latestChapterNumber');
    });
  }

  QueryBuilder<HvSourceLink, String, QQueryOperations> linkKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkKey');
    });
  }

  QueryBuilder<HvSourceLink, int, QQueryOperations> linkedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'linkedAt');
    });
  }

  QueryBuilder<HvSourceLink, double, QQueryOperations> matchScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchScore');
    });
  }

  QueryBuilder<HvSourceLink, String, QQueryOperations> mediaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaId');
    });
  }

  QueryBuilder<HvSourceLink, int, QQueryOperations> mediaTypeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvSourceLink, int, QQueryOperations> serviceIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceIndex');
    });
  }

  QueryBuilder<HvSourceLink, String, QQueryOperations> sourceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceId');
    });
  }

  QueryBuilder<HvSourceLink, String?, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<HvSourceLink, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<HvSourceLink, String, QQueryOperations> urlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'url');
    });
  }

  QueryBuilder<HvSourceLink, bool, QQueryOperations> userConfirmedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userConfirmed');
    });
  }
}
