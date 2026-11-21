/// FFmpeg integration boundary.
///
/// The concrete native FFmpeg adapter is intentionally not wired yet. Choose
/// and validate a maintained FFmpeg package per target before implementing it.
class FfmpegService {
  Future<void> ensureAvailable() async {
    throw UnimplementedError('FFmpeg runtime is not configured in this milestone.');
  }

  Future<String> exportProject({required String projectId, required String outputPath}) async {
    throw UnimplementedError('Project rendering is not implemented yet.');
  }
}
