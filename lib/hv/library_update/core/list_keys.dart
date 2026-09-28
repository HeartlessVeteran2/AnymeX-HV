/// [keys] with list [oldKey] renamed to [newKey] (unchanged when absent).
Set<String> hvRenameListKey(Set<String> keys, String oldKey, String newKey) {
  if (!keys.contains(oldKey) || oldKey == newKey) return keys;
  return {...keys}
    ..remove(oldKey)
    ..add(newKey);
}

/// [keys] without lists that no longer exist.
Set<String> hvPruneListKeys(Set<String> keys, Set<String> existing) =>
    keys.where(existing.contains).toSet();
