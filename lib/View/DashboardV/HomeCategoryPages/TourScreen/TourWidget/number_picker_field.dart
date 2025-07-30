import 'package:flutter/material.dart';

class NumberPickerField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final int selectedValue;
  final int min;
  final int max;
  final ValueChanged<int> onSelect;

  const NumberPickerField({
    super.key,
    required this.controller,
    required this.title,
    required this.selectedValue,
    required this.min,
    required this.max,
    required this.onSelect,
  });

  void _showSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: max - min + 1,
                  itemBuilder: (_, index) {
                    final value = min + index;
                    return ListTile(
                      title: Text(
                        '$value',
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      onTap: () {
                        onSelect(value);
                        controller.text = '$title: $value';
                        Navigator.pop(context);
                      },
                      trailing: value == selectedValue
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () {
        FocusScope.of(context).unfocus();
        _showSelectionSheet(context);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // 👈 Smaller vertical padding
        isDense: true, // 👈 Helps compact the height further
      ),
      style: const TextStyle(fontFamily: 'Poppins'),
    );
  }
}
