import 'dart:convert';

import 'package:community_connect/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

// {
//   "title": "Sample Event",
//   "longitude": 77.5946,
//   "latitude": 12.9716,
//   "description": "A sample event happening tonight!",
//   "startTime": "2024-12-22T23:00:00",
//   "endTime": "2024-12-23T01:00:00"
// }
class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  Future<void> createEvent() async {
    final title = _titleController.text;
    final longitude = double.parse(_longitudeController.text);
    final latitude = double.parse(_latitudeController.text);
    final description = _descriptionController.text;
    final startTime = DateTime.parse(_startTimeController.text);
    final endTime = DateTime.parse(_endTimeController.text);

    final event = {
      'title': title,
      'longitude': longitude,
      'latitude': latitude,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };

    try {
      final pref = await SharedPreferences.getInstance();

      // Get the token from shared preferences
      final token = pref.getString('token');
      // Make a POST request to the API
      await http.post(Uri.parse('http://localhost:3000/events'),
          body: jsonEncode(event),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event created successfully')),
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create event')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 300,
                child: MapWidget(
                  onLocationSelected: (p0) {
                    _longitudeController.text = p0.longitude.toString();
                    _latitudeController.text = p0.latitude.toString();
                  },
                ),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startTimeController,
                decoration: const InputDecoration(labelText: 'Start Time'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endTimeController,
                decoration: const InputDecoration(labelText: 'End Time'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an end time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Title: ${_titleController.text}');
                    debugPrint('Longitude: ${_longitudeController.text}');
                    debugPrint('Latitude: ${_latitudeController.text}');
                    debugPrint('Description: ${_descriptionController.text}');
                    debugPrint('Start Time: ${_startTimeController.text}');
                    debugPrint('End Time: ${_endTimeController.text}');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
