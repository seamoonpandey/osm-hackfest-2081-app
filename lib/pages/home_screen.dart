import 'package:community_connect/data/dummy_events.dart';
import 'package:community_connect/widgets/map_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        events: events,
      ),
    );
  }
}
