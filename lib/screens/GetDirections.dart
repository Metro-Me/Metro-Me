import 'package:flutter/material.dart';

class JourneyDetailsPage extends StatelessWidget {
  final Map<String, dynamic> journeyDetails;

  JourneyDetailsPage({required this.journeyDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journey Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "From: ${journeyDetails['from']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "To: ${journeyDetails['to']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Total Stations: ${journeyDetails['stations']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "From Station Status: ${journeyDetails['from_station_status']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "To Station Status: ${journeyDetails['to_station_status']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Total Time: ${journeyDetails['total_time']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Fare: ₹ ${journeyDetails['fare']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Route:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: journeyDetails['route'].length,
                itemBuilder: (BuildContext context, int index) {
                  final route = journeyDetails['route'][index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Line ${route['line_no']}: ${route['line']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Path Time: ${route['path_time']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Start: ${route['start']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "End: ${route['end']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Direction: ${route['direction']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Towards Station: ${route['towards_station']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Platform Name: ${route['platform_name']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Departure Time: ${route['new_start_time']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Arrival Time: ${route['new_end_time']}",
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Station Interchange Time: ${route['station_interchange_time']} minutes",
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Stations: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: route['path'].length,
                        itemBuilder: (BuildContext context, int index) {
                          final station = route['path'][index];
                          return Text(
                            "${station['name']} - ${station['status']}",
                          );
                        },
                      ),
                      SizedBox(height: 16.0),
                    ],
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
