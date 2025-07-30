import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../Model/BusM/bus_search_model.dart';
import '../../../../../View/DashboardV/HomeCategoryPages/BusScreen/AddOn/bus_add_on_page.dart';

class BusNameSearchPage extends StatefulWidget {
  final origin;
  final destination;
  final List<BusResult> busList;

  const BusNameSearchPage({super.key, required this.busList, this.destination, this.origin});

  @override
  State<BusNameSearchPage> createState() => _BusNameSearchPageState();
}

class _BusNameSearchPageState extends State<BusNameSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<BusResult> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = widget.busList;
  }

  void _search(String query) {
    setState(() {
      _filtered = widget.busList
          .where((bus) =>
          bus.travelName.toLowerCase().contains(query.toLowerCase()))
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
        title: const Text(
          'Search By Bus Name',
          style: TextStyle(
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
                labelText: "Bus Name",
                labelStyle: const TextStyle(fontFamily: 'poppins'),
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
                final bus = _filtered[index];
                return ListTile(
                  title: Text(
                    bus.travelName,
                    style: const TextStyle(fontFamily: 'poppins'),
                  ),
                  subtitle: Text(
                    "₹${bus.busPrice.basePrice?.toStringAsFixed(2) ?? '0.00'} | Seats: ${bus.availableSeats}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    final traceId = ModalRoute.of(context)?.settings.arguments as String?;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BusAddOnPage(
                          travelName: bus.travelName,
                          traceId: traceId ?? '',
                          resultIndex: bus.resultIndex.toString(),
                          isDropPointMandatory: bus.isDropPointMandatory,
                          busResults: widget.busList,
                          origin: widget.origin,
                          destination: widget.destination,
                          arrival: DateFormat('E, MMM dd, yyyy')
                              .format(DateTime.parse(bus.departureTime)),
                        ),
                      ),
                    );
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
