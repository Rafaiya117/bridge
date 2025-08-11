import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/footer.dart';

class MainTabScaffold extends StatelessWidget {
  final Widget child;

  const MainTabScaffold({required this.child, super.key});

  static final tabs = [
    '/video',
    '/feed',
    '/goal',
    '/guidance',
    '/journal_page',
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final selectedIndex = tabs.indexWhere((path) => currentLocation.startsWith(path));

    return Scaffold(
      body: child,
      bottomNavigationBar: ReusableBottomNavBar(
        icons: [
          Icons.play_circle,
          Icons.list_outlined,
          Icons.checklist_rtl_sharp,
          Icons.person_search_sharp,
          Icons.note_add,
        ],
        selectedIndex: selectedIndex,
        onItemTapped: List.generate(tabs.length, (index) {
          return () => context.go(tabs[index]);
        }),
        iconSize: 30,
        iconColor: Colors.white,
        selectedColor: Colors.teal[900]!,
      ),
    );
  }
}
