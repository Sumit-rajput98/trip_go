import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/round_trip_flight_search_model.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/FlightWidgets/multi_city_flight_list_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/multi_city_section.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/round_trip_list_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/select_destination_city_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/FlightScreen/select_origin_city_screen.dart';
import '../../../../Model/FlightM/flight_search_model.dart';
import '../../../../ViewM/FlightVM/flight_search_view_model.dart';
import '../../../../ViewM/FlightVM/round_trip_flight_search_view_model.dart';
import '../../../../constants.dart';
import '../../../Widgets/gradient_button.dart';
import 'FlightPartSections/benefit_section_widget.dart';
import 'FlightPartSections/daily_deals.dart';
import 'FlightPartSections/offers_view.dart';
import 'FlightPartSections/search_destination_section.dart';
import 'FlightPartSections/where2_go_section.dart';
import 'FlightWidgets/calender_screen.dart';
import 'FlightWidgets/class_selection_bottom_sheet.dart';
import 'FlightWidgets/flight_checkbox_grid.dart';
import 'FlightWidgets/flight_widgets.dart';
import 'FlightWidgets/traveller_selection_bottom_sheet.dart';
import 'flight_list_screen.dart';
import 'flight_loading_screen.dart';
import 'flight_routes_view.dart';

class FlightBookingScreen extends StatefulWidget {
  const FlightBookingScreen({super.key});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  Map<String, String> fromCity = {'city': 'DELHI', 'code': 'DEL'};
  Map<String, String> toCity = {'city': 'MUMBAI', 'code': 'BOM'};

  int tripTypeIndex = 0;
  DateTime? departureDate = DateTime.now();
  DateTime? returnDate;
  String selectedClass = 'Economy';
  int travellerCount = 2;
  bool _showErrorMessage = false;
  bool nonStop = false;
  bool studentFare = false;
  bool armedForces = false;
  bool seniorCitizen = false;

  int adultsCount = 2;
  int childrenCount = 0;
  int infantsCount = 0;

  void _onSearchPressed() {
    if (fromCity['city'] == toCity['city']) {
      setState(() {
        _showErrorMessage = true;
      });
    } else {
      print('--- Selected Flight Search Inputs ---');
      print('From: ${fromCity['city']} (${fromCity['code']})');
      print('To: ${toCity['city']} (${toCity['code']})');
      print(
        'Departure Date: ${departureDate?.toLocal().toString().split(' ')[0]}',
      );
      print(
        'Return Date: ${returnDate != null ? returnDate?.toLocal().toString().split(' ')[0] : 'N/A'}',
      );
      print('Class: $selectedClass');
      print(
        'Travellers: $travellerCount (Adults: $adultsCount, Children: $childrenCount, Infants: $infantsCount)',
      );
      print('Non-Stop: $nonStop');
      print('Student Fare: $studentFare');
      print('Armed Forces: $armedForces');
      print('Senior Citizen: $seniorCitizen');
      print('--------------------------------------');

      final viewModel = Provider.of<FlightSearchViewModel>(
        context,
        listen: false,
      );

      final formattedDepartureDate =
      departureDate?.toLocal().toString().split(' ')[0];
      final formattedReturnDate =
      returnDate?.toLocal().toString().split(' ')[0];

      final cabinClassMap = {
        "All": 1,
        "Economy": 2,
        "PremiumEconomy": 3,
        "Business": 4,
        "PremiumBusiness": 5,
        "First": 6,
      };

      final int mappedCabinClass = cabinClassMap[selectedClass] ?? 1;

      final request = FlightSearchRequest(
        origin: fromCity['code'],
        destination: toCity['code'],
        departureDate: formattedDepartureDate ?? '',
        adult: adultsCount,
        child: childrenCount,
        infant: infantsCount,
        type: tripTypeIndex + 1,
        cabin: mappedCabinClass,
        tboToken: "", // Set real token here
        partocrsSession: "", // Set real session here
      );
      final request2 = RoundTripFlightSearchRequest(
        origin: fromCity['code']!,
        destination: toCity['code']!,
        departureDate: formattedDepartureDate ?? '',
        adult: adultsCount,
        child: childrenCount,
        infant: infantsCount,
        type: tripTypeIndex + 1,
        cabin: mappedCabinClass,
        tboToken: "",
        partocrsSession: "",
        returnDate: formattedReturnDate ?? '',
      );

      if (tripTypeIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => FlightLoadingScreen(
              fromCity: fromCity['city']!,
              toCity: toCity['city']!,
              departureDate: departureDate!,
              adultCount: adultsCount,
            ),
          ),
        );

        viewModel.searchFlights(request).then((_) {
          Navigator.pop(context);
          print('✅ Flight search completed');

          if (viewModel.flightSearchResponse != null) {
            // Print FlightSearchResponse
            final flightSearchResponse = viewModel.flightSearchResponse!;
            print('--- Flight Search Response ---');
            print('TraceId: ${flightSearchResponse.traceId}');
            print('Origin: ${flightSearchResponse.origin}');
            print('Destination: ${flightSearchResponse.destination}');
            print('Results:');

            // Print FlightResult and Segment details line by line
            for (var resultList in flightSearchResponse.results) {
              for (var result in resultList) {
                print('Result Index: ${result.resultIndex}');
                print('Is Refundable: ${result.isRefundable}');
                print('Airline Remark: ${result.airlineRemark}');
                print(
                  'Fare: ${result.fare.currency} ${result.fare.publishedFare}',
                );
                print('Segments:');

                for (var segList in result.segments) {
                  for (var segment in segList) {
                    print('  Segment:');
                    print('    Baggage: ${segment.baggage}');
                    print('    Cabin Baggage: ${segment.cabinBaggage}');
                    print(
                      '    Airline: ${segment.airline.airlineName} (${segment.airline.airlineCode})',
                    );
                    print('    Flight Number: ${segment.airline.flightNumber}');
                    print('    Departure Time: ${segment.departureTime}');
                    print('    Arrival Time: ${segment.arrivalTime}');
                  }
                }
              }
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => FlightListScreen(
                  adultCount: adultsCount,
                  childrenCount: childrenCount,
                  infantsCount : infantsCount,
                  flightSearchResponse: viewModel.flightSearchResponse!,
                  departureDate: departureDate!,
                  fromCity: fromCity['city']!,
                  toCity: toCity['city']!,
                ),
              ),
            );
          }
          /* else if (tripTypeIndex == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => RoundTripListScreen()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MultiCityFlightListScreen()));
        }*/
        });
      } else if (tripTypeIndex == 1) {
        if(returnDate!=null){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => FlightLoadingScreen(
                fromCity: fromCity['city']!,
                toCity: toCity['city']!,
                departureDate: departureDate!,
                adultCount: adultsCount,
              ),
            ),
          );
          final rViewModel = Provider.of<RoundTripFlightSearchViewModel>(
            context,
            listen: false,
          );
          rViewModel.searchFlights(request2).then((_) {
            Navigator.pop(context);

            if (rViewModel.flightSearchResponse != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => RoundTripListScreen(
                    flightSearchResponse: rViewModel.flightSearchResponse!,
                    departureDate: departureDate!,
                    fromCity: fromCity['code']!,
                    toCity: toCity['code']!,
                        adultCount: adultsCount,
                        childrenCount: childrenCount,
                        infantsCount : infantsCount,
                  ),
                ),
              );
            }
          });}
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Enter the return date"),
              duration: Duration(seconds: 2),
            ),
          );

        }
      } else {}
    }
  }

  List<Map<String, dynamic>> multiCitySegments = [
    {'from': null, 'to': null, 'date': null},
    {'from': null, 'to': null, 'date': null},
  ];

  void _showTravellerBottomSheet() async {
    await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      ),
      context: context,
      builder:
          (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        child: TravellerBottomSheet(
          initialAdultsCount: adultsCount,
          initialChildrenCount: childrenCount,
          initialInfantsCount: infantsCount,
          onDone: (adults, children, infants) {
            setState(() {
              adultsCount = adults;
              childrenCount = children;
              infantsCount = infants;
              travellerCount = adults + children + infants;
            });
          },
        ),
      ),
    );
  }

  void _showClassSelectionBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder:
          (context) => ClassSelectionBottomSheet(
        initialClass: selectedClass,
        onClassSelected: (classSelected) {
          setState(() {
            selectedClass = classSelected;
          });
        },
      ),
    );
  }

  Future<void> _pickDate(bool isDeparture) async {
    final picked = await Navigator.push<DateTime>(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenCalendar(isDeparture: isDeparture),
      ),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          departureDate = picked;
        } else {
          returnDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FlightSearchViewModel>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFE9ECF2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // colors: [Color(0xFFFFCDD2), Color(0xFFBBDEFB)],
                    // #F5F1F5
                    // colors: [Color(0xFFFFEBEE), Color(0xFFFFF5F6)],
                    colors: [Color(0xFFF4F5F9), Color(0xFFF0F2F8)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Colors.red, Colors.blue],
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: TripSelector(
                          types: ['One Way', 'Round Trip', 'MultiCity'],
                          tripTypeIndex: tripTypeIndex,
                          onChanged:
                              (index) => setState(() => tripTypeIndex = index),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (tripTypeIndex == 2)
                        MultiCitySection()
                      else ...[
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final selectedCity = await Navigator.push<
                                          Map<String, String>
                                      >(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              SelectOriginCityScreen(),
                                        ),
                                      );
                                      if (selectedCity != null) {
                                        setState(() {
                                          fromCity = selectedCity;
                                        });
                                      }
                                    },
                                    child: LocationBox(
                                      label: 'FROM',
                                      code: fromCity['code'] ?? 'DEL',
                                      city: fromCity['city'] ?? 'DELHI',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final selectedCity = await Navigator.push<
                                          Map<String, String>
                                      >(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              SelectDestinationCityScreen(),
                                        ),
                                      );
                                      if (selectedCity != null) {
                                        setState(() {
                                          toCity = selectedCity;
                                        });
                                      }
                                    },
                                    child: LocationBox(
                                      label: 'TO',
                                      code: toCity['code'] ?? 'DEL',
                                      city: toCity['city'] ?? 'DELHI',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final temp = fromCity;
                                  fromCity = toCity;
                                  toCity = temp;
                                });
                              },
                              child: Container(
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
                                child:  Center(
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: constants.themeColor1,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_showErrorMessage)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'FROM and TO cities cannot be the same!',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: DateBox(
                                label: 'DEPARTURE DATE',
                                date: departureDate,
                                isDeparture: true,
                                enabled: true,
                                onTap: () => _pickDate(true),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DateBox(
                                label: 'RETURN DATE',
                                date: returnDate,
                                isDeparture: false,
                                enabled: tripTypeIndex != 0,
                                onTap: () {
                                  if (tripTypeIndex == 0) {
                                    setState(() {
                                      tripTypeIndex = 1;
                                    });
                                  }
                                  _pickDate(false);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: _showTravellerBottomSheet,
                                child: TravellerBox(
                                  travellerCount: travellerCount,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: _showClassSelectionBottomSheet,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'CLASS',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontFamily: 'poppins',
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedClass,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'poppins',
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 10),
                      FlightCheckboxGrid(
                        nonStop: nonStop,
                        studentFare: studentFare,
                        armedForces: armedForces,
                        seniorCitizen: seniorCitizen,
                        onNonStopChanged:
                            (val) => setState(() => nonStop = val!),
                        onStudentFareChanged:
                            (val) => setState(() => studentFare = val!),
                        onArmedForcesChanged:
                            (val) => setState(() => armedForces = val!),
                        onSeniorCitizenChanged:
                            (val) => setState(() => seniorCitizen = val!),
                      ),
                      const SizedBox(height: 10),
                      GradientButton(
                        label: 'SEARCH FLIGHT',
                        onPressed: _onSearchPressed,
                      ),
                    ],
                  ),
                ),
              ),
              DailyDeals(),
              FlightRoutesView(),
              OffersView(),
              // SearchDestinationsSection(),
              // Where2GoSection(),
              // BenefitSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }
}