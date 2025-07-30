import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trip_go/Model/FlightM/flight_SSR_model_lcc.dart';
import 'package:trip_go/constants.dart';

import '../../../../../ViewM/FlightVM/meal_provider.dart';

class MealsAddOnsPage extends StatefulWidget {
  final Data? flightSsrRes;
  final Function(double)? onMealPriceChange;

  const MealsAddOnsPage({
    super.key,
    this.flightSsrRes,
    this.onMealPriceChange,
  });

  @override
  State<MealsAddOnsPage> createState() => _MealsAddOnsPageState();
}

class _MealsAddOnsPageState extends State<MealsAddOnsPage> {

  @override
  bool get wantKeepAlive => true;

  List<Map<String, dynamic>> meals = [];

  @override
  void initState() {
    super.initState();

    if (widget.flightSsrRes?.mealDynamic != null) {
      final rawList = widget.flightSsrRes!.mealDynamic!.expand((e) => e).toList();

      // Skip NoMeal entries
      final filteredList = rawList.where((meal) => meal.code != 'NoMeal').toList();

      meals = filteredList.map((meal) {
        return {
          'name': meal.airlineDescription ?? 'Meal',
          'desc': meal.description?.toString() ?? 'No description',
          'price': meal.price ?? 0,
          'image': '', // You can plug in image URL here
          'count': 0,
          'code': meal.code,
          'airlineCode': meal.airlineCode,
          'flightNumber': meal.flightNumber,
          'currency': meal.currency,
          'origin': meal.origin,
          'destination': meal.destination,
          'quantity': meal.quantity ?? 1, // limit max count
        };
      }).toList();
    }
  }

  void _updateMealTotalPrice() {
    double total = 0;
    for (var item in meals) {
      total += (item['count'] as int) * (item['price'] as int);
    }
    widget.onMealPriceChange?.call(total);
  }

  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    if (meals.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("No Meal Available", style: GoogleFonts.poppins(fontSize: 18)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? screenWidth * 0.1 : 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Select Your Meals',
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  color: constants.themeColor1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: meals.length,
                separatorBuilder: (context, index) => SizedBox(height: isTablet ? 24 : 16),
                itemBuilder: (context, index) {
                  final item = meals[index];
                  return _buildMealCard(item, isTablet, screenWidth);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> item, bool isTablet, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: isTablet ? screenWidth * 0.15 : 90,
                height: isTablet ? screenWidth * 0.15 : 90,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.network(
                  item['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.fastfood,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            SizedBox(width: isTablet ? 24 : 16),

            // Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['quantity'].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${item['price']}',
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1B499F),
                        ),
                      ),
                      _buildCounterControls(item, isTablet),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterControls(Map<String, dynamic> item, bool isTablet) {
    return item['count'] == 0
        ? ElevatedButton(
      onPressed: () {
        setState(() {
          item['count'] = 1;
          _updateMealTotalPrice();
        });

        final mealProvider = Provider.of<MealProvider>(context, listen: false);

        mealProvider.addMeal({
          "AirlineCode": item['airlineCode'],
          "FlightNumber": item['flightNumber'],
          "WayType": 2,
          "Code": item['code'],
          "Description": item['desc'],
          "AirlineDescription": item['name'],
          "Quantity": 1,
          "Currency": item['currency'],
          "Price": item['price'],
          "Origin": item['origin'],
          "Destination": item['destination'],
        });

        print("MealDynamic JSON (after Add press): ${mealProvider.mealJson}");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B499F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 : 20,
          vertical: isTablet ? 16 : 12,
        ),
      ),
      child: Text(
        'Add',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: isTablet ? 16 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
        : Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (item['count'] > 0) {
                setState(() {
                  item['count']--;
                  _updateMealTotalPrice();
                });

                final mealProvider = Provider.of<MealProvider>(context, listen: false);

                if (item['count'] == 0) {
                  mealProvider.removeMeal(item['code']);
                } else {
                  mealProvider.addMeal({
                    "AirlineCode": item['airlineCode'],
                    "FlightNumber": item['flightNumber'],
                    "WayType": 2,
                    "Code": item['code'],
                    "Description": item['desc'],
                    "AirlineDescription": item['name'],
                    "Quantity": item['count'],
                    "Currency": item['currency'],
                    "Price": item['price'],
                    "Origin": item['origin'],
                    "Destination": item['destination'],
                  });
                }

                print("MealDynamic JSON: ${mealProvider.mealJson}");
              }
            },
            icon: Icon(Icons.remove, color: Colors.red.shade400),
            iconSize: isTablet ? 28 : 24,
            padding: EdgeInsets.zero,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${item['count']}',
              style: GoogleFonts.poppins(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (item['count'] < item['quantity']) {
                setState(() {
                  item['count']++;
                  _updateMealTotalPrice();
                });

                final mealProvider = Provider.of<MealProvider>(context, listen: false);

                mealProvider.addMeal({
                  "AirlineCode": item['airlineCode'],
                  "FlightNumber": item['flightNumber'],
                  "WayType": 2,
                  "Code": item['code'],
                  "Description": item['desc'],
                  "AirlineDescription": item['name'],
                  "Quantity": item['count'],
                  "Currency": item['currency'],
                  "Price": item['price'],
                  "Origin": item['origin'],
                  "Destination": item['destination'],
                });

                print("MealDynamic JSON: ${mealProvider.mealJson}");
              }
            },
            icon: Icon(Icons.add, color: const Color(0xFF1B499F)),
            iconSize: isTablet ? 28 : 24,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

}
/*
class MealsAddOnsPage extends StatefulWidget {
  final Data? flightSsrRes;
  const MealsAddOnsPage({super.key, this.flightSsrRes});

  @override
  State<MealsAddOnsPage> createState() => _MealsAddOnsPageState();
}

class _MealsAddOnsPageState extends State<MealsAddOnsPage> {
  List<Map<String, dynamic>> meals = [];

  @override
  void initState() {
    super.initState();

    if (widget.flightSsrRes?.mealDynamic != null) {
      final rawList = widget.flightSsrRes!.mealDynamic!.expand((e) => e).toList();

      // Remove 'NoMeal' entries
      final mealList = rawList.where((meal) => meal.code != 'NoMeal').toList();

      meals = mealList.map((meal) {
        return {
          'name': meal.airlineDescription?.isNotEmpty == true
              ? meal.airlineDescription
              : 'Meal Option',
          'desc': meal.description?.toString() ?? '',
          'price': meal.price ?? 0,
          'image': '', // Placeholder, update if image URLs available
          'count': 0,
          'code': meal.code,
          'currency': meal.currency,
          'airlineCode': meal.airlineCode,
          'flightNumber': meal.flightNumber,
          'origin': meal.origin,
          'destination': meal.destination,
        };
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    if (meals.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text("No Meal Available", style: GoogleFonts.poppins(fontSize: 18)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? screenWidth * 0.1 : 16,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Select Your Meals',
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  color: constants.themeColor1,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: meals.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: isTablet ? 24 : 16),
                itemBuilder: (context, index) {
                  final item = meals[index];
                  return _buildMealCard(item, isTablet, screenWidth);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> item, bool isTablet, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: isTablet ? screenWidth * 0.15 : 90,
                height: isTablet ? screenWidth * 0.15 : 90,
                color: Colors.grey.shade100,
                child: item['image'].isEmpty
                    ? Icon(Icons.fastfood, size: 40, color: Colors.grey.shade400)
                    : Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.fastfood, size: 40, color: Colors.grey.shade400),
                      ),
              ),
            ),
            SizedBox(width: isTablet ? 24 : 16),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['quantity'],
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 14 : 12,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${item['price']}',
                        style: GoogleFonts.poppins(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1B499F),
                        ),
                      ),
                      _buildCounterControls(item, isTablet),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterControls(Map<String, dynamic> item, bool isTablet) {
    return item['count'] == 0
        ? ElevatedButton(
            onPressed: () => setState(() => item['count'] = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B499F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 20,
                vertical: isTablet ? 16 : 12,
              ),
            ),
            child: Text(
              'Add',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: isTablet ? 16 : 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    if (item['count'] > 0) item['count']--;
                  }),
                  icon: Icon(Icons.remove, color: Colors.red.shade400),
                  iconSize: isTablet ? 28 : 24,
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '${item['count']}',
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 18 : 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => item['count']++),
                  icon: Icon(Icons.add, color: const Color(0xFF1B499F)),
                  iconSize: isTablet ? 28 : 24,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          );
  }
}
 */