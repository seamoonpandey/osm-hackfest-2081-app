import 'dart:convert';

import 'package:community_connect/constant.dart';
import 'package:community_connect/model/event.dart';
import 'package:community_connect/widgets/event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  List<Event> _events = [];
  Future<void> fetchEvents() async {
    try {
      // Fetch events from the server
      final response =
          await http.get(Uri.parse('$API_URL/listevents'), headers: {
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 10));

      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final List<Event> events =
            responseData.map((dynamic event) => Event.fromJson(event)).toList();

        setState(() {
          _events = events;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch events')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch events')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: EventDialog(event: event),
        );
      },
    );
  }
}
