import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';

const _bg = Color(0xFF08090D);
const _panel = Color(0xFF141620);
const _panel2 = Color(0xFF1B1E2A);
const _purple = Color(0xFF795BFF);
const _blue = Color(0xFF329BFF);
const _muted = Color(0xFF9298AA);

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int _tab = 0;
  int _selectedTrack = 0;
  double _zoom = 0.45;
  bool _playing = false;
  bool _clipSelected = false;
  final List<String> _tabs = ['Media', 'Effects', 'Text', 'Smart', 'Adjust'];
  final List<IconData> _icons = [Icons.video_library_outlined, Icons.auto_awesome, Icons.title, Icons.bolt, Icons.tune];

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          _topBar(),
          Expanded(
            child: wide
                ? Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Expanded(child: _editorMain()),
                    SizedBox(width: 310, child: _sidePanel()),
                  ])
                : _editorMain(),
          ),
          if (!wide) _bottomTools(),
          if (_clipSelected) _clipAdjustments(),
        ]),
      ),
    );
  }

  Widget _topBar() => Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 10),
        child: Row(children: [
          const Icon(Icons.arrow_back_ios_new, size: 18),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Untitled project', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            SizedBox(height: 2), Text('1080 × 1920  •  9:16  •  30 FPS', style: TextStyle(color: _muted, fontSize: 10)),
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, size: 20)),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: _purple, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10)),
            onPressed: () => _showMessage('Export is the next development milestone.'),
            icon: const Icon(Icons.file_upload_outlined, size: 16),
            label: const Text('Export', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ]),
      );

  Widget _editorMain() => Column(children: [
        Expanded(flex: 48, child: _preview()),
        _transport(),
        Expanded(flex: 52, child: _timeline()),
      ]);

  Widget _preview() => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(color: const Color(0xFF020307), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white10)),
        child: LayoutBuilder(builder: (context, c) {
          final maxH = c.maxHeight - 18;
          final h = maxH.clamp(100.0, 420.0).toDouble();
          return Center(
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                constraints: BoxConstraints(maxHeight: h, maxWidth: c.maxWidth - 22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF262C4C), Color(0xFF111827), Color(0xFF3A225A)]),
                ),
                child: Stack(children: [
                  Positioned.fill(child: CustomPaint(painter: _PreviewGlowPainter())),
                  const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.movie_creation_outlined, size: 34, color: Colors.white70),
                    SizedBox(height: 8), Text('VYRO PREVIEW', style: TextStyle(letterSpacing: 2, fontSize: 10, color: Colors.white70, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5), Text('Import media to begin', style: TextStyle(fontSize: 9, color: Colors.white54)),
                  ])),
                  const Positioned(left: 8, top: 8, child: _Pill(text: '9:16')),
                ]),
              ),
            ),
          );
        }),
      );

  Widget _transport() => Padding(
        padding: const EdgeInsets.fromLTRB(18, 9, 18, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _transportButton(Icons.undo_rounded, () {}),
          _transportButton(Icons.skip_previous_rounded, () {}),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_purple, _blue])),
            child: IconButton(onPressed: () => setState(() => _playing = !_playing), icon: Icon(_playing ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 28), color: Colors.white),
          ),
          const SizedBox(width: 8),
          _transportButton(Icons.skip_next_rounded, () {}),
          _transportButton(Icons.redo_rounded, () {}),
        ]),
      );

  Widget _transportButton(IconData icon, VoidCallback onTap) => IconButton(onPressed: onTap, visualDensity: VisualDensity.compact, icon: Icon(icon, size: 21, color: Colors.white70));

  Widget _timeline() => Container(
        decoration: const BoxDecoration(color: _panel, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(children: [
          Row(children: [
            const Text('00:00:09:07', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures])),
            const Text('  /  00:02:01:02', style: TextStyle(fontSize: 11, color: _muted)),
            const Spacer(),
            IconButton(onPressed: () => setState(() => _zoom = (_zoom - .1).clamp(0.0, 1.0).toDouble()), icon: const Icon(Icons.remove_circle_outline, size: 18), visualDensity: VisualDensity.compact),
            SizedBox(width: 92, child: Slider(value: _zoom, onChanged: (v) => setState(() => _zoom = v), activeColor: _purple)),
            IconButton(onPressed: () => setState(() => _zoom = (_zoom + .1).clamp(0.0, 1.0).toDouble()), icon: const Icon(Icons.add_circle_outline, size: 18), visualDensity: VisualDensity.compact),
          ]),
          const SizedBox(height: 5),
          Expanded(child: Stack(children: [
            Column(children: [
              _track('V', 'Video', _selectedTrack == 0, () => setState(() { _selectedTrack = 0; _clipSelected = true; }), _videoClip()),
              _track('T', 'Text', _selectedTrack == 1, () => setState(() { _selectedTrack = 1; _clipSelected = false; }), _emptyTrack('Add text from the Text tab')),
              _track('A', 'Audio', _selectedTrack == 2, () => setState(() { _selectedTrack = 2; _clipSelected = false; }), _emptyTrack('Drag music or voiceover here')),
            ]),
            Positioned(left: 92 + (MediaQuery.sizeOf(context).width - 120) * .34, top: 0, bottom: 0, child: Container(width: 2, decoration: BoxDecoration(color: const Color(0xFFFF4F68), boxShadow: [BoxShadow(color: Colors.red.withOpacity(.35), blurRadius: 6)]))),
          ])),
        ]),
      );

  Widget _track(String letter, String label, bool selected, VoidCallback onTap, Widget content) => SizedBox(
        height: 66,
        child: Row(children: [
          SizedBox(width: 78, child: InkWell(onTap: onTap, child: Row(children: [
            Container(width: 23, height: 23, alignment: Alignment.center, decoration: BoxDecoration(color: selected ? _purple.withOpacity(.25) : _panel2, borderRadius: BorderRadius.circular(6)), child: Text(letter, style: TextStyle(fontWeight: FontWeight.bold, color: selected ? Colors.white : _muted, fontSize: 11))),
            const SizedBox(width: 6), Expanded(child: Text(label, style: const TextStyle(fontSize: 10, color: _muted), overflow: TextOverflow.ellipsis)),
          ]))),
          Expanded(child: InkWell(onTap: onTap, child: content)),
        ]),
      );

  Widget _videoClip() => Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), border: Border.all(color: selectedBorder(), width: 1.2), gradient: const LinearGradient(colors: [Color(0xFF28365A), Color(0xFF514078), Color(0xFF253D5D)])),
        child: Row(children: List.generate(5, (i) => Expanded(child: Container(margin: const EdgeInsets.all(2), decoration: BoxDecoration(color: [const Color(0xFF53688B), const Color(0xFF80639D), const Color(0xFF455D78), const Color(0xFF6D7399), const Color(0xFF4B5E83)][i], borderRadius: BorderRadius.circular(3)), child: const Icon(Icons.landscape_outlined, size: 15, color: Colors.white54))))),
      );

  Color selectedBorder() => _selectedTrack == 0 ? _blue : Colors.white24;
  Widget _emptyTrack(String text) => Container(margin: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: const Color(0xFF10131C), borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.white10)), alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(text, style: const TextStyle(fontSize: 10, color: Color(0xFF687084))));

  Widget _bottomTools() => Container(
        height: 76,
        decoration: const BoxDecoration(color: _panel, border: Border(top: BorderSide(color: Colors.white10))),
        child: Row(children: List.generate(_tabs.length, (i) => Expanded(child: InkWell(onTap: () => setState(() => _tab = i), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(_icons[i], size: 21, color: _tab == i ? _blue : _muted),
          const SizedBox(height: 5), Text(_tabs[i], style: TextStyle(fontSize: 10, color: _tab == i ? Colors.white : _muted, fontWeight: _tab == i ? FontWeight.bold : FontWeight.normal)),
        ]))))),
      );

  Widget _sidePanel() => Container(color: _panel, padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('TOOLS', style: TextStyle(color: _muted, fontSize: 10, letterSpacing: 1.4, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _toolGrid(),
        const Spacer(),
        _clipPanelContent(),
      ]));

  Widget _toolGrid() => Wrap(spacing: 8, runSpacing: 8, children: List.generate(_tabs.length, (i) => ActionChip(avatar: Icon(_icons[i], size: 16, color: _blue), label: Text(_tabs[i]), onPressed: () => setState(() => _tab = i), backgroundColor: _panel2, labelStyle: const TextStyle(fontSize: 11))));

  Widget _clipPanelContent() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(color: Colors.white12),
        const Text('CLIP ADJUSTMENTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 10),
        Wrap(spacing: 6, runSpacing: 6, children: ['Trim', 'Split', 'Delete', 'Duplicate', 'Copy', 'Crop', 'Rotate', 'Flip'].map((e) => _smallAction(e)).toList()),
        const SizedBox(height: 12),
        const Text('Speed', style: TextStyle(color: _muted, fontSize: 10)),
        const Text('1.0×', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        Slider(value: 1, min: .5, max: 2, onChanged: (_) {}, activeColor: _purple),
        const Text('Volume', style: TextStyle(color: _muted, fontSize: 10)),
        Slider(value: .8, onChanged: (_) {}, activeColor: _blue),
      ]);

  Widget _smallAction(String text) => ActionChip(label: Text(text, style: const TextStyle(fontSize: 10)), onPressed: () => _showMessage('$text will be wired in the timeline milestone.'), backgroundColor: _panel2, side: BorderSide.none, padding: EdgeInsets.zero, visualDensity: VisualDensity.compact);

  Widget _clipAdjustments() => Container(color: _panel, padding: const EdgeInsets.fromLTRB(14, 10, 14, 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Text('CLIP ADJUSTMENTS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const Spacer(), IconButton(onPressed: () => setState(() => _clipSelected = false), icon: const Icon(Icons.close, size: 18), visualDensity: VisualDensity.compact)]),
        Wrap(spacing: 6, runSpacing: 4, children: ['Trim', 'Split', 'Delete', 'Duplicate', 'Copy', 'Crop', 'Rotate', 'Flip'].map(_smallAction).toList()),
        Row(children: [const Text('Speed', style: TextStyle(fontSize: 10, color: _muted)), Expanded(child: Slider(value: 1, min: .5, max: 2, onChanged: (_) {})), const Text('1.0×', style: TextStyle(fontSize: 11))]),
      ]));

  void _showMessage(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(5)), child: Text(text, style: const TextStyle(fontSize: 9, color: Colors.white70)));
}

class _PreviewGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..shader = const RadialGradient(colors: [Color(0x557B61FF), Colors.transparent]).createShader(Rect.fromCircle(center: Offset(size.width * .5, size.height * .42), radius: size.width * .7));
    canvas.drawRect(Offset.zero & size, p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
