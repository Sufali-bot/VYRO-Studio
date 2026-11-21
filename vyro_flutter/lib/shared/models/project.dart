enum TrackType { video, audio, text }

class VyroProject {
  VyroProject({
    required this.id,
    required this.name,
    this.aspectRatio = '9:16',
    this.fps = 30,
    this.resolution = '1080p',
    DateTime? createdAt,
    DateTime? updatedAt,
    List<VyroTrack>? tracks,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        tracks = tracks ?? <VyroTrack>[];

  final String id;
  String name;
  String aspectRatio;
  int fps;
  String resolution;
  final DateTime createdAt;
  DateTime updatedAt;
  final List<VyroTrack> tracks;
}

class VyroTrack {
  VyroTrack({required this.id, required this.type, List<VyroClip>? clips})
      : clips = clips ?? <VyroClip>[];
  final String id;
  final TrackType type;
  final List<VyroClip> clips;
}

class VyroClip {
  VyroClip({
    required this.id,
    required this.mediaPath,
    required this.startTimeMs,
    required this.durationMs,
    this.trimStartMs = 0,
    this.trimEndMs = 0,
    this.speed = 1,
    this.volume = 1,
    this.filters = const <String>[],
    this.keyframes = const <Map<String, Object?>>[],
    this.textStyle = const <String, Object?>{},
  });

  final String id;
  String mediaPath;
  int startTimeMs;
  int durationMs;
  int trimStartMs;
  int trimEndMs;
  double speed;
  double volume;
  List<String> filters;
  List<Map<String, Object?>> keyframes;
  Map<String, Object?> textStyle;
}
