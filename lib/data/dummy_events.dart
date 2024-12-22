import 'package:community_connect/model/event.dart';

final data = [
  {
    "id": "4dca180c-394a-41aa-9ea1-2c85505d44e8",
    "title": "Pokhara samaj volleyball",
    "description": "Idk something shit happens here",
    "longitude": -28.18033,
    "latitude": 61.23529,
    "location": "0101000020E6100000D97C5C1B2A2E3CC0B58993FB1D9E4E40",
    "start_time": "2024-12-25T10:00:00+00:00",
    "end_time": "2024-12-25T12:00:00+00:00",
    "event_token": "9b1919506785355afb6c93874681b5ed",
    "host_id": "6aa2180a-a1db-4d46-b454-3c46093ba3e5",
    "created_at": "2024-12-22T17:54:28.700932+00:00"
  },
  {
    "id": "6cb3b514-e68f-47ac-83ce-19b4522487fe",
    "title": "Pokhara samaj volleyball",
    "description": "Idk something shit happens here",
    "longitude": -28.18033,
    "latitude": 61.23529,
    "location": "0101000020E6100000D97C5C1B2A2E3CC0B58993FB1D9E4E40",
    "start_time": "2024-12-25T10:00:00+00:00",
    "end_time": "2024-12-25T12:00:00+00:00",
    "event_token": "2e59dc1aa88f081408a6b01164da7846",
    "host_id": "6aa2180a-a1db-4d46-b454-3c46093ba3e5",
    "created_at": "2024-12-22T17:57:50.557654+00:00"
  },
  {
    "id": "a40ac95a-7718-4c58-8149-403dc7f42d81",
    "title": "Pokhara samaj volleyball",
    "description": "Idk something shit happens here",
    "longitude": 28.18033,
    "latitude": -61.23529,
    "location": "0101000020E6100000D97C5C1B2A2E3C40B58993FB1D9E4EC0",
    "start_time": "2024-12-25T10:00:00+00:00",
    "end_time": "2024-12-25T12:00:00+00:00",
    "event_token": "00fe0d102c8655b19e7615ed2a2849ec",
    "host_id": "6aa2180a-a1db-4d46-b454-3c46093ba3e5",
    "created_at": "2024-12-22T18:00:12.716235+00:00"
  },
  {
    "id": "0f702e27-bdda-41f8-9403-05b5fd8fa80c",
    "title": "Sample Event",
    "description": "A sample event happening tonight!",
    "longitude": 77.5946,
    "latitude": 12.9716,
    "location": "0101000020E6100000E78C28ED0D6653405396218E75F12940",
    "start_time": "2024-12-22T23:00:00+00:00",
    "end_time": "2024-12-23T01:00:00+00:00",
    "event_token": "03c4f558449f179409a73450eda16715",
    "host_id": "6aa2180a-a1db-4d46-b454-3c46093ba3e5",
    "created_at": "2024-12-22T18:06:55.206829+00:00"
  }
];
final dummyevents = data.map((json) => Event.fromJson(json)).toList();
