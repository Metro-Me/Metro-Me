import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  final List<Map<String, dynamic>> teamMembers = [
    {
      'name': 'Aditya',
      'role': 'Team Lead (Backend/App Dev)',
      'description':
          'Aditya is responsible for leading the team and overseeing the backend and app development.',
      'linkedin': 'https://www.linkedin.com/in/m0nxt3r',
      'github': 'https://github.com/m0nx73r',
    },
    {
      'name': 'Anish',
      'role': 'Database/Backend Dev',
      'description':
          'Anish specializes in database management and backend development, ensuring smooth functionality.',
      'linkedin': 'https://www.instagram.com/_anishxalxo_',
      'github': 'https://github.com/anishkhalkho',
    },
    {
      'name': 'Tanmay',
      'role': 'App Dev/Testing',
      'description':
          'Tanmay focuses on app development and testing, ensuring the app\'s performance and stability.',
      'linkedin': 'https://www.linkedin.com/in/tanmay-tarang-a092a3185/',
      'github': 'https://github.com/tanmaytarang2003',
    },
    {
      'name': 'Harshita',
      'role': 'UI/UX Designer',
      'description':
          'Harshita is responsible for designing the user interface and user experience, making the app visually appealing and easy to use.',
      'linkedin': 'https://www.linkedin.com/in/harshita-3ab4991a7/',
      'github': 'https://github.com/Harshita003',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teamMembers[index]['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      teamMembers[index]['role'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(teamMembers[index]['description']),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person),
                          onPressed: () => launchUrl(Uri.parse(
                              teamMembers[index]['linkedin'].toString())),
                        ),
                        IconButton(
                          icon: const Icon(Icons.code),
                          onPressed: () => launchUrl(Uri.parse(
                              teamMembers[index]['github'].toString())),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
