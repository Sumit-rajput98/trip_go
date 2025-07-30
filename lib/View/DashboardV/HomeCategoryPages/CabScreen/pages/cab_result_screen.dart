import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/pages/cab_review_screen.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/CabScreen/widgets/cab_search_card.dart';
import '../../../../../Model/CabM/cab_search_model.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/edit_bottom_sheet.dart';
import '../widgets/journey_info_card.dart';
import '../widgets/light_app_bar.dart';

class CabResultScreen extends StatefulWidget {
  final List<CabModel> cabs;
  final String pickup;
  final String drop;
  final String date;
  final String pickupState;
  final String dropState;
  final DateTime? pickupDate;
  final DateTime? dropDate;

  const CabResultScreen({super.key, required this.cabs,required this.date, required this.pickup, required this.drop, required this.dropState, required this.pickupState, required this.pickupDate,required this.dropDate });

  @override
  State<CabResultScreen> createState() => _CabResultScreenState();
}

class _CabResultScreenState extends State<CabResultScreen>
    with TickerProviderStateMixin {
  
  // Theme colors
  static const Color themeColor1 = Color(0xff1B499F);
  static const Color themeColor2 = Color(0xffF73130);
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int selectedFilter = 0;
  bool showPriceBreakdown = false;

  late List<CabModel> cabList;

  @override
  void initState() {
    super.initState();
    cabList = widget.cabs;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          LightAppBar( // ✅ Separated widget
            drop: widget.drop,
            date: widget.date,
            onBack: () => Navigator.pop(context),
            onSearch: () => _showSearchBottomSheet(context),
            onEdit: () => _showEditBottomSheet(context),
          ),
          buildJourneyInfoCard(
            context: context,
            slideAnimation: _slideAnimation,
            pickup: widget.pickup,
            pickupState: widget.pickupState,
            drop: widget.drop,
            dropState: widget.dropState,
          ),
          _buildSmartFilters(context),
          _buildCabList(context),
         
        ],
      ),
      floatingActionButton: _buildFloatingNavigation(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
void _showDateTimeEditDialog(BuildContext context) {
  showModernDateTimePicker(
    context: context,
    initialDate: DateTime.now(),
    onDateSelected: (dt) {
      setState(() {
        // Update your date/time state here
      });
    },
  );
}

void _showPreferencesDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Preferences',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Overseas checkbox
          CheckboxListTile(
            title: Text('Overseas', style: GoogleFonts.poppins()),
            value: false, // Replace with your state
            activeColor: themeColor1,
            onChanged: (value) {
              // Handle overseas toggle
            },
          ),
          
          // Travellers option
          ListTile(
            leading: Icon(Icons.person_outline, color: themeColor1),
            title: Text('Travellers', style: GoogleFonts.poppins()),
            subtitle: Text('Add adult & child count', 
                         style: GoogleFonts.poppins(fontSize: 12)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show traveller selection
            },
          ),
          
          // Luggage option
          ListTile(
            leading: Icon(Icons.luggage_outlined, color: themeColor1),
            title: Text('Luggage', style: GoogleFonts.poppins()),
            subtitle: Text('Add carry & checked-in luggage', 
                         style: GoogleFonts.poppins(fontSize: 12)),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Show luggage selection
            },
          ),
        ],
      ),
    ),
  );
}

  void _showEditBottomSheet(BuildContext context) {
    showEditBottomSheet(
      context,
      onSearchTap: () => _showSearchBottomSheet(context),
      onDateTimeEditTap: () => _showDateTimeEditDialog(context),
      onPreferencesTap: () => _showPreferencesDialog(context),
    );
  }

void _showSearchBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.search, color: themeColor1, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Modify Search',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Search form - embedded CabSearchCard
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: CabSearchCard(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
  // **Smart Filters - Light Theme**
  Widget _buildSmartFilters(BuildContext context) {
    final filters = [
      {'name': 'Best Match', 'icon': Icons.auto_awesome, 'color': themeColor1},
      {'name': 'Fastest', 'icon': Icons.speed, 'color': themeColor2},
      {'name': 'Cheapest', 'icon': Icons.savings, 'color': Colors.green.shade600},
      {'name': 'Premium', 'icon': Icons.star, 'color': Colors.amber.shade600},
    ];

    return SliverToBoxAdapter(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filters.length,
          itemBuilder: (context, index) {
            final filter = filters[index];
            final isSelected = selectedFilter == index;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = index;

                  // Apply filter logic based on selected filter
                  if (filters[index]['name'] == 'Cheapest') {
                    cabList.sort((a, b) => a.price.compareTo(b.price));
                  } else if (filters[index]['name'] == 'Fastest') {
                    // Add logic for fastest if ETA available in cab model
                  } else if (filters[index]['name'] == 'Premium') {
                    cabList.sort((a, b) => b.price.compareTo(a.price)); // Premium: expensive first
                  } else {
                    // Best Match or default — maybe keep as original
                  }
                });

                HapticFeedback.lightImpact();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(colors: [
                          (filter['color'] as Color),
                          (filter['color'] as Color).withOpacity(0.8),
                        ])
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? (filter['color'] as Color)
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: (filter['color'] as Color).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      filter['icon'] as IconData,
                      color: isSelected ? Colors.white : (filter['color'] as Color),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      filter['name'] as String,
                      style: GoogleFonts.poppins(
                        color: isSelected ? Colors.white : (filter['color'] as Color),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // **Cab List - Light Theme**
  Widget _buildCabList(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final cab = cabList[index];

          // Extract features from description if needed (optional parsing)
          // final List<String> features = _parseFeatures(cab.description);

          return _buildLightCabCard(
            context,
            {
              'name': cab.name,
              'subtitle': '${cab.totalSeats} Seats • AC',
              'image': cab.image,
              'price': cab.price,
              'originalPrice': cab.mrp,
              'rating': 4.9, // optional static/fetched if available
              'eta': '3 min', // or calculate dynamically
              'features': ['AC', 'Music'],
              'savings': cab.mrp - cab.price,
            },
            index,
          );
        },
        childCount: cabList.length,
      ),
    );
  }

  Widget _buildLightCabCard(BuildContext context, Map<String, dynamic> cab, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - _fadeAnimation.value) * (index + 1)),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    HapticFeedback.mediumImpact();

                    final selectedCab = cabList[index]; // <-- This must be your real CabModel

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, _) => CabReviewScreen(cab: selectedCab, date: widget.date, pickup: widget.pickup, drop: widget.drop, dropState: widget.dropState, pickupState: widget.pickupState, pickupDate: widget.pickupDate, dropDate: widget.dropDate,),
                        transitionsBuilder: (context, animation, _, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // **Car Image**
                            Container(
                              width: 120,
                              height: 90,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  cab['image'],
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.directions_car, 
                                           color: Colors.grey.shade400, size: 50),
                                ),
                              ),
                            ),
                            
                            const SizedBox(width: 20),
                            
                            // **Car Details**
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cab['name'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              cab['subtitle'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // **Rating & ETA**
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.amber.shade300),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.star, 
                                                     color: Colors.amber.shade600, size: 14),
                                                const SizedBox(width: 2),
                                                Text(
                                                  '${cab['rating']}',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.amber.shade700,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'ETA ${cab['eta']}',
                                            style: GoogleFonts.poppins(
                                              color: Colors.green.shade600,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  // **Feature Tags**
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 4,
                                    children: (cab['features'] as List<String>)
                                        .map((feature) => Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: themeColor1.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: themeColor1.withOpacity(0.3),
                                                ),
                                              ),
                                              child: Text(
                                                feature,
                                                style: GoogleFonts.poppins(
                                                  color: themeColor1,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        Divider(color: Colors.grey.shade200),
                        const SizedBox(height: 16),
                        
                        // **Price Section**
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '₹${cab['price']}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black87,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '₹${cab['originalPrice']}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey.shade500,
                                        fontSize: 14,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check_circle, 
                                         color: Colors.green.shade600, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      'TGOCAB Applied • Save ₹${cab['savings']}',
                                      style: GoogleFonts.poppins(
                                        color: Colors.green.shade600,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                          //   // **Book Button**
                          //   Container(
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         colors: [themeColor1, themeColor2],
                          //       ),
                          //       borderRadius: BorderRadius.circular(16),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: themeColor1.withOpacity(0.3),
                          //           blurRadius: 8,
                          //           offset: const Offset(0, 2),
                          //         ),
                          //       ],
                          //     ),
                          //     child: ElevatedButton(
                          //       onPressed: () {
                          //         HapticFeedback.heavyImpact();
                          //       },
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.transparent,
                          //         shadowColor: Colors.transparent,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(16),
                          //         ),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 20, vertical: 12),
                          //         child: Text(
                          //           'BOOK NOW',
                          //           style: GoogleFonts.poppins(
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                           ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // **Floating Navigation - Light Theme**
  Widget _buildFloatingNavigation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavButton(Icons.filter_alt_outlined, 'Filter', () {}),
          Container(width: 1, height: 24, color: Colors.grey.shade300),
          _buildNavButton(Icons.sort, 'Sort', () {}),
          Container(width: 1, height: 24, color: Colors.grey.shade300),
          _buildNavButton(Icons.map_outlined, 'Map View', () {}),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: themeColor1, size: 20),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: themeColor1,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
