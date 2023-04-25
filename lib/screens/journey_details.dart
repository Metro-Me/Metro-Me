import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/RouteData.dart' as Route;

class JourneyDetails extends StatefulWidget {
  final String sourceStation;
  final String destStation;

  JourneyDetails({required this.sourceStation, required this.destStation});

  @override
  _JourneyDetailsState createState() => _JourneyDetailsState();
}

class _JourneyDetailsState extends State<JourneyDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  dynamic _journeyDetails;

  @override
  void initState() {
    super.initState();
    _fetchJourneyDetails();
  }

  Future<void> _fetchJourneyDetails() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'https://metro-me-api.onrender.com/journey/least-interchange');
    final response = await http.post(
      url,
      body: {
        'stationFrom': widget.sourceStation,
        'stationTo': widget.destStation,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _journeyDetails = jsonDecode(response.body);
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.sourceStation} to ${widget.destStation}",
          style: const TextStyle(
              color: Color.fromARGB(255, 3, 201, 136), fontSize: 18),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 19, 0, 90),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Upper part
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    childAspectRatio: 3.3 / 1.5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildDetailCard(
                        label: 'Fare',
                        value: '₹' + _journeyDetails['fare'].toString(),
                      ),
                      _buildDetailCard(
                        label: 'No. of stations',
                        value: _journeyDetails['stations'].toString(),
                      ),
                      _buildDetailCard(
                        label: 'Total time taken',
                        value: formatTime(_journeyDetails['total_time']),
                      ),
                      _buildDetailCard(
                        label: 'No. of interchanges',
                        value: (_journeyDetails['route'].length - 1).toString(),
                      ),
                    ],
                  ),
                ),

                // Our custom ListTile
                Expanded(
                  child: ListView.builder(
                    itemCount: _journeyDetails['route'].length,
                    itemBuilder: (BuildContext context, int index) {
                      List<dynamic> path =
                          _journeyDetails['route'][index]['path'];
                      String currentLineColor =
                          '${_journeyDetails['route'][index]['line']}';
                      int currentStation = 1; // <--- move currentStation here

                      return Column(
                        children: [
                          Card(
                            color: getColorFromLineString(
                                '${_journeyDetails['route'][index]['line']}'),
                            child: ListTile(
                              title: Text('${path.first['name']}',
                                  style: TextStyle(color: Colors.white)),
                              subtitle: Text(
                                '${_journeyDetails['route'][index]['line']} \nTowards: ${_journeyDetails['route'][index]['towards_station']} (${_journeyDetails['route'][index]['platform_name']})',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                              trailing: Text(
                                  _journeyDetails['route'][index]['path_time'],
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: path.length,
                            itemBuilder: (BuildContext context, int i) {
                              Widget trailing;
                              trailing = Text(
                                '$currentStation/${path.length}',
                                style: TextStyle(color: Colors.white),
                              );
                              currentStation++;
                              return Card(
                                child: ListTile(
                                  title: Text(path[i]['name']),
                                  subtitle: Text(path[i]['status']),
                                  tileColor:
                                      getColorFromLineString(currentLineColor),
                                  trailing: trailing,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildDetailCard({required String label, required String value}) {
    return Card(
      color: Color.fromARGB(255, 3, 201, 136),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            SizedBox(height: 8.0),
            FittedBox(
              child: Text(
                value,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(String timeString) {
    // Split the time string into hours, minutes, and seconds components
    List<String> timeComponents = timeString.split(':');

    // Parse the hours, minutes, and seconds components
    int hours = int.parse(timeComponents[0]);
    int minutes = int.parse(timeComponents[1]);
    int seconds = int.parse(timeComponents[2]);

    // Convert the hours to a 24-hour format if necessary
    if (hours > 23) {
      hours -= 24;
    }

    // Calculate the total number of seconds in the duration
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    // Calculate the number of hours, minutes, and seconds in the duration
    int formattedHours = totalSeconds ~/ 3600;
    int formattedMinutes = (totalSeconds % 3600) ~/ 60;
    int formattedSeconds = totalSeconds % 60;

    // Build the formatted string
    String formattedTime = '';
    if (formattedHours != 0) {
      formattedTime += '${formattedHours.toString()}h ';
    }
    formattedTime +=
        '${formattedMinutes.toString()}m ${formattedSeconds.toString()}s';

    return formattedTime;
  }

  Color? getColorFromLineString(String lineString) {
    // Extract the color string from the input string
    String colorString = lineString.split(' ')[0].toLowerCase();

    // Map color strings to Color objects
    Map<String, Color> colorMap = {
      'red': Colors.red,
      'yellow': Color(0xFFFBBB00),
      'blue': Color(0xFF147BD1),
      'green': Color(0xFF25B244),
      'violet': Color(0xFF8B1598),
      'magenta': Color(0xFFE4007C),
      'pink': Color(0xFFDF9182),
      'orange': Color(0xFFEF6732),
      'gray': Color(0xFF9B9B9C),
      'aquamarine': Color(0xFF00A1AD),
    };

    // Get the Color object for the color string
    return colorMap[colorString];
  }
}
