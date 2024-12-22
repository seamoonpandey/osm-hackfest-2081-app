class Event {
  final String id;
  final double lat;
  final double lng;
  final DateTime startTime;
  final DateTime endTime;
  final String title;
  final String eventToken;

  Event({
    required this.eventToken,
    required this.id,
    required this.lat,
    required this.lng,
    required this.startTime,
    required this.endTime,
    required this.title,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      lat: json['latitude'],
      lng: json['longitude'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      title: json['title'],
      eventToken: json['event_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'title': title,
    };
  }
}
