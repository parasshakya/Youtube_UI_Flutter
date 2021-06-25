import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtubeuiflutter/screens/ImportScreens.dart';

import '../data.dart';

class NavScreen extends StatefulWidget {
  final selectedVideoProvider = StateProvider<Video?>((ref) => null);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final _screens = [
    HomeScreen(),
    const Scaffold(body: Center(child: Text('Explore'),),),
    const Scaffold(body: Center(child: Text('Add'),),),
    const Scaffold(body: Center(child: Text('Subscriptions'),),),
    const Scaffold(body: Center(child: Text('Library'),),),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:
          _screens.asMap().map((i,screen) => MapEntry(i, Offstage(
            child: screen,
            offstage: _selectedIndex != i,
          ))).values.toList(),

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
         currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        unselectedFontSize: 10.0,
        selectedFontSize: 10.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Add'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: 'Subscriptions'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: 'Library'
          )
        ],
      ),
    );
  }
}
