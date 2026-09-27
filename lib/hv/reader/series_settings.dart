import 'package:anymex/database/data_keys/keys.dart';
import 'package:anymex/hv/common/media_key.dart';
import 'package:anymex/hv/reader/core/series_override.dart';
import 'package:anymex/screens/manga/controller/reader_controller.dart';
import 'package:anymex/utils/logger.dart';
import 'package:get/get.dart';

class _State {
  final RxBool active = false.obs;
  late final int globalLayout;
  late final int globalDirection;
  late final int? globalDual;
  late final bool globalCrop;
}

/// "Remember reader settings for this series": reading mode, direction,
/// dual page and crop borders saved per title. While on, changing those
/// four in the reader updates the series and leaves the global defaults
/// alone.
class HvSeriesSettings {
  HvSeriesSettings._();

  static final Expando<_State> _states = Expando('hvSeriesSettings');

  static String _key(ReaderController c) =>
      'hvReaderOverride_${hvMediaKey(c.media.mediaType.index, c.media.id)}';

  static _State _state(ReaderController c) => _states[c] ??= _snapshot();

  static _State _snapshot() => _State()
    ..globalLayout = ReaderKeys.readingLayout.get<int>(0)
    ..globalDirection = ReaderKeys.readingDirection.get<int>(1)
    ..globalDual = ReaderKeys.dualPageMode.get<int?>()
    ..globalCrop = ReaderKeys.cropImages.get<bool>(false);

  static RxBool activeFor(ReaderController c) => _state(c).active;

  /// Called once the reader has loaded its global settings: applies the
  /// series' settings when it has any.
  static void attach(ReaderController c) {
    try {
      final state = _state(c);
      final saved = HvSeriesOverride.fromJson(KvHelper.get<Map<String, dynamic>>(
          _key(c),
          defaultVal: const {}));
      if (saved == null) return;
      final o = saved.clamped(
        layouts: MangaPageViewMode.values.length,
        directions: MangaPageViewDirection.values.length,
        dualModes: DualPageMode.values.length,
      );
      c.readingLayout.value = MangaPageViewMode.values[o.layout];
      c.readingDirection.value = MangaPageViewDirection.values[o.direction];
      c.dualPageMode.value = DualPageMode.values[o.dualPage];
      c.cropImages.value = o.crop;
      state.active.value = true;
    } catch (e) {
      Logger.e('HV: applying series reader settings failed: $e');
    }
  }

  /// Called at the end of the reader's own save: keeps the series' values
  /// in the series and the global defaults as they were.
  static void afterSave(ReaderController c) {
    final state = _states[c];
    if (state == null || !state.active.value) return;
    _saveOverride(c);
    ReaderKeys.readingLayout.set(state.globalLayout);
    ReaderKeys.readingDirection.set(state.globalDirection);
    if (state.globalDual == null) {
      ReaderKeys.dualPageMode.delete();
    } else {
      ReaderKeys.dualPageMode.set(state.globalDual);
    }
    ReaderKeys.cropImages.set(state.globalCrop);
  }

  static void _saveOverride(ReaderController c) {
    KvHelper.set(
        _key(c),
        HvSeriesOverride(
          layout: c.readingLayout.value.index,
          direction: c.readingDirection.value.index,
          dualPage: c.dualPageMode.value.index,
          crop: c.cropImages.value,
        ).toJson());
  }

  static void setEnabled(ReaderController c, bool enabled) {
    final state = _state(c);
    if (enabled) {
      state.active.value = true;
      _saveOverride(c);
      return;
    }
    state.active.value = false;
    KvHelper.remove(_key(c));
    // Back to the global defaults.
    c.changeReadingLayout(MangaPageViewMode.values[state.globalLayout
        .clamp(0, MangaPageViewMode.values.length - 1)]);
    c.changeReadingDirection(MangaPageViewDirection.values[state
        .globalDirection
        .clamp(0, MangaPageViewDirection.values.length - 1)]);
    if (state.globalDual != null) {
      c.toggleDualPageMode(DualPageMode.values[
          state.globalDual!.clamp(0, DualPageMode.values.length - 1)]);
    }
    if (c.cropImages.value != state.globalCrop) c.toggleCropImages();
  }
}
