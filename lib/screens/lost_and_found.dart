import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LostAndFoundItem {
  final int id;
  final String itemName;
  final String description;
  final String station;
  final String receivingDate;
  final String receivingTime;

  LostAndFoundItem({
    required this.id,
    required this.itemName,
    required this.description,
    required this.station,
    required this.receivingDate,
    required this.receivingTime,
  });

  factory LostAndFoundItem.fromJson(Map<String, dynamic> json) {
    return LostAndFoundItem(
      id: json['id'],
      itemName: json['item_name'],
      description: json['description'],
      station: json['station'],
      receivingDate: json['receiving_date'],
      receivingTime: json['receiving_time'],
    );
  }
}

class LostAndFoundPage extends StatefulWidget {
  @override
  _LostAndFoundPageState createState() => _LostAndFoundPageState();
}

class _LostAndFoundPageState extends State<LostAndFoundPage> {
  List<LostAndFoundItem> _itemsList = [];
  String? _nextPageUrl;
  String? _prevPageUrl;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems({String? pageUrl}) async {
    final url =
        pageUrl ?? 'https://metro-me-api.onrender.com/lost-and-found?page=1';
    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);

    setState(() {
      final items = jsonData['results'] as List<dynamic>;
      _itemsList.clear();
      _itemsList.addAll(items.map((item) => LostAndFoundItem.fromJson(item)));
      _nextPageUrl = jsonData['next'] ?? _nextPageUrl;
      _prevPageUrl =
          jsonData['previous'] ?? _prevPageUrl; // fix typo in API response
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _itemsList.length,
            itemBuilder: (context, index) {
              final item = _itemsList[index];
              return ListTile(
                title: Text(item.itemName),
                subtitle: Text(item.station),
                trailing: Text('${item.receivingDate} ${item.receivingTime}'),
              );
            },
          ),
          if (_itemsList.isEmpty) Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_prevPageUrl != null)
            TextButton(
              style: ButtonStyle(),
              onPressed: () => _fetchItems(pageUrl: _prevPageUrl),
              child: Text(
                'Previous',
                style: TextStyle(
                  color: Color.fromARGB(255, 3, 201, 136),
                ),
              ),
            ),
          if (_nextPageUrl != null)
            TextButton(
              style: ButtonStyle(),
              onPressed: () => _fetchItems(pageUrl: _nextPageUrl),
              child: Text(
                'Next',
                style: TextStyle(
                  color: Color.fromARGB(255, 3, 201, 136),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
