/// Identity of a library entry across HV tables: media type + AnymeX media id.
///
/// The media id alone is not unique: an AniList id can be both an anime and a
/// manga id, so the type index (bridge `ItemType.index`) is part of the key.
String hvMediaKey(int mediaTypeIndex, String mediaId) =>
    '$mediaTypeIndex|$mediaId';

/// Tracker ids (AniList/MAL/Simkl) are numeric; entries added straight from an
/// extension use the source's URL or path as their id.
bool hvIsExtensionKeyed(String mediaId) => !RegExp(r'^\d+$').hasMatch(mediaId);
