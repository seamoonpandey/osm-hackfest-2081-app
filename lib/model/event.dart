class Event {
  final int id;
  final double lat;
  final double lng;
  final DateTime startTime;
  final DateTime endTime;
  final String title;

  Event({
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
      lat: json['lat'],
      lng: json['lng'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      title: json['title'],
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
