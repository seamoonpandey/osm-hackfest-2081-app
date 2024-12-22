import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:community_connect/model/event.dart';
import 'package:community_connect/widgets/event_dialog.dart';

class MapWidget extends StatefulWidget {
  final List<Event> events;
  final void Function(LatLng)? onLocationSelected;

  const MapWidget({this.onLocationSelected, this.events = const [], super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng point = const LatLng(28.2096, 83.9856); // Default location
  final _mapController = MapController();
  Event? selectedEvent;
  double currentZoom = 13.0; // Initial zoom level
  final double labelZoomThreshold = 13.0; // Zoom level to display labels
  List<LatLng> routePoints = []; // Polyline points for the route

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation(); // Fetch the user's location on initialization
  }

  Future<void> _fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable them.'),
        ),
      );
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission denied.'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location permissions are permanently denied. Please allow them in settings.'),
        ),
      );
      return;
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        point = LatLng(position.latitude, position.longitude);
        centerMapToCurrentLocation();
      });
      _mapController.move(
          point, currentZoom); // Center the map on the current location
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch location.')),
      );
    }
  }

  void navigateToEvent(Event event) {
    final LatLng eventLocation = LatLng(event.lat, event.lng);
    final LatLngBounds bounds = LatLngBounds.fromPoints([point, eventLocation]);

    setState(() {
      routePoints = [point, eventLocation];
    });

    _mapController.move(bounds.center, currentZoom);
  }

  void centerMapToCurrentLocation() {
    _mapController.move(point, currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    final markerSize = (currentZoom / 13.0) * 30.0; // Dynamic marker size

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: point,
            initialZoom: currentZoom,
            onTap: (tapPosition, tappedPoint) {
              if (widget.onLocationSelected != null) {
                setState(() {
                  point = tappedPoint;
                  selectedEvent = null;
                  routePoints = [];
                });
                widget.onLocationSelected!(tappedPoint);
              } else {
                setState(() {
                  selectedEvent = null;
                  routePoints = [];
                });
              }
            },
            onPositionChanged: (position, hasGesture) {
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
            MarkerLayer(
              markers: [
                Marker(
                  point: point,
                  width: markerSize,
                  height: markerSize,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                ...widget.events.map((event) {
                  final LatLng eventLocation = LatLng(event.lat, event.lng);
                  return Marker(
                    point: eventLocation,
                    width: 3 * markerSize,
                    height: 3 * markerSize,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEvent = event;
                        });
                        navigateToEvent(event);
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
                                ],
                              ),
                            ),
                          const SizedBox(height: 4),
                          Icon(
                            Icons.place,
                            size: markerSize,
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
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _fetchCurrentLocation,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
