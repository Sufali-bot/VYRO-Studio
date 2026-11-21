class ExportSettings {
  const ExportSettings({this.resolution = '1080p', this.fps = 30, this.format = 'MP4', this.quality = 'High'});
  final String resolution;
  final int fps;
  final String format;
  final String quality;
}

class ExportService {
  Future<void> export({required String projectId, required ExportSettings settings}) async {
    throw UnimplementedError('Export pipeline is not implemented in this milestone.');
  }
}
