// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hv_reader_note.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHvReaderNoteCollection on Isar {
  IsarCollection<HvReaderNote> get hvReaderNotes => this.collection();
}

const HvReaderNoteSchema = CollectionSchema(
  name: r'HvReaderNote',
  id: 1711939416861735345,
  properties: {
    r'chapterKey': PropertySchema(
      id: 0,
      name: r'chapterKey',
      type: IsarType.string,
    ),
    r'chapterNumber': PropertySchema(
      id: 1,
      name: r'chapterNumber',
      type: IsarType.double,
    ),
    r'mediaKey': PropertySchema(
      id: 2,
      name: r'mediaKey',
      type: IsarType.string,
    ),
    r'noteKey': PropertySchema(
      id: 3,
      name: r'noteKey',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 4,
      name: r'text',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.long,
    )
  },
  estimateSize: _hvReaderNoteEstimateSize,
  serialize: _hvReaderNoteSerialize,
  deserialize: _hvReaderNoteDeserialize,
  deserializeProp: _hvReaderNoteDeserializeProp,
  idName: r'id',
  indexes: {
    r'noteKey': IndexSchema(
      id: 6526730111812141609,
      name: r'noteKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'noteKey',
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hvReaderNoteGetId,
  getLinks: _hvReaderNoteGetLinks,
  attach: _hvReaderNoteAttach,
  version: '3.3.0-dev.3',
);

int _hvReaderNoteEstimateSize(
  HvReaderNote object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.chapterKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.mediaKey.length * 3;
  bytesCount += 3 + object.noteKey.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _hvReaderNoteSerialize(
  HvReaderNote object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chapterKey);
  writer.writeDouble(offsets[1], object.chapterNumber);
  writer.writeString(offsets[2], object.mediaKey);
  writer.writeString(offsets[3], object.noteKey);
  writer.writeString(offsets[4], object.text);
  writer.writeLong(offsets[5], object.updatedAt);
}

HvReaderNote _hvReaderNoteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HvReaderNote();
  object.chapterKey = reader.readStringOrNull(offsets[0]);
  object.chapterNumber = reader.readDoubleOrNull(offsets[1]);
  object.id = id;
  object.mediaKey = reader.readString(offsets[2]);
  object.noteKey = reader.readString(offsets[3]);
  object.text = reader.readString(offsets[4]);
  object.updatedAt = reader.readLong(offsets[5]);
  return object;
}

P _hvReaderNoteDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hvReaderNoteGetId(HvReaderNote object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hvReaderNoteGetLinks(HvReaderNote object) {
  return [];
}

void _hvReaderNoteAttach(
    IsarCollection<dynamic> col, Id id, HvReaderNote object) {
  object.id = id;
}

extension HvReaderNoteByIndex on IsarCollection<HvReaderNote> {
  Future<HvReaderNote?> getByNoteKey(String noteKey) {
    return getByIndex(r'noteKey', [noteKey]);
  }

  HvReaderNote? getByNoteKeySync(String noteKey) {
    return getByIndexSync(r'noteKey', [noteKey]);
  }

  Future<bool> deleteByNoteKey(String noteKey) {
    return deleteByIndex(r'noteKey', [noteKey]);
  }

  bool deleteByNoteKeySync(String noteKey) {
    return deleteByIndexSync(r'noteKey', [noteKey]);
  }

  Future<List<HvReaderNote?>> getAllByNoteKey(List<String> noteKeyValues) {
    final values = noteKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'noteKey', values);
  }

  List<HvReaderNote?> getAllByNoteKeySync(List<String> noteKeyValues) {
    final values = noteKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'noteKey', values);
  }

  Future<int> deleteAllByNoteKey(List<String> noteKeyValues) {
    final values = noteKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'noteKey', values);
  }

  int deleteAllByNoteKeySync(List<String> noteKeyValues) {
    final values = noteKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'noteKey', values);
  }

  Future<Id> putByNoteKey(HvReaderNote object) {
    return putByIndex(r'noteKey', object);
  }

  Id putByNoteKeySync(HvReaderNote object, {bool saveLinks = true}) {
    return putByIndexSync(r'noteKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNoteKey(List<HvReaderNote> objects) {
    return putAllByIndex(r'noteKey', objects);
  }

  List<Id> putAllByNoteKeySync(List<HvReaderNote> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'noteKey', objects, saveLinks: saveLinks);
  }
}

extension HvReaderNoteQueryWhereSort
    on QueryBuilder<HvReaderNote, HvReaderNote, QWhere> {
  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HvReaderNoteQueryWhere
    on QueryBuilder<HvReaderNote, HvReaderNote, QWhereClause> {
  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> idBetween(
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> noteKeyEqualTo(
      String noteKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'noteKey',
        value: [noteKey],
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> noteKeyNotEqualTo(
      String noteKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteKey',
              lower: [],
              upper: [noteKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteKey',
              lower: [noteKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteKey',
              lower: [noteKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'noteKey',
              lower: [],
              upper: [noteKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause> mediaKeyEqualTo(
      String mediaKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mediaKey',
        value: [mediaKey],
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterWhereClause>
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

extension HvReaderNoteQueryFilter
    on QueryBuilder<HvReaderNote, HvReaderNote, QFilterCondition> {
  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterKey',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterKey',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyEqualTo(
    String? value, {
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyGreaterThan(
    String? value, {
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyLessThan(
    String? value, {
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chapterKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chapterKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chapterKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      chapterNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chapterNumber',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
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

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      mediaKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mediaKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      mediaKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mediaKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      mediaKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      mediaKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mediaKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'noteKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'noteKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'noteKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'noteKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      noteKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'noteKey',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      updatedAtEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      updatedAtGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      updatedAtLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterFilterCondition>
      updatedAtBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HvReaderNoteQueryObject
    on QueryBuilder<HvReaderNote, HvReaderNote, QFilterCondition> {}

extension HvReaderNoteQueryLinks
    on QueryBuilder<HvReaderNote, HvReaderNote, QFilterCondition> {}

extension HvReaderNoteQuerySortBy
    on QueryBuilder<HvReaderNote, HvReaderNote, QSortBy> {
  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByChapterKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy>
      sortByChapterKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy>
      sortByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByNoteKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByNoteKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HvReaderNoteQuerySortThenBy
    on QueryBuilder<HvReaderNote, HvReaderNote, QSortThenBy> {
  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByChapterKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy>
      thenByChapterKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy>
      thenByChapterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNumber', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByMediaKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByMediaKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mediaKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByNoteKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteKey', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByNoteKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'noteKey', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension HvReaderNoteQueryWhereDistinct
    on QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> {
  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> distinctByChapterKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct>
      distinctByChapterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterNumber');
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> distinctByMediaKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mediaKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> distinctByNoteKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'noteKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HvReaderNote, HvReaderNote, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension HvReaderNoteQueryProperty
    on QueryBuilder<HvReaderNote, HvReaderNote, QQueryProperty> {
  QueryBuilder<HvReaderNote, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HvReaderNote, String?, QQueryOperations> chapterKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterKey');
    });
  }

  QueryBuilder<HvReaderNote, double?, QQueryOperations>
      chapterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterNumber');
    });
  }

  QueryBuilder<HvReaderNote, String, QQueryOperations> mediaKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mediaKey');
    });
  }

  QueryBuilder<HvReaderNote, String, QQueryOperations> noteKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'noteKey');
    });
  }

  QueryBuilder<HvReaderNote, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<HvReaderNote, int, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
