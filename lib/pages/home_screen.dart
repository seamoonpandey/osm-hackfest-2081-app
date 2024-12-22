import 'package:community_connect/data/dummy_events.dart';
import 'package:community_connect/widgets/map_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MapWidget(events: events),
    // Add your other pages here
    const Center(child: Text('Events Page')),
    const Center(child: Text('Leaderboard Page')),
    const Center(child: Text('Profile Page')),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, color: Colors.green),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard, color: Colors.orange),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.purple),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
