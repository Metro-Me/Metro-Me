import 'package:flutter/material.dart';
import 'package:metrome/screens/closest_metro.dart';
import 'package:metrome/screens/home.dart';
import 'package:metrome/screens/metro_updates.dart';
import 'package:metrome/compnents/custom_drawer.dart';
import '../screens/lost_and_found.dart';

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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: unused_field
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const ClosestMetroPage(),
    MetroUpdatesScreen(),
    LostAndFoundPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(20, 20, 20, 1),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          actions: [
            PopupMenuButton<String>(
              // ignore: prefer_const_constructors
              color: Color.fromARGB(255, 28, 130, 173),

              onSelected: (value) {
                // Handle menu item selection
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'Option 1',
                    child: Text(
                      'Option 1',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Option 2',
                    child: Text(
                      'Option 2',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Option 3',
                    child: Text(
                      'Option 3',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert_rounded,
                  color: Color.fromARGB(255, 19, 0, 90)), // Add icon for button
            )
          ],
          title: const Text(
            "Metro Me",
            style: TextStyle(
              color: Color.fromARGB(255, 3, 201, 136),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 19, 0, 90),
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        body: Center(
          child: SafeArea(
              child: IndexedStack(
            index: _currentPageIndex,
            children: _pages,
          )),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: 'Closest Metro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.update_sharp),
              label: 'Metro Updates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Lost and Found',
            ),
          ],
          currentIndex: _currentPageIndex,
          selectedItemColor: const Color.fromARGB(255, 3, 201, 136),
          backgroundColor: const Color.fromARGB(255, 28, 130, 173),
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Widget myHeadList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: myTiles),
      ],
    );
  }

  List<ListTile> myTiles = [
    ListTile(
      leading: const Icon(Icons.currency_rupee),
      title: const Text('Fare'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.map),
      title: const Text('Map'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    // Add more ListTiles for other options here
    ListTile(
      leading: const Icon(Icons.route),
      title: const Text('Route'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.timer),
      title: const Text('First & Last Metro'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.upcoming),
      title: const Text('Upcoming Metro'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.wallet_giftcard),
      title: const Text('Card Recharge'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.local_parking),
      title: const Text('Parking Fare'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.directions),
      title: const Text('Gates and Directions'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
    ListTile(
      leading: const Icon(Icons.train),
      title: const Text('Closest Metro Station'),
      onTap: () {
        // Add your navigation logic here
      },
    ),
  ];
}
