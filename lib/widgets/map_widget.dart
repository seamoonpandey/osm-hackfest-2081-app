import 'package:community_connect/model/event.dart';
import 'package:community_connect/widgets/event_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final List<Event> events;
  const MapWidget({this.events = const [], super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng point = const LatLng(28.2096, 83.9856);
  final _mapController = MapController();
  Event? selectedEvent;
  double currentZoom = 13.0; // Initial zoom level
  final double labelZoomThreshold = 15.0; // Minimum zoom to show labels

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: point, // Center the map on the initial point
            initialZoom: currentZoom, // Use the initial zoom level
            onTap: (_, __) {
              // Clear selected event when tapping on the map
              setState(() {
                selectedEvent = null;
              });
            },
            onPositionChanged: (MapCamera position, bool hasGesture) {
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
            MarkerLayer(
              markers: [
                ...widget.events.map((event) {
                  return Marker(
                    width: 140.0,
                    height: 140.0,
                    point: LatLng(event.lat, event.lng),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEvent = event; // Show popup for the event
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Only show the label if zoom is sufficient
                          if (currentZoom >= labelZoomThreshold)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          const SizedBox(height: 4),
                          const Icon(
                            Icons.location_pin,
                            size: 30,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
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
