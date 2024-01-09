import 'package:back_pack/presentation/screens/navigation_screen/account_screen/account_screen.dart';
import 'package:back_pack/presentation/screens/navigation_screen/explore_screen/explore_screen.dart';
import 'package:back_pack/presentation/screens/navigation_screen/home_screen/home_screen.dart';
import 'package:back_pack/presentation/screens/navigation_screen/meetup_screen/meetup_screen.dart';
import 'package:back_pack/presentation/screens/navigation_screen/prolet_screen/prolet_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTab = 0;

  List<Widget> widgetList = [
    const HomeScreen(),
    const ProletScreen(),
    const MeetupScreen(),
    const ExploreScreen(),
    const AccountScreen(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined), label: "Prolet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.handshake_rounded), label: "Meetup"),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded), label: "About"),
        ],
      ),
    );
  }
}
