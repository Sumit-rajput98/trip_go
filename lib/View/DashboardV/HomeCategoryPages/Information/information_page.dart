import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/constants.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage>
    with TickerProviderStateMixin {
  final primaryColor = constants.themeColor1;
  final secondaryColor = constants.themeColor2;
  final accentColor = const Color(0xFFFF6B6B);
  final backgroundColor = const Color(0xFFF8FAFC);
  final cardColor = Colors.white;
  
  late AnimationController _headerAnimationController;
  late Animation<double> _headerAnimation;
  
  String _stateSearch = "";
  int _selectedTabIndex = 0;
  bool _isSearchFocused = false;

  final List<Map<String, String>> statesList = [
    {"name": "Andaman & Nicobar Islands", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Andhra Pradesh", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Arunachal Pradesh", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Assam", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Bihar", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Chandigarh", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Chhattisgarh", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Delhi", "status": "Travel Open", "riskLevel": "High"},
    {"name": "Goa", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Gujarat", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Haryana", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Himachal Pradesh", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Jammu And Kashmir", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Jharkhand", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Karnataka", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Kerala", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Ladakh", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Madhya Pradesh", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Maharashtra", "status": "Travel Open", "riskLevel": "High"},
    {"name": "Manipur", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Meghalaya", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Mizoram", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Nagaland", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Odisha", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Puducherry", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Punjab", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Rajasthan", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Sikkim", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Tamil Nadu", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Telangana", "status": "Travel Open", "riskLevel": "Medium"},
    {"name": "Tripura", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "Uttar Pradesh", "status": "Travel Open", "riskLevel": "High"},
    {"name": "Uttarakhand", "status": "Travel Open", "riskLevel": "Low"},
    {"name": "West Bengal", "status": "Travel Open", "riskLevel": "Medium"},
  ];

  final List<Map<String, String>> airlinesList = [
    {
      "name": "Air India",
      "status": "Flying",
      "onTimePerformance": "78%",
      "logo": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QO8gVe353NPaAV3wid57LAtWqIdet-EVMA&s",
    },
    {
      "name": "IndiGo",
      "status": "Flying",
      "onTimePerformance": "82%",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/6E.png",
    },
    {
      "name": "SpiceJet",
      "status": "Flying",
      "onTimePerformance": "74%",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/SG.png",
    },
    {
      "name": "Go First",
      "status": "Suspended",
      "onTimePerformance": "N/A",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/G8.png",
    },
    {
      "name": "Vistara",
      "status": "Flying",
      "onTimePerformance": "85%",
      "logo": "https://flight.easemytrip.com/Content/AirlineLogon/UK.png",
    },
  ];

  final List<Map<String, dynamic>> quickAccessItems = [
    {
      "icon": Icons.flight_takeoff,
      "label": "Airlines",
      "subtitle": "Live Status",
      "color": Color(0xFF6C63FF),
      "gradient": [Color(0xFF6C63FF), Color(0xFF9C88FF)],
    },
    {
      "icon": Icons.location_on,
      "label": "Domestic",
      "subtitle": "Guidelines",
      "color": Color(0xFF2ECC71),
      "gradient": [Color(0xFF2ECC71), Color(0xFF58D68D)],
    },
    {
      "icon": Icons.public,
      "label": "International",
      "subtitle": "Travel Info",
      "color": Color(0xFFFF6B6B),
      "gradient": [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
    },
    {
      "icon": Icons.health_and_safety,
      "label": "Health",
      "subtitle": "Guidelines",
      "color": Color(0xFFF39C12),
      "gradient": [Color(0xFFF39C12), Color(0xFFF7DC6F)],
    },
  ];

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _headerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeInOut,
    ));
    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredStates = _stateSearch.isEmpty
        ? statesList
        : statesList
            .where((s) => s["name"]!.toLowerCase().contains(
                  _stateSearch.toLowerCase(),
                ))
            .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildModernAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildQuickAccessSection(),
                _buildStatsOverview(),
                _buildTabSection(),
                if (_selectedTabIndex == 0) _buildStatesSection(filteredStates),
                if (_selectedTabIndex == 1) _buildAirlinesSection(),
                if (_selectedTabIndex == 2) _buildImportantLinksSection(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      
    );
  }Widget _buildModernAppBar() {
  return SliverAppBar(
    expandedHeight: 280,
    floating: false,
    pinned: true,
    backgroundColor: primaryColor,
    // Add the white back button
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(),
    ),
    flexibleSpace: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
       
        final double appBarHeight = constraints.biggest.height;
        final double collapsedHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
        final double expandedHeight = 280;
        
        
        final double shrinkOffset = expandedHeight - appBarHeight;
        final bool showTitle = shrinkOffset > (expandedHeight - collapsedHeight - 50);
        
        return FlexibleSpaceBar(
          
          title: showTitle ? Text(
            "Travel Guide",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ) : null,
          background: AnimatedBuilder(
            animation: _headerAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.8),
                      const Color(0xFF9C88FF),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: CustomPaint(
                          painter: _PatternPainter(),
                        ),
                      ),
                    ),
                    // Main content
                    Center(
                      child: Transform.translate(
                        offset: Offset(0, _headerAnimation.value * 20 - 20),
                        child: Opacity(
                          opacity: _headerAnimation.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.travel_explore,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Travel Guide",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Travel safety tips & guidelines",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(height: 20),
                              _buildSearchBar(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    ),
  );
}

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        onChanged: (val) => setState(() => _stateSearch = val),
        onTap: () => setState(() => _isSearchFocused = true),
        onTapOutside: (_) => setState(() => _isSearchFocused = false),
        style: GoogleFonts.poppins(fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: _isSearchFocused ? primaryColor : Colors.grey,
          ),
          suffixIcon: _stateSearch.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => setState(() => _stateSearch = ""),
                )
              : null,
          hintText: "Search destinations, airlines, or guidelines...",
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Access",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quickAccessItems.length,
              itemBuilder: (context, index) {
                final item = quickAccessItems[index];
                return _buildAdvancedQuickCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedQuickCard(Map<String, dynamic> item, int index) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 4 : 0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        shadowColor: item["color"].withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: item["gradient"],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (index < 3) {
                setState(() => _selectedTabIndex = index);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item["icon"],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item["label"],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item["subtitle"],
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("34", "States Open", Icons.location_on, secondaryColor),
          _buildStatItem("4", "Airlines Flying", Icons.flight, primaryColor),
          _buildStatItem("98%", "Uptime", Icons.trending_up, accentColor),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildTabItem("States", 0),
                _buildTabItem("Airlines", 1),
                _buildTabItem("Resources", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatesSection(List<Map<String, String>> filteredStates) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Travel Guidelines",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Live",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredStates.length,
            itemBuilder: (context, index) {
              final state = filteredStates[index];
              return _buildAdvancedStateCard(state, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedStateCard(Map<String, String> state, int index) {
    final riskLevel = state["riskLevel"]!;
    Color riskColor;
    switch (riskLevel) {
      case "Low":
        riskColor = secondaryColor;
        break;
      case "Medium":
        riskColor = const Color(0xFFF39C12);
        break;
      case "High":
        riskColor = accentColor;
        break;
      default:
        riskColor = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.location_on,
            color: primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          state["name"]!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: riskColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                riskLevel,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: riskColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: secondaryColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                "Open",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAirlinesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Airlines Status",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Real-time",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: airlinesList.length,
            itemBuilder: (context, index) {
              final airline = airlinesList[index];
              return _buildAdvancedAirlineCard(airline);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedAirlineCard(Map<String, String> airline) {
    final isOperational = airline["status"] == "Flying";
    final statusColor = isOperational ? secondaryColor : accentColor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: airline["logo"]!.endsWith('.svg')
              ? SvgPicture.network(
                  airline["logo"]!,
                  width: 32,
                  height: 32,
                )
              : Image.network(
                  airline["logo"]!,
                  width: 32,
                  height: 32,
                  fit: BoxFit.contain,
                ),
        ),
        title: Text(
          airline["name"]!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        subtitle: airline["onTimePerformance"] != "N/A"
            ? Text(
                "On-time: ${airline["onTimePerformance"]}",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              )
            : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isOperational ? Icons.check_circle : Icons.error,
                color: statusColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                airline["status"]!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImportantLinksSection() {
    final links = [
      {
        "title": "How to Cancel Your Flight?",
        "icon": Icons.cancel_outlined,
        "description": "Step-by-step cancellation guide",
        "color": accentColor,
      },
      {
        "title": "How to Reschedule Your Flight?",
        "icon": Icons.schedule,
        "description": "Reschedule with ease",
        "color": const Color(0xFFF39C12),
      },
      {
        "title": "Travel Insurance Guide",
        "icon": Icons.security,
        "description": "Protect your journey",
        "color": primaryColor,
      },
      {
        "title": "COVID-19 Guidelines",
        "icon": Icons.health_and_safety,
        "description": "Latest health protocols",
        "color": secondaryColor,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Help & Resources",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                Icon(
                  Icons.help_outline,
                  color: primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: links.length,
            itemBuilder: (context, index) {
              final link = links[index];
              return _buildAdvancedLinkCard(link);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedLinkCard(Map<String, dynamic> link) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: link["color"].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  link["icon"],
                  color: link["color"],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      link["title"],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      link["description"],
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (double i = 0; i < size.width; i += 20) {
      for (double j = 0; j < size.height; j += 20) {
        path.addOval(Rect.fromCircle(center: Offset(i, j), radius: 2));
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
