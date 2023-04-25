import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
}

List<MetroStation> filterStations(
    String jsonResponse, double userLat, double userLon) {
  Map<String, dynamic> data = jsonDecode(jsonResponse);
  List<dynamic> elements = data['elements'];
  List<MetroStation> filteredStations = [];

  for (Map<String, dynamic> element in elements) {
    String? network = element['tags']['network'];
    if (network == "DMRC" || network == "Delhi Metro") {
      String name = element['tags']['name'];
      double lat = element['lat'];
      double lon = element['lon'];
      String network = element['tags']['network'];

      double distance = Geolocator.distanceBetween(userLat, userLon, lat, lon);

      filteredStations.add(MetroStation(
          name: name,
          network: network,
          lat: lat,
          lon: lon,
          distance: distance));
    }
  }

  // Sort the filtered stations by distance
  filteredStations.sort((a, b) => a.distance.compareTo(b.distance));

  return filteredStations;
}

class MetroStation {
  final String name;
  final String network;
  final double lat;
  final double lon;
  final double distance;

  MetroStation({
    required this.name,
    required this.network,
    required this.lat,
    required this.lon,
    required this.distance,
  });
}

class ClosestMetroPage extends StatefulWidget {
  const ClosestMetroPage({super.key});

  @override
  _ClosestMetroPageState createState() => _ClosestMetroPageState();
}

class _ClosestMetroPageState extends State<ClosestMetroPage> {
  double _sliderValue = 10.0;
  String _closestMetro = '';
  bool _isLoading = false;
  List<MetroStation> _closestStations = [];

  void _openGoogleMaps(double lat, double lon) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _findClosestMetro() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Position position = await getCurrentLocation();
      double userLat = position.latitude;
      double userLon = position.longitude;

      print(position);
      List<MetroStation> closestStations = await findClosestMetroStationAPI(
          userLat, userLon, _sliderValue * 1000);
      print("Closest stations: $closestStations");

      setState(() {
        _closestStations = closestStations;
        _isLoading = false;
      });
    } catch (e) {
      print(e);

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<MetroStation>> findClosestMetroStationAPI(
      double latitude, double longitude, double radius) async {
    String url =
        'https://overpass-api.de/api/interpreter?data=[out:json];(node[~"railway"~"station"](around:$radius,$latitude,$longitude););out;';

    print(url);
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['elements'].isNotEmpty) {
        List<MetroStation> dmrcStations =
            filterStations(response.body, latitude, longitude);
        return dmrcStations;
      } else {
        return [
          MetroStation(name: "", network: "", lat: 0.0, lon: 0.0, distance: 0.0)
        ];
      }
    } else {
      return [
        MetroStation(name: "", network: "", lat: 0.0, lon: 0.0, distance: 0.0)
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select range in kilometers:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Slider(
              activeColor: const Color.fromARGB(255, 0, 51, 124),
              value: _sliderValue,
              min: 2,
              max: 50,
              divisions: (50 - 2) ~/ 2,
              label: '${_sliderValue.round()} km',
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _findClosestMetro,
              child: const Text(
                'Find closest Metro',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 201, 136),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: _closestStations.length,
                      itemBuilder: (context, index) {
                        MetroStation station = _closestStations[index];
                        return ListTile(
                          title: Text(station.name),
                          subtitle: Text(station.network),
                          onTap: () {
                            _openGoogleMaps(station.lat, station.lon);
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
