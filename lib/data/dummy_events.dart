import 'package:community_connect/model/event.dart';

final data = [
  {
    "id": 1,
    "lat": 27.7172,
    "lng": 85.3240,
    "start_time": "2023-10-01T08:00:00Z",
    "end_time": "2023-10-01T10:00:00Z",
    "title": "Kathmandu Cleanup"
  },
  {
    "id": 2,
    "lat": 27.6870,
    "lng": 85.3162,
    "start_time": "2023-10-02T09:00:00Z",
    "end_time": "2023-10-02T11:00:00Z",
    "title": "Lalitpur Food Drive"
  },
  {
    "id": 3,
    "lat": 27.6710,
    "lng": 85.4298,
    "start_time": "2023-10-03T10:00:00Z",
    "end_time": "2023-10-03T12:00:00Z",
    "title": "Bhaktapur Charity Run"
  },
  {
    "id": 4,
    "lat": 28.2096,
    "lng": 83.9856,
    "start_time": "2023-10-04T11:00:00Z",
    "end_time": "2023-10-04T13:00:00Z",
    "title": "Pokhara Community Gathering"
  },
  {
    "id": 5,
    "lat": 28.2639,
    "lng": 83.9721,
    "start_time": "2023-10-05T12:00:00Z",
    "end_time": "2023-10-05T14:00:00Z",
    "title": "Pokhara Art Exhibition"
  },
  {
    "id": 6,
    "lat": 27.5330,
    "lng": 84.3542,
    "start_time": "2023-10-06T13:00:00Z",
    "end_time": "2023-10-06T15:00:00Z",
    "title": "Chitwan Tech Meetup"
  },
  {
    "id": 7,
    "lat": 27.6189,
    "lng": 85.5379,
    "start_time": "2023-10-07T14:00:00Z",
    "end_time": "2023-10-07T16:00:00Z",
    "title": "Dhulikhel Beach Cleanup"
  },
  {
    "id": 8,
    "lat": 27.6820,
    "lng": 85.2814,
    "start_time": "2023-10-08T15:00:00Z",
    "end_time": "2023-10-08T17:00:00Z",
    "title": "Patan Cultural Festival"
  },
  {
    "id": 9,
    "lat": 27.6105,
    "lng": 85.2803,
    "start_time": "2023-10-09T16:00:00Z",
    "end_time": "2023-10-09T18:00:00Z",
    "title": "Kirtipur Historical Tour"
  },
  {
    "id": 10,
    "lat": 27.6740,
    "lng": 85.4298,
    "start_time": "2023-10-10T17:00:00Z",
    "end_time": "2023-10-10T19:00:00Z",
    "title": "Bhaktapur Music Festival"
  },
  {
    "id": 11,
    "lat": 27.5700,
    "lng": 84.5000,
    "start_time": "2023-10-11T08:00:00Z",
    "end_time": "2023-10-11T10:00:00Z",
    "title": "Bharatpur Cleanup"
  },
  {
    "id": 12,
    "lat": 27.5330,
    "lng": 84.3542,
    "start_time": "2023-10-12T09:00:00Z",
    "end_time": "2023-10-12T11:00:00Z",
    "title": "Chitwan Food Drive"
  },
  {
    "id": 13,
    "lat": 27.7000,
    "lng": 85.3333,
    "start_time": "2023-10-13T10:00:00Z",
    "end_time": "2023-10-13T12:00:00Z",
    "title": "Kathmandu Charity Run"
  },
  {
    "id": 14,
    "lat": 27.6667,
    "lng": 85.3333,
    "start_time": "2023-10-14T11:00:00Z",
    "end_time": "2023-10-14T13:00:00Z",
    "title": "Lalitpur Community Gathering"
  },
  {
    "id": 15,
    "lat": 27.6833,
    "lng": 85.4167,
    "start_time": "2023-10-15T12:00:00Z",
    "end_time": "2023-10-15T14:00:00Z",
    "title": "Bhaktapur Art Exhibition"
  },
  {
    "id": 16,
    "lat": 28.2000,
    "lng": 83.9833,
    "start_time": "2023-10-16T13:00:00Z",
    "end_time": "2023-10-16T15:00:00Z",
    "title": "Pokhara Tech Meetup"
  },
  {
    "id": 17,
    "lat": 27.6167,
    "lng": 85.5333,
    "start_time": "2023-10-17T14:00:00Z",
    "end_time": "2023-10-17T16:00:00Z",
    "title": "Dhulikhel Beach Cleanup"
  },
  {
    "id": 18,
    "lat": 27.6667,
    "lng": 85.3000,
    "start_time": "2023-10-18T15:00:00Z",
    "end_time": "2023-10-18T17:00:00Z",
    "title": "Patan Cultural Festival"
  },
  {
    "id": 19,
    "lat": 27.6000,
    "lng": 85.3000,
    "start_time": "2023-10-19T16:00:00Z",
    "end_time": "2023-10-19T18:00:00Z",
    "title": "Kirtipur Historical Tour"
  },
  {
    "id": 20,
    "lat": 27.7000,
    "lng": 85.4000,
    "start_time": "2023-10-20T17:00:00Z",
    "end_time": "2023-10-20T19:00:00Z",
    "title": "Bhaktapur Music Festival"
  },
  {
    "id": 21,
    "lat": 27.5330,
    "lng": 84.5000,
    "start_time": "2023-10-21T08:00:00Z",
    "end_time": "2023-10-21T10:00:00Z",
    "title": "Bharatpur Cleanup"
  },
  {
    "id": 22,
    "lat": 27.5330,
    "lng": 84.3542,
    "start_time": "2023-10-22T09:00:00Z",
    "end_time": "2023-10-22T11:00:00Z",
    "title": "Chitwan Food Drive"
  },
  {
    "id": 23,
    "lat": 27.7000,
    "lng": 85.3333,
    "start_time": "2023-10-23T10:00:00Z",
    "end_time": "2023-10-23T12:00:00Z",
    "title": "Kathmandu Charity Run"
  },
  {
    "id": 24,
    "lat": 27.6667,
    "lng": 85.3333,
    "start_time": "2023-10-24T11:00:00Z",
    "end_time": "2023-10-24T13:00:00Z",
    "title": "Lalitpur Community Gathering"
  },
  {
    "id": 25,
    "lat": 27.6833,
    "lng": 85.4167,
    "start_time": "2023-10-25T12:00:00Z",
    "end_time": "2023-10-25T14:00:00Z",
    "title": "Bhaktapur Art Exhibition"
  },
];

final events = data.map((json) => Event.fromJson(json)).toList();
