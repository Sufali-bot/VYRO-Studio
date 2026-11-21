# VYRO Studio implementation roadmap

1. Generate Flutter platform folders and verify the app on Android and Windows.
2. Add persistent project storage and media picker/import with permissions.
3. Implement timeline state, clip selection, trim, split, delete, duplicate, drag and undo/redo.
4. Add video decoding/playback and synchronized audio preview.
5. Integrate a maintained FFmpeg runtime for supported platforms; verify licensing, codecs and platform support before choosing a package.
6. Implement text, audio, effects, transitions and export settings/progress.
7. Add Firebase authentication/cloud sync only after local-first projects work.
8. Add AI tools through separately configured providers; keep API keys out of the client app.
