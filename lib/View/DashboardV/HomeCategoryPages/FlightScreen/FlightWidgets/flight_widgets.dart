import 'package:flutter/material.dart';

class TripSelector extends StatelessWidget {

  final int tripTypeIndex;
  final Function(int) onChanged;
  final List<String> types;
  const TripSelector({
    super.key,
    required this.tripTypeIndex,
    required this.onChanged, required this.types,
  });

  @override
  Widget build(BuildContext context) {
    //final List<String> types = ['One Way', 'Round Trip', 'MultiCity'];
    return Row(
      children: List.generate(types.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: tripTypeIndex == index ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                types[index],
                style: TextStyle(
                  color: tripTypeIndex == index ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins',
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class LocationBox extends StatelessWidget {
  final String label, code, city;

  const LocationBox({
    super.key,
    required this.label,
    required this.code,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontFamily: 'poppins')),
          Text(code, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
          Text(city, style: const TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'poppins', fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final String label;
  final DateTime? date;
  final bool isDeparture;
  final bool enabled;
  final VoidCallback onTap;

  const DateBox({
    super.key,
    required this.label,
    required this.date,
    required this.isDeparture,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.4,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // color: const Color(0xFFF6F6FA),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'poppins')),
                  if(!isDeparture && !enabled)
                    Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 8,
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.grey,
                        ),
                      )
                      ,
                    ),
                ],
              ),

              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.grey, size: 25),
                  const SizedBox(width: 8),
                  Text(
                    date != null
                        ? "${date!.month.toString().padLeft(2, '0')}/${date!.day.toString().padLeft(2, '0')}/${date!.year}"
                        : 'Select date',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'poppins'),
                  ),
                ],
                
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class TravellerBox extends StatelessWidget {
  final int travellerCount;

  const TravellerBox({super.key, required this.travellerCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: const Color(0xFFF6F6FA),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TRAVELLER(S)', style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'poppins')),
          const SizedBox(height: 6),
          Text(
            '$travellerCount Traveller', // Handle pluralization
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
          ),
        ],
      ),
    );
  }
}


class DropdownBox extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;

  const DropdownBox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6FA),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'poppins')),
          SizedBox(
            height: 39,
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
              items: ['Economy', 'Business', 'First Class'].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontFamily: 'poppins', fontSize: 15)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
