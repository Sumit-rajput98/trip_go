import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_go/Model/FlightM/fare_rules_model.dart';
import 'package:trip_go/ViewM/FlightVM/fare_rules_view_model.dart';
import 'package:flutter_html/flutter_html.dart';

void showFareRuleBottomSheet(BuildContext context, FareRulesRequest request) {
  final viewModel = Provider.of<FareRulesViewModel>(context, listen: false);
  viewModel.fetchFareRules(request);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              children: [
                // Modern drag handle
                Container(
                  width: 48,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // Updated top tabs
                _buildTopTabs(),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: const FareRuleContent(),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Updated top tabs design
Widget _buildTopTabs() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(child: _topTab("Breakup", false)),
        Expanded(child: _topTab("Fare rule", true)),
        Expanded(child: _topTab("Baggage", false)),
      ],
    ),
  );
}
class FareRuleContent extends StatelessWidget {
  const FareRuleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FareRulesViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return _buildShimmerEffect();
        }

        final rules = viewModel.fareRulesResponse?.data?.fareRules;

        if (rules == null || rules.isEmpty) {
          return _buildNoData();
        }

        return DefaultTabController(
          length: rules.length,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: const Color(0xff1B499F),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  labelColor: const Color(0xff1B499F),
                  unselectedLabelColor: Colors.grey[600],
                  padding: EdgeInsets.zero,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: rules.map((rule) {
                    final route = "${rule.origin ?? ""}-${rule.destination ?? ""}";
                    return Tab(text: route);
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Fixed height container for tab content
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: TabBarView(
                  children: rules.map((rule) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildFareRuleCard(rule),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab bar shimmer
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 20),
            // Content shimmer
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return Column(
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          "No fare rules available",
          style: GoogleFonts.poppins(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Updated fare rule card design
  Widget _buildFareRuleCard(FareRule rule) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0,8,8,15),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Fare Basis Code"),
            _sectionContent(rule.fareBasisCode ?? "N/A", isBold: true),
            const SizedBox(height: 20),

            _sectionTitle("Fare Inclusions"),
            const SizedBox(height: 8),
            if (rule.fareInclusions != null && rule.fareInclusions!.isNotEmpty)
              ...rule.fareInclusions!.map((e) => _bulletText(e))
            else
              _sectionContent("No inclusions specified"),
            const SizedBox(height: 20),

            _sectionTitle("Fare Rules"),
            const SizedBox(height: 8),
            rule.fareRuleDetail != null
                ? Html(
              data: rule.fareRuleDetail!,
              style: {
                "*": Style(
                  fontSize: FontSize(13.5),
                  lineHeight: LineHeight(1.4),
                  color: Colors.grey[700],
                ),
              },
            )
                : _sectionContent("No rule details available"),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  // Updated section title style
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: const Color(0xff1B499F),
      ),
    );
  }

  // Updated section content style
  Widget _sectionContent(String text, {bool isBold = false}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13.5,
        fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
        color: Colors.grey[700],
      ),
    );
  }

  // Updated bullet point style
  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, size: 6, color: Colors.grey[500]),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}Widget _topTab(String label, bool selected) {
  return Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: selected ? const Color(0xff1B499F) : Colors.transparent,
      boxShadow: selected ? [
        BoxShadow(
          color: const Color(0xff1B499F).withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        )
      ] : null,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == "Fare rule")
              Icon(
                Icons.assignment_outlined,
                size: 16,
                color: selected ? Colors.white : Colors.grey[600],
              ),
            if (label == "Fare rule") const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}