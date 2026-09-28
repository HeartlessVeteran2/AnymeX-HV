import 'package:anymex/controllers/discord/discord_rpc.dart';
import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/hv/backup/secret_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every auth key, the gist token and the discord token are secret', () {
    for (final key in AuthKeys.values) {
      expect(hvIsSecretSettingKey(key.name), isTrue, reason: key.name);
    }
    expect(hvIsSecretSettingKey(SyncKeys.gistGithubToken.name), isTrue);
    expect(hvIsSecretSettingKey(DiscordKeys.token.name), isTrue);
    expect(hvIsSecretSettingKey(DiscordKeys.profile.name), isTrue);
  });

  test('saved site cookies are secret', () {
    // CookieManager stores signed-in sessions under this row.
    expect(hvIsSecretSettingKey('cookies'), isTrue);
  });

  test('ordinary settings are not secret', () {
    expect(hvIsSecretSettingKey(ReaderKeys.cropImages.name), isFalse);
    expect(hvIsSecretSettingKey(SyncKeys.gistGithubUsername.name), isFalse);
  });
}
