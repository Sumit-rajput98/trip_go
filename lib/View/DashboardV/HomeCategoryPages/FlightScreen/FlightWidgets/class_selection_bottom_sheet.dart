import 'package:flutter/material.dart';

class ClassSelectionBottomSheet extends StatefulWidget {
  final String initialClass;
  final ValueChanged<String> onClassSelected;

  const ClassSelectionBottomSheet({super.key, required this.initialClass, required this.onClassSelected});

  @override
  _ClassSelectionBottomSheetState createState() => _ClassSelectionBottomSheetState();
}

class _ClassSelectionBottomSheetState extends State<ClassSelectionBottomSheet> {
  String selectedClass = '';

  @override
  void initState() {
    super.initState();
    selectedClass = widget.initialClass;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Class', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins')),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close)),
            ],
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,  // Remove gap around radio
            title: Text('Economy', style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18)),
            leading: Radio<String>(
              value: 'Economy',
              groupValue: selectedClass,
              activeColor: Color(0xFF341f97), // Change color of the radio button
              onChanged: (value) {
                setState(() {
                  selectedClass = value!;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,  // Remove gap around radio
            title: Text('Business', style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18)),
            leading: Radio<String>(
              value: 'Business',
              groupValue: selectedClass,
              activeColor: Color(0xFF341f97), // Change color of the radio button
              onChanged: (value) {
                setState(() {
                  selectedClass = value!;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,  // Remove gap around radio
            title: Text('First Class', style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w500, fontSize: 18)),
            leading: Radio<String>(
              value: 'First Class',
              groupValue: selectedClass,
              activeColor: Color(0xFF341f97), // Change color of the radio button
              onChanged: (value) {
                setState(() {
                  selectedClass = value!;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onClassSelected(selectedClass);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: Text('DONE', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
          SizedBox(height: 40,),
        ],
      ),
    );
  }
}
