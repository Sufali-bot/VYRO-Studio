# VYRO Studio PRO — Flutter product foundation

VYRO Studio PRO is a planned cross-platform video editing product using one shared Flutter/Dart codebase for Android, iOS, Windows and macOS. The UI direction is a familiar, approachable creator workflow on mobile and a denser professional workstation on desktop, with original VYRO branding.

## 0.3.0 milestone included in this package
- Refreshed PRO-branded Home screen with search field, gradient video-create banner, New Video / Edit Photo cards, recent-project placeholders and 16-tool grid.
- Mobile navigation destinations: Edit, Templates, AI Lab, Library and Me.
- Desktop navigation rail: Home, Templates, AI Lab, Projects, Cloud and Trash.
- New Video and AutoCut entry points open the existing editor UI shell.
- Existing shared project models, theme, editor UI shell and service boundaries retained.

## Run locally
Install Flutter stable and the platform build prerequisites, then run from this directory:

```bash
flutter create . --platforms=android,ios,windows,macos
flutter pub get
flutter analyze
flutter test
flutter run -d <device-id>
```

Windows desktop builds require Visual Studio with the Desktop development with C++ workload. iOS/macOS builds require macOS and Xcode. Use `flutter devices` to list available devices.

## Implementation status — be clear about what works
| Area | Current status |
|---|---|
| Flutter app shell and VYRO dark theme | Implemented in source; not built in this environment |
| PRO Home screen layout and navigation UI | Implemented; secondary destinations are placeholders |
| New Video navigation to editor shell | Implemented |
| Editor preview/timeline | Visual UI shell only; no real media playback |
| Project / Track / Clip models | Initial in-memory data model only |
| Media import, decoding and playback | Not implemented |
| Real timeline editing (trim, split, ripple, keyframes) | Not implemented |
| FFmpeg export / GPU rendering | Not implemented; service boundaries only |
| Whisper captions, voice, background removal, AI tools | Not implemented; require provider integration, credentials and service design |
| Firebase / Supabase auth, cloud sync, collaboration, 1 TB storage | Not implemented; requires project configuration, security rules, backend and paid infrastructure |
| Templates, marketplace, stock library, photo editor | UI entry points only; not implemented |
| Automated tests and platform builds | Not run; Flutter SDK is not available in the build environment used to prepare this archive |

## Delivery and quality policy
This is a source milestone, not a finished CapCut replacement. Do not advertise listed roadmap features as available until implemented and tested. A zero-bug guarantee is not technically possible; each milestone should be analyzed, tested on target devices, and fixed before proceeding. Keep a backup branch of the previous React/Tauri source until this Flutter app builds successfully on the user's machine.

## Architecture direction
- Shared Flutter UI and Dart domain logic.
- Platform-specific media/rendering adapters behind service interfaces.
- FFmpeg for supported media operations; GPU preview/rendering requires platform-specific implementation and performance testing.
- Firebase and/or Supabase should be introduced deliberately rather than duplicating auth and data responsibilities. Decide one system of record for users/projects and define storage ownership before enabling cloud sync.
- AI providers must be called through secure backend functions; never embed secret API keys in the mobile or desktop client.
