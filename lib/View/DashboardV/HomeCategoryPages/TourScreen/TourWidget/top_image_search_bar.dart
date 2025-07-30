import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_go/View/DashboardV/HomeCategoryPages/TourScreen/tour_category_view.dart';

import '../../../../../Model/TourM/destination_model.dart';

class TopImageSearchBar extends StatefulWidget {
  final String category;
  final TextEditingController fromController;
  final TextEditingController toController;
  final List<DestinationModel> allDestinations;

  const TopImageSearchBar({
    super.key,
    required this.fromController,
    required this.category,
    required this.toController,
    required this.allDestinations,
  });

  @override
  State<TopImageSearchBar> createState() => _TopImageSearchBarState();
}

class _TopImageSearchBarState extends State<TopImageSearchBar> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _toFieldKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _overlayEntry?.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showDestinationOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }

    final RenderBox renderBox = _toFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    List<DestinationModel> filteredList = List.from(widget.allDestinations);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _removeOverlay,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: offset.dy + size.height + 10,
                width: MediaQuery.of(context).size.width - 32,
                child: Material(
                  color: Colors.transparent,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      _searchController.addListener(() {
                        setState(() {
                          filteredList = widget.allDestinations
                              .where((d) => d.name
                                  .toLowerCase()
                                  .contains(_searchController.text.toLowerCase()))
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
                                              errorBuilder: (ctx, err, stack) =>
                                                  const Icon(Icons.broken_image),
                                            ),
                                          ),
                                          title: Text(destination.name,
                                              style: const TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontWeight: FontWeight.w500)),
                                          onTap: () async {
                                            widget.toController.text = destination.name;
                                            _removeOverlay();
                                            FocusScope.of(context).unfocus();
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => TourCategoryView(
                                                  name: destination.name,
                                                  slug: destination.slug,
                                                ),
                                              ),
                                            );
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
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    FocusScope.of(context).requestFocus(_searchFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.network(
            'https://d2qa7a8q0vuocm.cloudfront.net/images/11120520230328075635.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 30,
          left: 16,
          right: 16,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.category,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CompositedTransformTarget(
                link: _layerLink,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("From", style: TextStyle(fontSize: 12, fontFamily: 'poppins')),
                            TextField(
                              controller: widget.fromController,
                              decoration: const InputDecoration(
                                hintText: "Select Location",
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: const TextStyle(fontSize: 15, fontFamily: 'poppins'),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("To", style: TextStyle(fontSize: 12, fontFamily: 'poppins', fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => _showDestinationOverlay(context),
                              child: AbsorbPointer(
                                child: TextField(
                                  key: _toFieldKey,
                                  controller: _searchController,
                                  focusNode: _searchFocusNode,
                                  decoration: InputDecoration(
                                    hintText: widget.category,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: const TextStyle(fontSize: 15, fontFamily: 'poppins'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          print('Searching from ${widget.fromController.text} to ${widget.toController.text}');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search, color: Colors.white, size: 25),
                        ),
                      ),
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
}
