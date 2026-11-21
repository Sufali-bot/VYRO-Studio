/// Local/cloud persistence boundary. The first milestone keeps project state
/// in memory; filesystem and Firebase adapters will be added separately.
abstract class StorageService {
  Future<void> saveProject(Map<String, Object?> project);
  Future<Map<String, Object?>?> loadProject(String projectId);
  Future<void> deleteProject(String projectId);
}
