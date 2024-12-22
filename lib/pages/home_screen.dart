import 'dart:convert';

import 'package:community_connect/model/event.dart';
import 'package:community_connect/pages/events_screen.dart';
import 'package:community_connect/pages/leaderboard_screen.dart';
import 'package:community_connect/pages/profile_screen.dart';
import 'package:community_connect/widgets/form.dart';
import 'package:community_connect/widgets/map_widget.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      FutureBuilder<List<Event>>(
        future: fetchEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events available'));
          } else {
            return MapWidget(events: snapshot.data!);
          }
        },
      ),
      // Add your other pages here
      const EventsScreen(),
      const LeaderboardScreen(),
      const ProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/listevents'), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData
            .map((dynamic event) => Event.fromJson(event))
            .toList();
      } else {
        throw Exception('Failed to fetch events');
      }
    } catch (e) {
      throw Exception('Failed to fetch events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      appBar: _currentIndex != 3
          ? AppBar(
              backgroundColor: Colors.white,
              title: [
                const Text('Community Connect'),
                const Text('Events'),
                const Text('Local Leaderboard'),
                null,
              ][_currentIndex],
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EventForm(),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
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
