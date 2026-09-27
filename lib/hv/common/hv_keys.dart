/// Settings for the HV features, stored through `KvHelper` like every other
/// AnymeX setting (`HvKeys.x.get<T>(default)` / `.set(v)`).
///
/// The stored key is the enum value's `name`, so every name carries the `hv`
/// prefix to stay clear of upstream keys.
enum HvKeys {
  /// Epoch millis of the last finished library update run.
  hvLastUpdateRunAt,
}
