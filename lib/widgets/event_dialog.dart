import 'package:community_connect/model/event.dart';
import 'package:community_connect/pages/event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package

class EventDialog extends StatelessWidget {
  final Event event;
  const EventDialog({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EventDetails(event: event)),
        );
      },
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              border: Border.all(color: Colors.grey[200] ?? Colors.grey)),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start Time: ${formatTime(event.startTime)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'End Time: ${formatTime(event.endTime)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTime(DateTime time) {
  // Use intl to format time
  return DateFormat('hh:mm a').format(time); // Example: 10:00 AM
}
