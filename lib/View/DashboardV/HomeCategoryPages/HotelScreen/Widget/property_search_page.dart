import 'package:flutter/material.dart';
import '../../../../../Model/HotelM/hotel_search_model.dart';

class PropertySearchPage extends StatefulWidget {
  final List<Hotel0> hotelList; // Pass the hotel data

  const PropertySearchPage({super.key, required this.hotelList});

  @override
  State<PropertySearchPage> createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Hotel0> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.hotelList;
  }

  void _search(String query) {
    setState(() {
      _filtered = widget.hotelList
          .where((hotel) =>
      hotel.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 60.0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Search By Hotel Name',
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Property Name",
                labelStyle: TextStyle(fontFamily: 'poppins'),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _search('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (_, index) {
                final hotel = _filtered[index];
                return ListTile(
                  title: Text(hotel.name ?? "Unnamed Hotel", style: TextStyle(fontFamily: 'poppins'),),
                  onTap: () {
                    Navigator.pop(context, hotel);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
