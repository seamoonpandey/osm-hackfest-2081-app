import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:community_connect/model/event.dart';
import 'package:community_connect/widgets/event_dialog.dart';

class MapWidget extends StatefulWidget {
  final List<Event> events;

  const MapWidget({this.events = const [], super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng point = const LatLng(28.2096, 83.9856); // Current location
  final _mapController = MapController();
  Event? selectedEvent;
  double currentZoom = 13.0; // Initial zoom level
  final double labelZoomThreshold = 13; // Minimum zoom to show labels

  List<LatLng> routePoints = []; // List of points for the route polyline

  void navigateToEvent(Event event) {
    // Calculate the center point between the current location and event location
    final LatLng eventLocation = LatLng(event.lat, event.lng);
    final LatLngBounds bounds = LatLngBounds.fromPoints([point, eventLocation]);

    // Set the route points
    setState(() {
      routePoints = [point, eventLocation];
    });

    // Manually calculate the center and use the stored zoom level
    final center = bounds.center;
    _mapController.move(center, currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    final markerSize = (currentZoom / 13.0) * 30.0;
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: point, // Center the map on the initial point
            initialZoom: currentZoom, // Use the initial zoom level
            onTap: (_, __) {
              // Clear selected event and route when tapping on the map
              setState(() {
                selectedEvent = null;
                routePoints = [];
              });
            },
            onPositionChanged: (position, hasGesture) {
              // Listen for zoom level changes
              if (position.zoom != currentZoom) {
                setState(() {
                  currentZoom = position.zoom;
                });
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            // Add PolylineLayer to show the route
            if (routePoints.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: Colors.blue,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
            MarkerLayer(markers: [
              Marker(
                point: point,
                width: markerSize,
                height: markerSize,
                child: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                ),
              ),
              ...widget.events.map((event) {
                final double distanceInMeters = const Distance().as(
                  LengthUnit.Kilometer,
                  point,
                  LatLng(event.lat, event.lng),
                );
                return Marker(
                  point: LatLng(event.lat, event.lng),
                  width: 3 * markerSize,
                  height: 3 * markerSize,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedEvent = event; // Show popup for the event
                      });
                      navigateToEvent(event); // Navigate to the event
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (currentZoom >= labelZoomThreshold)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${distanceInMeters.toStringAsFixed(1)} km', // Display distance
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 4),
                        Icon(
                          Icons.location_pin,
                          size: markerSize,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              })
            ]),
          ],
        ),
        if (selectedEvent != null)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: EventDialog(event: selectedEvent!),
          ),
      ],
    );
  }
}
