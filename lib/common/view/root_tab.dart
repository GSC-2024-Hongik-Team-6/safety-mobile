import 'package:flutter/material.dart';
import 'package:safetyedu/common/const/colors.dart';
import 'package:safetyedu/user/view/profile_screen.dart';

class TabView extends StatefulWidget {
  static const routeName = 'root_tab';

  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  late TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _navItems.length, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _index = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
        ),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _tabController.animateTo(index);
        },
        currentIndex: _index,
        items: _navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(
              _index == item.index ? item.activeIcon : item.inactiveIcon,
            ),
            label: item.label,
          );
        }).toList(),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          Center(child: Text('홈페이지')),
          ProfileScreen(),
        ],
      ),
    );
  }
}

class NavItem {
  final int index;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;

  const NavItem({
    required this.index,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

const _navItems = [
  NavItem(
    index: 0,
    activeIcon: Icons.home,
    inactiveIcon: Icons.home_outlined,
    label: '홈',
  ),
  NavItem(
    index: 1,
    activeIcon: Icons.person,
    inactiveIcon: Icons.person_outline,
    label: 'My',
  ),
];
