import 'dart:convert';

import 'package:metrome/compnents/home_tiles.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:flutter/material.dart';
import 'journey_details.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _stations = [
    "SHAHEED STHAL ( NEW BUS ADDA)",
    "HINDON RIVER",
    "ARTHALA",
    "MOHAN NAGAR",
    "SHYAM PARK",
    "MAJOR MOHIT SHARMA RAJENDRA NAGAR",
    "RAJ BAGH",
    "SHAHEED NAGAR",
    "DILSHAD GARDEN",
    "JHILMIL",
    "MANSAROVAR PARK",
    "SHAHDARA",
    "WELCOME",
    "SEELAMPUR",
    "SHASTRI PARK",
    "KASHMERE GATE",
    "TIS HAZARI",
    "PULBANGASH",
    "PRATAP NAGAR",
    "SHASTRI NAGAR",
    "INDERLOK",
    "KANHAIYA NAGAR ",
    "KESHAV PURAM",
    "NETAJI SUBHASH PLACE",
    "KOHAT ENCLAVE",
    "PITAMPURA",
    "ROHINI EAST",
    "ROHINI WEST",
    "RITHALA",
    "SAMAYPUR BADLI",
    "ROHINI SECTOR - 18, 19",
    "HAIDERPUR BADLI MOR",
    "JAHANGIRPURI",
    "ADARSH NAGAR",
    "AZADPUR",
    "MODEL TOWN",
    "GURU TEG BAHADUR NAGAR",
    "VISWAVIDYALAYA",
    "VIDHAN SABHA",
    "CIVIL LINES",
    "KASHMERE GATE",
    "CHANDNI CHOWK",
    "CHAWRI BAZAR",
    "NEW DELHI (Yellow & Airport Line)",
    "RAJIV CHOWK",
    "PATEL CHOWK",
    "CENTRAL SECRETARIAT",
    "UDYOG BHAWAN",
    "LOK KALYAN MARG",
    "JOR BAGH",
    "DILLI HAAT - INA",
    "AIIMS",
    "GREEN PARK",
    "HAUZ KHAS",
    "MALVIYA NAGAR",
    "SAKET",
    "QUTAB MINAR",
    "CHHATARPUR",
    "SULTANPUR",
    "GHITORNI",
    "ARJAN GARH",
    "GURU DRONACHARYA",
    "SIKANDERPUR",
    "M.G. ROAD",
    "IFFCO CHOWK",
    "HUDA CITY CENTRE",
    "DWARKA SECTOR - 21",
    "DWARKA SECTOR - 8",
    "DWARKA SECTOR - 9",
    "DWARKA SECTOR - 10",
    "DWARKA SECTOR - 11",
    "DWARKA SECTOR - 12",
    "DWARKA SECTOR - 13",
    "DWARKA SECTOR - 14",
    "DWARKA",
    "DWARKA MOR",
    "NAWADA",
    "UTTAM NAGAR WEST",
    "UTTAM NAGAR EAST",
    "JANAK PURI WEST",
    "JANAK PURI EAST",
    "TILAK NAGAR",
    "SUBHASH NAGAR",
    "TAGORE GARDEN",
    "RAJOURI GARDEN",
    "RAMESH NAGAR",
    "MOTI NAGAR",
    "KIRTI NAGAR",
    "SHADIPUR",
    "PATEL NAGAR",
    "RAJENDRA PLACE",
    "KAROL BAGH",
    "JHANDEWALAN",
    "RAMAKRISHNA ASHRAM MARG",
    "RAJIV CHOWK",
    "BARAKHAMBA ROAD",
    "MANDI HOUSE",
    "SUPREME COURT",
    "INDRAPRASTHA",
    "YAMUNA BANK",
    "AKSHARDHAM",
    "MAYUR VIHAR -I",
    "MAYUR VIHAR EXTENSION",
    "NEW ASHOK NAGAR",
    "NOIDA SECTOR-15",
    "NOIDA SECTOR-16",
    "NOIDA SECTOR-18",
    "BOTANICAL GARDEN",
    "GOLF COURSE",
    "NOIDA CITY CENTRE",
    "SECTOR - 34 NOIDA",
    "SECTOR - 52 NOIDA",
    "SECTOR - 61 NOIDA",
    "SECTOR - 59 NOIDA",
    "SECTOR - 62 NOIDA",
    "NOIDA ELECTRONIC CITY",
    "YAMUNA BANK",
    "LAXMI NAGAR",
    "NIRMAN VIHAR",
    "PREET VIHAR",
    "KARKARDUMA",
    "ANAND VIHAR ISBT",
    "KAUSHAMBI",
    "VAISHALI",
    "KIRTI NAGAR",
    "SATGURU RAM SINGH MARG",
    "INDERLOK",
    "ASHOK PARK MAIN",
    "PUNJABI BAGH",
    "PUNJABI BAGH WEST",
    "SHIVAJI PARK",
    "MADIPUR",
    "PASCHIM VIHAR EAST",
    "PASCHIM VIHAR WEST",
    "PEERAGARHI",
    "UDYOG NAGAR",
    "MAHARAJA SURAJMAL STADIUM",
    "NANGLOI",
    "NANGLOI RAILWAY STATION",
    "RAJDHANI PARK",
    "MUNDKA",
    "MUNDKA INDUSTRIAL AREA (MIA)",
    "GHEVRA METRO STATION",
    "TIKRI KALAN",
    "TIKRI BORDER",
    "PANDIT SHREE RAM SHARMA",
    "BAHADURGARH CITY",
    "BRIG. HOSHIAR SINGH",
    "KASHMERE GATE",
    "LAL QUILA",
    "JAMA MASJID",
    "DELHI GATE",
    "ITO",
    "MANDI HOUSE",
    "JANPATH",
    "CENTRAL SECRETARIAT",
    "KHAN MARKET",
    "JLN STADIUM",
    "JANGPURA",
    "LAJPAT NAGAR",
    "MOOLCHAND",
    "KAILASH COLONY",
    "NEHRU PLACE",
    "KALKAJI MANDIR",
    "GOVINDPURI",
    "HARKESH NAGAR OKHLA",
    "JASOLA-APOLLO",
    "SARITA VIHAR",
    "MOHAN ESTATE",
    "TUGHLAKABAD STATION",
    "BADARPUR BORDER",
    "SARAI",
    "NHPC CHOWK",
    "MEWALA MAHARAJPUR",
    "SECTOR-28",
    "BADKAL MOR",
    "OLD FARIDABAD",
    "NEELAM CHOWK AJRONDA",
    "BATA CHOWK",
    "ESCORTS MUJESAR",
    "SANT SURDAS (SIHI)",
    "RAJA NAHAR SINGH (BALLABHGARH)",
    "MAJLIS PARK",
    "AZADPUR",
    "SHALIMAR BAGH",
    "NETAJI SUBHASH PLACE",
    "SHAKURPUR",
    "PUNJABI BAGH WEST",
    "ESI-BASAIDARAPUR",
    "RAJOURI GARDEN",
    "MAYAPURI",
    "NARAINA VIHAR",
    "DELHI CANTT.",
    "DURGABAI DESHMUKH SOUTH CAMPUS",
    "SIR M. VISHWESHWARAIAH MOTI BAGH",
    "BHIKAJI CAMA PLACE",
    "SAROJINI NAGAR",
    "DILLI HAAT - INA",
    "SOUTH EXTENSION",
    "LAJPAT NAGAR",
    "VINOBAPURI",
    "ASHRAM",
    "SARAI KALE KHAN - NIZAMUDDIN",
    "MAYUR VIHAR -I",
    "MAYUR VIHAR POCKET-1",
    "TRILOKPURI-SANJAY LAKE",
    "EAST VINOD NAGAR-MAYUR VIHAR -II",
    "MANDAWALI - WEST VINOD NAGAR",
    "I.P. EXTENSION",
    "ANAND VIHAR ISBT",
    "KARKARDUMA",
    "KARKARDUMA COURT",
    "KRISHNA NAGAR",
    "EAST AZAD NAGAR",
    "WELCOME",
    "JAFRABAD",
    "MAUJPUR-BABARPUR",
    "GOKULPURI",
    "JOHRI ENCLAVE",
    "SHIV VIHAR",
    "JANAK PURI WEST",
    "DABRI MOR -JANAKPURI SOUTH",
    "DASHRATHPURI",
    "PALAM",
    "SADAR BAZAR CANTONMENT",
    "TERMINAL 1-IGI AIRPORT",
    "SHANKAR VIHAR",
    "VASANT VIHAR",
    "MUNIRKA",
    "R.K.PURAM",
    "IIT",
    "HAUZ KHAS",
    "PANCHSHEEL PARK",
    "CHIRAG DELHI",
    "GREATER KAILASH",
    "NEHRU ENCLAVE",
    "KALKAJI MANDIR",
    "OKHLA NSIC",
    "SUKHDEV VIHAR",
    "JAMIA MILIA ISLAMIYA",
    "OKHLA VIHAR",
    "JASOLA VIHAR SHAHEEN BAGH",
    "KALINDI KUNJ",
    "OKHLA BIRD SANCTUARY",
    "BOTANICAL GARDEN",
    "DWARKA",
    "NANGLI",
    "NAJAFGARH",
    "DHANSA BUS STAND",
    "NEW DELHI (Yellow & Airport Line)",
    "SHIVAJI STADIUM ",
    "DHAULA KUAN",
    "DELHI AEROCITY",
    "AIRPORT (T-3)",
    "DWARKA SECTOR - 21",
    "SECTOR 55-56",
    "SECTOR-54 CHOWK",
    "SECTOR-53-54",
    "SECTOR-42-43",
    "PHASE-1",
    "SIKANDERPUR",
    "PHASE-2",
    "BELVEDERE TOWERS",
    "CYBER CITY",
    "MOULSARI AVENUE",
    "PHASE-3"
  ];

  Future<bool> sendJourneyDetails(
      String sourceStation, String destStation) async {
    const String firebaseUrl =
        'https://metro-me-c9587-default-rtdb.firebaseio.com/journeys.json';
    final DateTime createdAt = DateTime.now();

    Map<String, dynamic> journeyData = {
      'source_station': sourceStation,
      'destination_station': destStation,
      'created_at': createdAt.toIso8601String(),
    };

    http.Response response =
        await http.post(Uri.parse(firebaseUrl), body: jsonEncode(journeyData));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: unused_field
  String? _selectedDestStation;
  // ignore: unused_field
  String? _selectedSourceStation;
  final TextEditingController _sourceStationController =
      TextEditingController();
  final TextEditingController _destinationStationController =
      TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFieldSearch(
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      initialList: _stations,
                      label: "Enter source station",
                      controller: _sourceStationController),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.swap_horiz,
                color: Color.fromARGB(255, 28, 130, 173),
              ),
              onPressed: () {
                // Add your functionality here for when the button is pressed
                String temp = _sourceStationController.text;
                _sourceStationController.text =
                    _destinationStationController.text;
                _destinationStationController.text = temp;
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFieldSearch(
                    initialList: _stations,
                    label: "Enter destination station",
                    controller: _destinationStationController),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.swap_horiz,
                color: Color.fromARGB(255, 28, 130, 173),
              ),
              onPressed: () {
                // Add your functionality here for when the button is pressed
                String temp = _sourceStationController.text;
                _sourceStationController.text =
                    _destinationStationController.text;
                _destinationStationController.text = temp;
              },
            ),
          ],
        ),
        const SizedBox(
            height:
                20), // Add some spacing between the text fields and the button
        ElevatedButton(
          onPressed: () async {
            if (_sourceStationController.text.isNotEmpty &&
                _destinationStationController.text.isNotEmpty &&
                _sourceStationController.text !=
                    _destinationStationController.text) {
              bool success = await sendJourneyDetails(
                  _sourceStationController.text,
                  _destinationStationController.text);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JourneyDetails(
                    sourceStation: _sourceStationController.text,
                    destStation: _destinationStationController.text,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invalid input.'),
                ),
              );
            }
          },
          child: const Text(
            'Get Directions', // Change the text to "Get Directions"
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
              borderRadius: BorderRadius.circular(10), // Add rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Add padding
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: EventsAndExperiences(),
        ),
      ],
    );
  }
}
