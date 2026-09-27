/// Settings rows that hold credentials or account data.
///
/// The backup's "auth tokens" switch used to test `key.startsWith('AuthKeys_')`,
/// but settings are stored under the bare enum value name (`authToken`, not
/// `AuthKeys_authToken`), so no row ever matched and every token was exported
/// whenever "settings" was included. These are the real stored names.
const Set<String> hvSecretSettingKeys = {
  // AuthKeys
  'authToken',
  'malAuthToken',
  'malRefreshToken',
  'simklAuthToken',
  'malSessionId',
  'mangaBakaAuthToken',
  // SyncKeys.gistGithubToken
  'gistGithubToken',
  // DiscordKeys (lib/controllers/discord/discord_rpc.dart): user token and
  // the account profile fetched with it.
  'token',
  'profile',
};

/// Whether a settings row belongs with the auth tokens in a backup.
bool hvIsSecretSettingKey(String key) =>
    key.startsWith('AuthKeys_') || hvSecretSettingKeys.contains(key);
