import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/BusScreen/bus_search_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/BusScreen/BusScreen/search_bus_city_view.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/calender_screen.dart';
import 'package:trip_go/View/Widgets/gradient_button.dart';
import 'package:trip_go/constants.dart';
import '../../../../../Model/BusM/bus_city_model.dart';

class BusSearchCard2 extends StatefulWidget {
  String? fromCity;
  String? toCity;
  String? originId;
  String? destinationId;
  DateTime? travelDate;
  final bool? onBack;

  BusSearchCard2({
    super.key,
    this.fromCity,
    this.toCity,
    this.originId,
    this.destinationId,
    this.travelDate,
    this.onBack,
  });

  @override
  State<BusSearchCard2> createState() => _BusSearchCard2State();
}

class _BusSearchCard2State extends State<BusSearchCard2> {
  final TextEditingController fromCityController = TextEditingController();
  final TextEditingController toCityController = TextEditingController();
  String? selectedFromCityId;
  String? selectedToCityId;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Set the controllers and IDs from passed-in data
    fromCityController.text = widget.fromCity ?? '';
    toCityController.text = widget.toCity ?? '';
    selectedFromCityId = widget.originId;
    selectedToCityId = widget.destinationId;
    selectedDate = widget.travelDate ?? DateTime.now();
  }

  void swapCities() {
    setState(() {
      final temp = fromCityController.text;
      fromCityController.text = toCityController.text;
      toCityController.text = temp;
    });
  }

  void setQuickDate(int daysFromNow) {
    setState(() {
      selectedDate = DateTime.now().add(Duration(days: daysFromNow));
    });
  }

  Future<void> _openCalendar() async {
    final selected = await Navigator.push<DateTime>(
      context,
      MaterialPageRoute(
        builder: (_) => const FullScreenCalendar(isDeparture: true),
      ),
    );

    if (selected != null) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
  String get formattedDate => DateFormat('dd-MM-yyyy').format(selectedDate);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if (widget.onBack == true)
            ...[
              Container(
                height: 60,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Modify Search',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // colors: [Colors.white, Color(0xFFFFEBEE), Color(0xFFFFF5F6)],
                colors: [Color(0xFFF4F5F9), Color(0xFFF0F2F8)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Stack(
  alignment: Alignment.center,
  children: [
    Column(
      children: [
        _buildCityField("FROM", "Enter City", fromCityController, isFrom: true),
        const SizedBox(height: 16),
        _buildCityField("TO", "Enter City", toCityController, isFrom: false),
        const SizedBox(height: 10),
      ],
    ),
    Positioned(
      top: 60,
      right: 10,
      child: GestureDetector(
        onTap: swapCities,
        child:  Container(
                                height: 46,
                                width: 46,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: constants.themeColor1,
                                    width: 1,
                                  ),
                                  color: Colors.blue.shade50,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.swap_vert,
                                    color: constants.themeColor1,
                                    size: 35,
                                  ),
                                ),
                              ), ),
    ),
  ],
),

                /// DEPARTURE DATE FIELD
                GestureDetector(
                  onTap: _openCalendar,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "DEPARTURE DATE",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins',
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'poppins',
                                ),
                              ),
                            ),
                            _buildQuickOption("TOMORROW", 1),
                            const SizedBox(width: 8),
                            _buildQuickOption("DAY AFTER", 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// SEARCH BUTTON
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(label: "Search",
                    onPressed: () {
                      if (fromCityController.text.isEmpty ||
                          toCityController.text.isEmpty ||
                          selectedFromCityId == null ||
                          selectedToCityId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select valid cities")),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusSearchView(
                            fromCity: fromCityController.text,
                            toCity: toCityController.text,
                            originId: selectedFromCityId!,
                            destinationId: selectedToCityId!,
                            travelDate: selectedDate,
                          ),
                        ),
                      );
                    },
                    )
            )],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCityField(
      String label,
      String hint,
      TextEditingController controller, {
        bool isFrom = false,
      }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            final selectedCity = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchBusCityView()),
            );

            if (selectedCity != null && selectedCity is BusCity) {
              setState(() {
                controller.text = selectedCity.cityName;

                // Set city ID based on from/to
                if (isFrom) {
                  selectedFromCityId = selectedCity.cityId;
                } else {
                  selectedToCityId = selectedCity.cityId;
                }

                print('Selected City: ${selectedCity.cityName}');
                print('Selected City ID: ${selectedCity.cityId}');
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontFamily: 'poppins',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.text.isEmpty ? hint : controller.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'poppins',
                    color: controller.text.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Swap icon shown only on FROM field
        // if (isFrom)
        //   Positioned(
        //     right: 6,
        //     top: 16,
        //     child: GestureDetector(
        //       onTap: swapCities,
        //       child: Container(
        //         padding: const EdgeInsets.all(6),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.grey.shade300),
        //           shape: BoxShape.circle,
        //           color: Colors.white,
        //         ),
        //         child: Icon(Icons.swap_vert, size: 16, color: constants.themeColor1),
        //       ),
        //     ),
        //   ),
      ],
    );
  }


  Widget _buildQuickOption(String label, int daysFromNow) {
    return GestureDetector(
      onTap: () => setQuickDate(daysFromNow),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: constants.themeColor1),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Text(
          label,
          style:  TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            fontFamily: 'poppins',
            color: constants.themeColor1,
          ),
        ),
      ),
    );
  }
}
