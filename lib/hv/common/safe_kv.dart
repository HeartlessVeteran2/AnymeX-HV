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
