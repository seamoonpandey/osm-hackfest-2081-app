import 'package:community_connect/model/event.dart';
import 'package:flutter/material.dart';

class EventDialog extends StatelessWidget {
  final Event event;
  const EventDialog({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(event.title),
          Text(event.startTime.toString()),
          Text(event.endTime.toString()),
        ],
      ),
    );
  }
}
