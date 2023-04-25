import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class EventsAndExperiences extends StatelessWidget {
  const EventsAndExperiences({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            EventsAndExperiencesItems(
              title: 'DELHI METRO MAP',
              description: 'Overview of the Metro Network',
              lessonsCount: '13 Feb, Sunday',
              imagePath: 'assets/images/delhi_metro_map_banner.png',
              url:
                  "https://www.delhimetrorail.com/static/media/Network-Map-Final-Hindi-English.03b1a797.jpg",
            ),
            EventsAndExperiencesItems(
                title: 'METRO CARD RECHARGE',
                description: 'BE READY FOR YOUR JOURNEY',
                lessonsCount: '13 Feb, Sunday',
                imagePath: 'assets/images/card_recharge_banner.png',
                url: "https://www.dmrcsmartcard.com/"),
          ],
        ),
      ),
    );
  }
}

class EventsAndExperiencesItems extends StatelessWidget {
  const EventsAndExperiencesItems({
    Key? key,
    required this.title,
    required this.description,
    required this.lessonsCount,
    required this.imagePath,
    required this.url,
  }) : super(key: key);

  final String title;
  final String description;
  final String lessonsCount;
  final String imagePath;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        width: 250,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)],
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lessonsCount,
                          style: const TextStyle(fontSize: 20),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Colors.blue, width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          onPressed: () {
                            launchUrl(Uri.parse(url),
                                mode: LaunchMode.externalApplication);
                          },
                          child: const Text('Open'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildZoomableImage() {
    return Scaffold(
      body: Container(
        child: PhotoView(
          imageProvider: AssetImage('assets/images/your_image.jpg'),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
