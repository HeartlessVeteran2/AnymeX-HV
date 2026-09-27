// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hv_update_error.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHvUpdateErrorCollection on Isar {
  IsarCollection<HvUpdateError> get hvUpdateErrors => this.collection();
}

const HvUpdateErrorSchema = CollectionSchema(
  name: r'HvUpdateError',
  id: 4448641915363789712,
  properties: {
    r'mediaId': PropertySchema(
      id: 0,
      name: r'mediaId',
      type: IsarType.string,
    ),
    r'mediaKey': PropertySchema(
      id: 1,
      name: r'mediaKey',
      type: IsarType.string,
    ),
    r'mediaTitle': PropertySchema(
      id: 2,
      name: r'mediaTitle',
      type: IsarType.string,
    ),
    r'mediaTypeIndex': PropertySchema(
      id: 3,
      name: r'mediaTypeIndex',
      type: IsarType.long,
    ),
    r'message': PropertySchema(
      id: 4,
      name: r'message',
      type: IsarType.string,
    ),
    r'poster': PropertySchema(
      id: 5,
      name: r'poster',
      type: IsarType.string,
    ),
    r'sourceId': PropertySchema(
      id: 6,
      name: r'sourceId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 7,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 8,
      name: r'timestamp',
      type: IsarType.long,
    )
  },
  estimateSize: _hvUpdateErrorEstimateSize,
  serialize: _hvUpdateErrorSerialize,
  deserialize: _hvUpdateErrorDeserialize,
  deserializeProp: _hvUpdateErrorDeserializeProp,
  idName: r'id',
  indexes: {
    r'mediaKey': IndexSchema(
      id: 1283343194331584075,
      name: r'mediaKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'mediaKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hvUpdateErrorGetId,
  getLinks: _hvUpdateErrorGetLinks,
  attach: _hvUpdateErrorAttach,
  version: '3.3.0-dev.3',
);

int _hvUpdateErrorEstimateSize(
  HvUpdateError object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mediaId.length * 3;
  bytesCount += 3 + object.mediaKey.length * 3;
  {
    final value = object.mediaTitle;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.message.length * 3;
  {
    final value = object.poster;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sourceId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sourceName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _hvUpdateErrorSerialize(
  HvUpdateError object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.mediaId);
  writer.writeString(offsets[1], object.mediaKey);
  writer.writeString(offsets[2], object.mediaTitle);
  writer.writeLong(offsets[3], object.mediaTypeIndex);
  writer.writeString(offsets[4], object.message);
  writer.writeString(offsets[5], object.poster);
  writer.writeString(offsets[6], object.sourceId);
  writer.writeString(offsets[7], object.sourceName);
  writer.writeLong(offsets[8], object.timestamp);
}

HvUpdateError _hvUpdateErrorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HvUpdateError();
  object.id = id;
  object.mediaId = reader.readString(offsets[0]);
  object.mediaKey = reader.readString(offsets[1]);
  object.mediaTitle = reader.readStringOrNull(offsets[2]);
  object.mediaTypeIndex = reader.readLong(offsets[3]);
  object.message = reader.readString(offsets[4]);
  object.poster = reader.readStringOrNull(offsets[5]);
  object.sourceId = reader.readStringOrNull(offsets[6]);
  object.sourceName = reader.readStringOrNull(offsets[7]);
  object.timestamp = reader.readLong(offsets[8]);
  return object;
}

P _hvUpdateErrorDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hvUpdateErrorGetId(HvUpdateError object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hvUpdateErrorGetLinks(HvUpdateError object) {
  return [];
}

void _hvUpdateErrorAttach(
    IsarCollection<dynamic> col, Id id, HvUpdateError object) {
  object.id = id;
}

extension HvUpdateErrorByIndex on IsarCollection<HvUpdateError> {
  Future<HvUpdateError?> getByMediaKey(String mediaKey) {
    return getByIndex(r'mediaKey', [mediaKey]);
  }

  HvUpdateError? getByMediaKeySync(String mediaKey) {
    return getByIndexSync(r'mediaKey', [mediaKey]);
  }

  Future<bool> deleteByMediaKey(String mediaKey) {
    return deleteByIndex(r'mediaKey', [mediaKey]);
  }

  bool deleteByMediaKeySync(String mediaKey) {
    return deleteByIndexSync(r'mediaKey', [mediaKey]);
  }

  Future<List<HvUpdateError?>> getAllByMediaKey(List<String> mediaKeyValues) {
    final values = mediaKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'mediaKey', values);
  }

  List<HvUpdateError?> getAllByMediaKeySync(List<String> mediaKeyValues) {
    final values = mediaKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'mediaKey', values);
  }

  Future<int> deleteAllByMediaKey(List<String> mediaKeyValues) {
    final values = mediaKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'mediaKey', values);
  }

  int deleteAllByMediaKeySync(List<String> mediaKeyValues) {
    final values = mediaKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'mediaKey', values);
  }

  Future<Id> putByMediaKey(HvUpdateError object) {
    return putByIndex(r'mediaKey', object);
  }

  Id putByMediaKeySync(HvUpdateError object, {bool saveLinks = true}) {
    return putByIndexSync(r'mediaKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMediaKey(List<HvUpdateError> objects) {
    return putAllByIndex(r'mediaKey', objects);
  }

  List<Id> putAllByMediaKeySync(List<HvUpdateError> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'mediaKey', objects, saveLinks: saveLinks);
  }
}

extension HvUpdateErrorQueryWhereSort
    on QueryBuilder<HvUpdateError, HvUpdateError, QWhere> {
  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HvUpdateErrorQueryWhere
    on QueryBuilder<HvUpdateError, HvUpdateError, QWhereClause> {
  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> idBetween(
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause> mediaKeyEqualTo(
      String mediaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mediaKey',
        value: [mediaKey],
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterWhereClause>
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
}

extension HvUpdateErrorQueryFilter
    on QueryBuilder<HvUpdateError, HvUpdateError, QFilterCondition> {
  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mediaTitle',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaTitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaTitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaTitle',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      mediaTypeIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaTypeIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poster',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'poster',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'poster',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poster',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      posterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'poster',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sourceId',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sourceId',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdEqualTo(
    String? value, {
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdGreaterThan(
    String? value, {
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdLessThan(
    String? value, {
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sourceName',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
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

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      timestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      timestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterFilterCondition>
      timestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HvUpdateErrorQueryObject
    on QueryBuilder<HvUpdateError, HvUpdateError, QFilterCondition> {}

extension HvUpdateErrorQueryLinks
    on QueryBuilder<HvUpdateError, HvUpdateError, QFilterCondition> {}

extension HvUpdateErrorQuerySortBy
    on QueryBuilder<HvUpdateError, HvUpdateError, QSortBy> {
  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension HvUpdateErrorQuerySortThenBy
    on QueryBuilder<HvUpdateError, HvUpdateError, QSortThenBy> {
  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMediaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMediaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaId', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMediaTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenByMediaTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTitle', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenByMediaTypeIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaTypeIndex', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByPoster() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByPosterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poster', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension HvUpdateErrorQueryWhereDistinct
    on QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> {
  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByMediaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByMediaKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByMediaTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTitle', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct>
      distinctByMediaTypeIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByPoster(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poster', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctBySourceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctBySourceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvUpdateError, HvUpdateError, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension HvUpdateErrorQueryProperty
    on QueryBuilder<HvUpdateError, HvUpdateError, QQueryProperty> {
  QueryBuilder<HvUpdateError, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HvUpdateError, String, QQueryOperations> mediaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaId');
    });
  }

  QueryBuilder<HvUpdateError, String, QQueryOperations> mediaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaKey');
    });
  }

  QueryBuilder<HvUpdateError, String?, QQueryOperations> mediaTitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTitle');
    });
  }

  QueryBuilder<HvUpdateError, int, QQueryOperations> mediaTypeIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaTypeIndex');
    });
  }

  QueryBuilder<HvUpdateError, String, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<HvUpdateError, String?, QQueryOperations> posterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poster');
    });
  }

  QueryBuilder<HvUpdateError, String?, QQueryOperations> sourceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceId');
    });
  }

  QueryBuilder<HvUpdateError, String?, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<HvUpdateError, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
