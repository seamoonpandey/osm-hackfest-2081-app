import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:community_connect/model/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventDetails extends StatefulWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String? _locationAddress;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _participate() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final response = await http.post(
          Uri.parse('http://localhost:3000/participate'),
          body: jsonEncode({'eventId': widget.event.id}),
          headers: {
            'Authorization': 'Bearer ${pref.getString('token')}',
            'Content-Type': 'application/json',
          }).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        _showParticipationDialog('Participation successful!');
        final count = pref.getInt('stats_participated') ?? 0;
        final int newCount = count + 1;
        await pref.setInt('stats_participated', newCount);
      } else {
        _showParticipationDialog('Failed to participate');
      }
    } catch (error) {
      _showParticipationDialog('Error participating in event: $error');
    }
  }

  Future<void> _fetchAddress() async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${widget.event.lat}&lon=${widget.event.lng}&zoom=18&addressdetails=1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _locationAddress = data['display_name'] ?? 'Address not found';
          _isLoading = false;
        });
      } else {
        setState(() {
          _locationAddress = 'Failed to fetch address';
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _locationAddress = 'Error fetching address';
        _isLoading = false;
      });
    }
  }

  void _showParticipationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: _isLoading
                      ? const Text('Fetching address...')
                      : Text(
                          _locationAddress ?? 'Address not available',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Start: ${formatTime(widget.event.startTime)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time_filled, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'End: ${formatTime(widget.event.endTime)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: _participate,
          child: const Text('Participate'),
        ),
      ),
    );
  }
}

String formatTime(DateTime dateTime) {
  return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
}
