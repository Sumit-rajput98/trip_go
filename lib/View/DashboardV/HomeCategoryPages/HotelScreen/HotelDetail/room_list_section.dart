import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../Model/HotelM/hotel_detail_data.dart';
import '../../../../../Model/HotelM/hotel_search_model.dart';
import 'hotel_detail_page.dart';

class RoomListSection extends StatefulWidget {
  final List<RoomDetail> rooms;
  final Function(RoomDetail selectedRoom) onRoomSelected;

  const RoomListSection({
    super.key,
    required this.rooms,
    required this.onRoomSelected,
  });

  @override
  State<RoomListSection> createState() => _RoomListSectionState();
}

class _RoomListSectionState extends State<RoomListSection> {
  int _selectedRoomIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onRoomSelected(widget.rooms[_selectedRoomIndex]); // Initial selection
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.rooms.isEmpty) {
      return Text("No rooms available.", style: GoogleFonts.poppins());
    }

    return Column(
      children: List.generate(widget.rooms.length, (index) {
        final room = widget.rooms[index];
        return _buildRoomCard(room, index);
      }),
    );
  }

  Widget _buildRoomCard(RoomDetail room, int index) {
    final isSelected = index == _selectedRoomIndex;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Dummy image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdDZszhPqR28bkkXpl6oLOFlpoxGA6qlzLSQ&s',
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              if (room.name?.isNotEmpty == true)
                Expanded(
                  child: Text(
                    room.name!.first,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),


          const SizedBox(height: 12),

          if (room.name?.isNotEmpty == true)
            Text(room.name!.first, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),

          const SizedBox(height: 6),

          if (room.inclusion != null)
            Text("✔ ${room.inclusion}", style: GoogleFonts.poppins(fontSize: 12)),

          const SizedBox(height: 12),

          Row(
            children: [
              Radio(
                value: index,
                groupValue: _selectedRoomIndex,
                onChanged: (_) {
                  setState(() {
                    _selectedRoomIndex = index;
                    widget.onRoomSelected(widget.rooms[index]);
                  });
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total: ₹${room.totalFare?.toStringAsFixed(0) ?? '--'}",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("+ ₹${room.totalTax?.toStringAsFixed(0) ?? '--'} Taxes",
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                    Text("Meal: ${room.mealType ?? 'N/A'}",
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
                    Text(room.isRefundable == true ? "Refundable" : "Non-Refundable",
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.green)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
