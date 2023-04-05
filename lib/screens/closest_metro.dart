import 'package:flutter/material.dart';
import 'dart:math';

class ClosestMetroPage extends StatefulWidget {
  const ClosestMetroPage({super.key});

  @override
  _ClosestMetroPageState createState() => _ClosestMetroPageState();
}

class _ClosestMetroPageState extends State<ClosestMetroPage> {
  double _sliderValue = 10.0;
  String _closestMetro = '';

  void _findClosestMetro() {
    // replace this with your actual logic to find the closest metro
    Random random = Random();
    int distance = random.nextInt(50 - 2) + 2;
    setState(() {
      _closestMetro = 'The closest metro is $distance km away from you.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 0, 51, 124),
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
              label:
                  '${_sliderValue.round()} km', // display current slider value as label
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your functionality here for when the button is pressed
              },
              child: const Text(
                'Find closest Metro', // Change the text to "Get Directions"
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Add bold font weight
                  fontSize: 16, // Set font size to 16 pixels
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 3, 201, 136), // Set background color to blue
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Add rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Add padding
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _closestMetro,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
