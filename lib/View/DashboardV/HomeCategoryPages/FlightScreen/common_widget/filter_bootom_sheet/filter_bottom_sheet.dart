import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FlightFilterBottomSheet extends StatefulWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onTimeTap;
  final VoidCallback onAirlineTap;
  final VoidCallback onSortTap;
  final bool showSortNotification;
  final ValueChanged<bool>? onNonStopChanged;

  const FlightFilterBottomSheet({
    super.key,
    required this.onFilterTap,
    required this.onTimeTap,
    required this.onAirlineTap,
    required this.onSortTap,
    this.showSortNotification = false,
    this.onNonStopChanged,
  });

  @override
  State<FlightFilterBottomSheet> createState() => _FlightFilterBottomSheetState();
}

class _FlightFilterBottomSheetState extends State<FlightFilterBottomSheet>
    with SingleTickerProviderStateMixin {
  bool isNonStop = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab(icon: CupertinoIcons.slider_horizontal_3, label: "FILTER", onTap: widget.onFilterTap),
          _buildNonStopSwitch(),
          _buildTab(icon: CupertinoIcons.clock, label: "TIME", onTap: widget.onTimeTap),
          _buildTab(icon: Icons.airline_seat_recline_normal_outlined, label: "AIRLINE", onTap: widget.onAirlineTap),
          _buildTab(
            icon: Icons.sort,
            label: "SORT",
            onTap: widget.onSortTap,
            showDot: widget.showSortNotification,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({required IconData icon, required String label, required VoidCallback onTap, bool showDot = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: const Color(0xFF4A5568), size: 26),
              if (showDot)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xffF73130), // themeColor2
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNonStopSwitch() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isNonStop = !isNonStop;
        });
        if (widget.onNonStopChanged != null) {
          widget.onNonStopChanged!(isNonStop); // <-- Notify parent
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 50,
            height: 26,
            decoration: BoxDecoration(
              color: isNonStop ? const Color(0xff1B499F) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: isNonStop ? Alignment.centerRight : Alignment.centerLeft,
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isNonStop ? Icons.check : Icons.close,
                        size: 14,
                        color: isNonStop ? Color(0xff1B499F) : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "NON-STOP",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}