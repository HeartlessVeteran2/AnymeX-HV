import 'dart:convert';

import 'package:anymex/database/isar_models/key_value.dart';
import 'package:anymex/database/kv_helper.dart';
import 'package:anymex/hv/common/core/safe_kv_writer.dart';
import 'package:anymex/main.dart';

/// A [HvSafeKvWriter] for one [KvHelper] key: the same row and encoding as
/// `KvHelper.set<String>`, written asynchronously when a sync write can't
/// start.
HvSafeKvWriter hvSafeStringKey(String key) => HvSafeKvWriter(
      writeSync: (value) => KvHelper.set<String>(key, value),
      writeAsync: (value) => isar.writeTxn(() => isar
          .collection<KeyValue>()
          .put(KeyValue()
            ..key = key
            ..value = jsonEncode({'val': value}))),
    );

final Map<String, HvSafeKvWriter> _rowWriters = {};

/// `KvHelper.set(key, value)` that never throws: when a sync write can't
/// start (an async write is running, e.g. the reader saving progress), the
/// value is saved right after it (see [HvSafeKvWriter]).
///
/// For values written in the background or in cleanup code, where an
/// exception would break the caller.
void hvSafeSet<T>(String key, T value) => _rowWriters
    .putIfAbsent(
        key,
        () => HvSafeKvWriter(
              writeSync: (row) => isar.writeTxnSync(
                  () => isar.collection<KeyValue>().putSync(_row(key, row))),
              writeAsync: (row) => isar.writeTxn(
                  () => isar.collection<KeyValue>().put(_row(key, row))),
            ))
    .write(jsonEncode({'val': value}));

KeyValue _row(String key, String row) => KeyValue()
  ..key = key
  ..value = row;
