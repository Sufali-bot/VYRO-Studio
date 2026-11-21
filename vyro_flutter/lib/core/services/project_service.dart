import '../../shared/models/project.dart';

class ProjectService {
  final List<VyroProject> _projects = <VyroProject>[];

  List<VyroProject> get projects => List.unmodifiable(_projects);

  VyroProject createProject(String name) {
    final now = DateTime.now();
    final project = VyroProject(
      id: 'vyro-${now.microsecondsSinceEpoch}',
      name: name.trim().isEmpty ? 'Untitled project' : name.trim(),
      tracks: <VyroTrack>[
        VyroTrack(id: 'video-1', type: TrackType.video),
        VyroTrack(id: 'text-1', type: TrackType.text),
        VyroTrack(id: 'audio-1', type: TrackType.audio),
      ],
    );
    _projects.insert(0, project);
    return project;
  }
}
