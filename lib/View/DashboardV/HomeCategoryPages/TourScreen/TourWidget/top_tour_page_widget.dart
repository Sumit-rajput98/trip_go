import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../Model/TourM/destination_model.dart';
import '../../../../../ViewM/TourVM/destinantion_view_model.dart';
import '../tour_category_view.dart';

class TopTourPageWidget extends StatefulWidget {
  const TopTourPageWidget({
    super.key,
    required this.size,
    required this.imgList,
  });

  final Size size;
  final List imgList;

  @override
  State<TopTourPageWidget> createState() => _TopTourPageWidgetState();
}

class _TopTourPageWidgetState extends State<TopTourPageWidget> {
  final GlobalKey _searchBarKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinationViewModel>(context, listen: false).loadDestinations();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _overlayEntry?.dispose();
    super.dispose();
  }

  void showDestinationSelector(BuildContext context, List<DestinationModel> allDestinations) {
    final overlay = Overlay.of(context);
    final renderBox = _searchBarKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    List<DestinationModel> filteredList = List.from(allDestinations);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
                FocusScope.of(context).unfocus();
              },
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
            Positioned(
              left: position.dx,
              top: position.dy + size.height + 10,
              width: MediaQuery.of(context).size.width - 40,
              child: Material(
                color: Colors.transparent,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    _searchController.addListener(() {
                      setState(() {
                        filteredList = allDestinations
                            .where((d) => d.name.toLowerCase().contains(_searchController.text.toLowerCase()))
                            .toList();
                      });
                    });

                    return Container(
                      height: 300,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Top Trending",
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  _overlayEntry?.remove();
                                  _overlayEntry = null;
                                  FocusScope.of(context).unfocus();
                                },
                                child: const Icon(Icons.close, size: 20),
                              ),
                            ],
                          ),
                          const Divider(),
                          Expanded(
                            child: filteredList.isEmpty
                                ? const Center(child: Text("No destination found."))
                                : ListView.builder(
                                    itemCount: filteredList.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final destination = filteredList[index];
                                      return ListTile(
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.network(
                                            destination.image,
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                                          ),
                                        ),
                                        title: Text(
                                          destination.name,
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                        ),
                                        onTap: () async {
                                          _overlayEntry?.remove();
                                          _overlayEntry = null;
                                          _searchFocusNode.unfocus();

                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TourCategoryView(
                                                name: destination.name,
                                                slug: destination.slug,
                                              ),
                                            ),
                                          );

                                          _searchController.clear();
                                          Future.delayed(const Duration(milliseconds: 100), () {
                                            FocusScope.of(context).requestFocus(_searchFocusNode);
                                            showDestinationSelector(context, allDestinations);
                                          });
                                        },
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(_overlayEntry!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DestinationViewModel>(
      builder: (context, viewModel, child) {
        final allDestinations = viewModel.groupedDestinations.expand((e) => e).toList();
        return SizedBox(
          height: widget.size.height * 0.5,
          width: double.infinity,
          child: Stack(
            children: [
              CarouselSlider(
                items: widget.imgList
                    .map(
                      (item) => SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  height: widget.size.height * 0.5,
                  enableInfiniteScroll: true,
                ),
              ),
              Container(
                width: double.infinity,
                height: widget.size.height * 0.5,
                color: Colors.black.withOpacity(0.2),
              ),
              Positioned(
                top: widget.size.height * 0.06,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(
                      "Tour Packages with TripGoOnline",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.parisienne(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Plan Your Dream Vacation With Us",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: widget.size.height * 0.19,
                left: 20,
                right: 20,
                child: Container(
                  key: _searchBarKey,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onTap: () {
                      if (_overlayEntry == null && allDestinations.isNotEmpty) {
                        showDestinationSelector(context, allDestinations);
                      }
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.grey[700]),
                      hintText: "Enter Your Dream Destination!",
                      hintStyle: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
