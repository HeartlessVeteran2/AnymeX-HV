/// Reader settings remembered for one series (Mihon/Komikku's per-series
/// reading mode), stored as the enum indexes the reader uses.
class HvSeriesOverride {
  final int layout;
  final int direction;
  final int dualPage;
  final bool crop;

  const HvSeriesOverride({
    required this.layout,
    required this.direction,
    required this.dualPage,
    required this.crop,
  });

  Map<String, dynamic> toJson() => {
        'layout': layout,
        'direction': direction,
        'dualPage': dualPage,
        'crop': crop,
      };

  /// Null when the stored value is missing or malformed.
  static HvSeriesOverride? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    final layout = json['layout'];
    final direction = json['direction'];
    final dual = json['dualPage'];
    if (layout is! int || direction is! int || dual is! int) return null;
    return HvSeriesOverride(
      layout: layout,
      direction: direction,
      dualPage: dual,
      crop: json['crop'] == true,
    );
  }

  /// Keeps each index inside its enum (a newer build may have fewer values).
  HvSeriesOverride clamped({
    required int layouts,
    required int directions,
    required int dualModes,
  }) =>
      HvSeriesOverride(
        layout: layout.clamp(0, layouts - 1),
        direction: direction.clamp(0, directions - 1),
        dualPage: dualPage.clamp(0, dualModes - 1),
        crop: crop,
      );
}
