import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchServiceInformation() async {
  final response = await http.get(Uri.parse(
      'https://backend.delhimetrorail.com/api/v2/en/service_information'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch service information');
  }
}

class ServiceStatusPage extends StatefulWidget {
  @override
  _ServiceStatusPageState createState() => _ServiceStatusPageState();
}

class _ServiceStatusPageState extends State<ServiceStatusPage> {
  late Future<String> _serviceStatusFuture;

  @override
  void initState() {
    super.initState();
    _serviceStatusFuture = fetchServiceInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Status'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<String>(
          future: _serviceStatusFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                  child: Text('Error fetching service information'));
            }

            final bool isNormalService = snapshot.data == "\"Normal Service\"";
            final List<String> lines = [
              'Red Line',
              'Yellow Line',
              'Blue Line',
              'Green Line',
              'Violet Line',
              'Orange Line',
              'Pink Line',
              'Magenta Line',
              'Grey Line',
              'Rapid Metro',
              'Aqua Line',
            ];

            final Map<String, Color> lineColors = {
              'Red Line': Colors.red,
              'Yellow Line': Colors.yellow,
              'Blue Line': Colors.blue,
              'Green Line': Colors.green,
              'Violet Line': Colors.purple,
              'Orange Line': Colors.orange,
              'Pink Line': Colors.pink,
              'Magenta Line': Colors.deepPurple,
              'Grey Line': Colors.grey,
              'Rapid Metro': Colors.brown,
              'Aqua Line': Colors.cyan,
            };

            return ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                final String line = lines[index];
                final Color lineColor = lineColors[line]!;
                final String status =
                    isNormalService ? 'Normal Service' : 'Service Interrupted';

                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 10,
                      height: double.infinity,
                      color: lineColor,
                    ),
                    title: Text(line),
                    subtitle: Text(status),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
