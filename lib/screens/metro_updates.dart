import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MetroUpdatesScreen extends StatefulWidget {
  @override
  _MetroUpdatesScreenState createState() => _MetroUpdatesScreenState();
}

class _MetroUpdatesScreenState extends State<MetroUpdatesScreen> {
  List<dynamic> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  void _fetchNotifications() async {
    final response = await http
        .get(Uri.parse('https://metro-me-api.onrender.com/metro-updates'));
    if (response.statusCode == 200) {
      setState(() {
        _notifications = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Metro Updates'),
      // ),
      body: _notifications.isNotEmpty
          ? ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                final notificationDate = DateFormat.yMd()
                    .format(DateTime.parse(notification['date']));
                final notificationTitle = notification['title'];
                final notificationImage = notification['image']['file'];
                final notificationLinkTo = notification['link_to_outside_url'];

                return Card(
                  child: InkWell(
                    onTap: () {
                      if (notificationLinkTo != null) {
                        launch(notificationLinkTo);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.yellow,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                notification['notification_type']['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                notificationDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            notificationTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
