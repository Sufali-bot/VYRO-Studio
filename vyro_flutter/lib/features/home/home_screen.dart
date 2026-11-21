import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../editor/editor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final _search = TextEditingController();

  static const _tools = <_ToolItem>[
    _ToolItem('AutoCut', Icons.auto_awesome_motion),
    _ToolItem('Retouch', Icons.face_retouching_natural),
    _ToolItem('AI generator', Icons.auto_awesome),
    _ToolItem('Photo tools', Icons.photo_filter_outlined),
    _ToolItem('Shoot & record', Icons.videocam_outlined),
    _ToolItem('Auto enhance', Icons.wb_sunny_outlined),
    _ToolItem('AI Captions', Icons.closed_caption_outlined),
    _ToolItem('Script to Video', Icons.article_outlined),
    _ToolItem('AI Voice', Icons.record_voice_over_outlined),
    _ToolItem('Background Remover', Icons.person_remove_outlined),
    _ToolItem('Beat Sync', Icons.graphic_eq),
    _ToolItem('Batch Edit', Icons.dynamic_feed_outlined),
    _ToolItem('AI Avatar', Icons face_outlined),
    _ToolItem('Text to Speech', Icons.spatial_audio_off),
    _ToolItem('Voice Clone', Icons.multitrack_audio),
    _ToolItem('Upscale 4K', Icons.hd_outlined),
  ];

  void _openEditor() => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const EditorScreen()),
      );

  void _comingSoon(String name) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name is planned for a future implementation milestone.')),
      );

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 850;
    return Scaffold(
      body: SafeArea(
        child: Row(children: [
          if (wide) _DesktopRail(selected: _navIndex, onSelect: (i) => setState(() => _navIndex = i)),
          Expanded(child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: CustomScrollView(slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
                  sliver: SliverList(delegate: SliverChildListDelegate([
                    Row(children: [
                      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('VYRO STUDIO PRO', style: TextStyle(letterSpacing: 2, color: AppConstants.accentBlue, fontWeight: FontWeight.w900, fontSize: 11)),
                        SizedBox(height: 4), Text('Make every frame count.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
                      ])),
                      if (wide) const _ProPill(),
                      IconButton(onPressed: () => _comingSoon('Notifications'), icon: const Icon(Icons.notifications_none_rounded)),
                    ]),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: 'Search templates, tools, projects',
                        prefixIcon: const Icon(Icons.search),
                        filled: true, fillColor: AppConstants.panel,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                      onSubmitted: (_) => _comingSoon('Search'),
                    ),
                    const SizedBox(height: 18),
                    _startBanner(onTap: _openEditor),
                    const SizedBox(height: 14),
                    Row(children: [
                      Expanded(child: _ActionCard(title: 'New video', subtitle: 'Start editing your clips', icon: Icons.add_rounded, onTap: _openEditor)),
                      const SizedBox(width: 12),
                      Expanded(child: _ActionCard(title: 'Edit photo', subtitle: 'Photo editing workspace', icon: Icons.image_outlined, onTap: () => _comingSoon('Photo editor'))),
                    ]),
                    const SizedBox(height: 26),
                    _sectionHeader('Recent projects', action: 'See all', onAction: () => _comingSoon('Project library')),
                    const SizedBox(height: 12),
                    SizedBox(height: 132, child: ListView(scrollDirection: Axis.horizontal, children: const [
                      _RecentProjectCard(title: 'Your first project', subtitle: 'Create a new video', duration: '--:--', isEmpty: true),
                      _RecentProjectCard(title: 'Project workspace', subtitle: 'Local projects will appear here', duration: '—', isEmpty: true),
                    ])),
                    const SizedBox(height: 26),
                    _sectionHeader('Create with VYRO', action: 'All tools', onAction: () => _comingSoon('All tools')),
                    const SizedBox(height: 12),
                    LayoutBuilder(builder: (context, constraints) {
                      final count = constraints.maxWidth >= 1000 ? 8 : constraints.maxWidth >= 650 ? 4 : 4;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _tools.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: count, mainAxisSpacing: 14, crossAxisSpacing: 8, childAspectRatio: .92,
                        ),
                        itemBuilder: (context, index) => _ToolCard(
                          item: _tools[index],
                          onTap: () => index == 0 ? _openEditor() : _comingSoon(_tools[index].name),
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    _sectionHeader('Explore templates', action: 'Browse', onAction: () => setState(() => _navIndex = 1)),
                    const SizedBox(height: 12),
                    SizedBox(height: 108, child: ListView(scrollDirection: Axis.horizontal, children: const [
                      _TemplateCard(title: 'Trending', icon: Icons.local_fire_department_outlined),
                      _TemplateCard(title: 'Text effects', icon: Icons.title),
                      _TemplateCard(title: 'Transitions', icon: Icons.swap_horiz),
                      _TemplateCard(title: 'Intro & outro', icon: Icons.movie_creation_outlined),
                    ])),
                  ])),
                ),
              ]),
            ),
          )),
        ]),
      ),
      bottomNavigationBar: wide ? null : NavigationBar(
        backgroundColor: AppConstants.panel,
        selectedIndex: _navIndex,
        onDestinationSelected: (i) {
          setState(() => _navIndex = i);
          if (i != 0) _comingSoon(const ['Edit', 'Templates', 'AI Lab', 'Library', 'Me'][i]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.edit_outlined), label: 'Edit'),
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'Templates'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), label: 'AI Lab'),
          NavigationDestination(icon: Icon(Icons.video_library_outlined), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Me'),
        ],
      ),
    );
  }
}

class _ToolItem { const _ToolItem(this.name, this.icon); final String name; final IconData icon; }

class _DesktopRail extends StatelessWidget {
  const _DesktopRail({required this.selected, required this.onSelect});
  final int selected; final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context) => Container(width: 205, color: AppConstants.panel, padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('VYRO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: 2, color: AppConstants.accentBlue)),
    const SizedBox(height: 5), const Text('STUDIO PRO', style: TextStyle(fontSize: 9, letterSpacing: 2, color: AppConstants.textMuted)),
    const SizedBox(height: 34),
    for (var i = 0; i < 6; i++) _RailItem(icon: [Icons.home_outlined, Icons.grid_view, Icons.auto_awesome_outlined, Icons.folder_outlined, Icons.cloud_outlined, Icons.delete_outline][i], label: ['Home', 'Templates', 'AI Lab', 'Projects', 'Cloud', 'Trash'][i], active: selected == i, onTap: () => onSelect(i)),
    const Spacer(), const _ProPill(),
  ]));
}

class _RailItem extends StatelessWidget {
  const _RailItem({required this.icon, required this.label, required this.active, required this.onTap});
  final IconData icon; final String label; final bool active; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 7), child: ListTile(dense: true, onTap: onTap, leading: Icon(icon, color: active ? Colors.white : AppConstants.textMuted), title: Text(label, style: TextStyle(color: active ? Colors.white : AppConstants.textMuted)), selected: active, selectedTileColor: AppConstants.panelRaised, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
}

class _ProPill extends StatelessWidget {
  const _ProPill();
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: const LinearGradient(colors: [Color(0xFF7657FF), Color(0xFF258FFF)])), child: const Text('PRO WORKSPACE', style: TextStyle(fontSize: 9, letterSpacing: 1, fontWeight: FontWeight.w900, color: Colors.white)));
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.title, required this.subtitle, required this.icon, required this.onTap});
  final String title, subtitle; final IconData icon; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(17), child: Container(height: 106, padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: AppConstants.panel, borderRadius: BorderRadius.circular(17), border: Border.all(color: Colors.white10)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(icon, color: AppConstants.accentBlue, size: 25), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)), Text(subtitle, style: const TextStyle(color: AppConstants.textMuted, fontSize: 10))])])));
}

class _RecentProjectCard extends StatelessWidget {
  const _RecentProjectCard({required this.title, required this.subtitle, required this.duration, this.isEmpty = false});
  final String title, subtitle, duration; final bool isEmpty;
  @override
  Widget build(BuildContext context) => Container(width: 158, margin: const EdgeInsets.only(right: 11), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(child: Container(width: double.infinity, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF242A48), Color(0xFF171B29), Color(0xFF39265A)])), child: Stack(children: [Center(child: Icon(isEmpty ? Icons.add_circle_outline : Icons.movie_outlined, color: Colors.white70, size: 28)), Positioned(right: 7, bottom: 7, child: Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: Text(duration, style: const TextStyle(fontSize: 9))))]))),
    const SizedBox(height: 6), Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)), Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppConstants.textMuted, fontSize: 9)),
  ]));
}

class _ToolCard extends StatelessWidget {
  const _ToolCard({required this.item, required this.onTap});
  final _ToolItem item; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(13), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: AppConstants.panel, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white10)), child: Icon(item.icon, color: AppConstants.accentBlue, size: 22)), const SizedBox(height: 7), Text(item.name, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600))]));
}

class _TemplateCard extends StatelessWidget {
  const _TemplateCard({required this.title, required this.icon});
  final String title; final IconData icon;
  @override
  Widget build(BuildContext context) => Container(width: 145, margin: const EdgeInsets.only(right: 10), decoration: BoxDecoration(color: AppConstants.panel, borderRadius: BorderRadius.circular(13), border: Border.all(color: Colors.white10)), padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(icon, color: AppConstants.accent), Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))]));
}

Widget _sectionHeader(String title, {required String action, required VoidCallback onAction}) => Row(children: [Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17))), TextButton(onPressed: onAction, child: Text(action))]);

Widget _startBanner({required VoidCallback onTap}) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(18), child: Container(height: 116, width: double.infinity, padding: const EdgeInsets.all(18), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF6245E8), Color(0xFF287FEA), Color(0xFF172C68)])), child: Row(children: [const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text('VIDEO CREATE', style: TextStyle(fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.w900, color: Colors.white70)), SizedBox(height: 7), Text('Get started', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)), SizedBox(height: 3), Text('Bring your ideas to life with VYRO', style: TextStyle(fontSize: 11, color: Colors.white70))])), Container(width: 55, height: 55, decoration: BoxDecoration(color: Colors.white.withOpacity(.17), shape: BoxShape.circle), child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 34))])));
