import 'package:flutter/material.dart';
import 'package:trip_go/View/Widgets/Drawer/custom_drawer.dart';
import 'package:get/get.dart';

class RoomGuestSelectorPage extends StatefulWidget {
  const RoomGuestSelectorPage({super.key});

  @override
  State<RoomGuestSelectorPage> createState() => _RoomGuestSelectorPageState();
}

class _RoomGuestSelectorPageState extends State<RoomGuestSelectorPage> {
  int rooms = 1;
  int adults = 1;
  int children = 0;
  String? warningMessage;
  List<int> childAges = [];

  void _updateCounter(String type, bool increment) {
    if (type == 'adult') {
      if (increment) {
        if (adults >= 80) {
          _showLimitSnackbar("Maximum 80 adults can be selected at a time");
          return;
        }
        setState(() {
          adults++;
          if (rooms > adults) rooms = adults;
        });
      } else if (adults > 1) {
        setState(() {
          adults--;
        });
      }
    }

    else if (type == 'room') {
      if (increment) {
        if (rooms >= 20) {
          _showLimitSnackbar("Maximum 20 rooms can be selected at a time");
          return;
        }
        setState(() {
          rooms++;
          if (rooms > adults) adults = rooms;
        });
      } else if (rooms > 1) {
        setState(() {
          rooms--;
        });
      }
    }

    else if (type == 'child') {
      if (increment) {
        if (children >= 79) {
          _showLimitSnackbar("Maximum 79 children can be selected at a time");
          return;
        }
        setState(() {
          children++;
          childAges.add(12); // default age
        });
      } else if (children > 0) {
        setState(() {
          children--;
          childAges.removeLast();
        });
      }
    }
  }

  void _showLimitSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          Icon(Icons.info_outline, color: constants.themeColor1, size: 20),
          SizedBox(width: 8),
          Text(
            'Limit Reached',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),
          ),
        ],
      ),
      messageText: Text(
        message,
        style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      isDismissible: true,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Icon(Icons.close, size: 18, color: Colors.black),
      ),
    );
  }

  void _selectAge(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Select Age',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'poppins',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 13,
                      itemBuilder: (context, age) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              childAges[index] = age;
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  age == 0 ? '< 1 Year' : '$age Years',
                                  style: const TextStyle(fontSize: 16, fontFamily: 'poppins'),
                                ),
                                Radio<int>(
                                  value: age,
                                  groupValue: childAges[index],
                                  onChanged: (val) {
                                    setState(() {
                                      childAges[index] = val!;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChildAgeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text("Select Age", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'poppins')),
        const SizedBox(height: 8),
        for (int i = 0; i < children; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Child ${i + 1}", style: const TextStyle(fontSize: 14, fontFamily: 'poppins')),
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => _selectAge(i),
                  child: Container(
                    width: 90,
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: constants.themeColor1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          childAges[i] == 0 ? "< 1" : "${childAges[i]} Years",
                          style: const TextStyle(fontSize: 12, fontFamily: 'poppins'),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 18, color: constants.themeColor1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRow(IconData icon, String title, String subtitle, String type, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: constants.themeColor1),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'poppins')),
                Text(subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'poppins')),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              border: Border.all(color: constants.themeColor1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                _rectButton(Icons.remove, () => _updateCounter(type, false)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text('$value', style: const TextStyle(fontSize: 16, fontFamily: 'poppins')),
                ),
                _rectButton(Icons.add, () => _updateCounter(type, true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rectButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: constants.themeColor1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constants.themeColor1,
        elevation: 1,
        toolbarHeight: 60.0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$adults Persons in $rooms Room${rooms > 1 ? 's' : ''}',
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow(Icons.meeting_room_outlined, 'Rooms', 'Minimum 1', 'room', rooms),
              _buildRow(Icons.person_outline, 'Adults', '13 years & above', 'adult', adults),
              _buildRow(Icons.child_care_outlined, 'Children', '0-12 years', 'child', children),
              if (children > 0) _buildChildAgeSelector(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$rooms Room${rooms > 1 ? 's' : ''}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
                    Text('$adults Adults, $children Children',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'rooms': rooms,
                        'adults': adults,
                        'children': children,
                        'childAges': childAges,
                        'totalGuests': adults + children, // ✅ Add this line
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: constants.themeColor1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text("Select", style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
