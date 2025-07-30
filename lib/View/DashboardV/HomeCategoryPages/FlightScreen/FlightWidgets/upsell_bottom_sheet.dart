import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Model/FlightM/selected_upsell_class.dart';
import '../../../../../Model/FlightM/upsell_model.dart';
import '../../../../../ViewM/FlightVM/upsell_view_model.dart';
import '../../../../../constants.dart';

class UpsellBottomSheet extends StatelessWidget {
  final String traceId;
  final String resultIndex;

  const UpsellBottomSheet({
    super.key,
    required this.traceId,
    required this.resultIndex,
  });

  @override
  Widget build(BuildContext context) {
    final upsellVM = Provider.of<UpsellViewModel>(context);

    if (upsellVM.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (upsellVM.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: Text(upsellVM.errorMessage!)),
      );
    }

    final List<Result>? resultList = upsellVM.upsellModel?.data?.results;
    if (resultList == null || resultList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: Text("No alternate fares available.")),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Flight Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 24),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  final result = resultList[index];
                  final fare = result.fare?.publishedFare?.floor() ?? 0;
                  final isRefundable = result.isRefundable ?? false;
                  final cancellation = result.fare?.totalSpecialServiceCharges ?? 0;
                  final dateChange = result.fare?.totalSeatCharges ?? 0;
                  final isPanRequired = result.isPanRequiredAtBook ?? false;
                  final isPassportRequired = result.isPassportRequiredAtBook ?? false;
      
                  final segment = result.segments?[0][0];
                  final airline = segment?.airline;
                  final origin = segment?.origin?.airport?.airportCode ?? '';
                  final destination = segment?.destination?.airport?.airportCode ?? '';
                  final depTime = segment?.origin?.depTime;
                  final arrTime = segment?.destination?.arrTime;
                  final duration = segment?.duration ?? 0;
      
                  return GestureDetector(
                    onTap: (){
                      Navigator.pop(
                        context,
                        SelectedUpsellData(result: result, price: fare),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue.shade100),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blue.shade50,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Route and Time
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$origin → $destination",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'poppins'),
                              ),
                              Text(
                                "${depTime?.hour.toString().padLeft(2, '0')}:${depTime?.minute.toString().padLeft(2, '0')} - ${arrTime?.hour.toString().padLeft(2, '0')}:${arrTime?.minute.toString().padLeft(2, '0')}",
                                style: const TextStyle(color: Colors.black87, fontFamily: 'poppins'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${(duration ~/ 60)}h ${(duration % 60)}m • ${segment?.stopPointArrivalTime == null ? 'non-stop' : 'stop'}",
                            style: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
                          ),
                          const SizedBox(height: 12),

                          // Fare info
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                // Top fare row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("ECO VALUE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Row(
                                      children: [
                                        Text(
                                          "₹$fare",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: constants.themeColor2, fontFamily: 'poppins'),
                                        ),
                                        const SizedBox(width: 8),
                                        if (isRefundable)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text("Refundable", style: TextStyle(color: Colors.green)),
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(height: 24),

                                // Features
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 12,
                                  children: [
                                    _iconText(Icons.card_travel, "Cabin Bag\n7 Kgs"),
                                    _iconText(Icons.work, "Check-in\n25 Kgs"),
                                    _iconText(Icons.cancel, "Cancellation\n₹$cancellation onwards"),
                                    _iconText(Icons.event_repeat, "Date Change\n₹$dateChange onwards"),
                                    if (isPanRequired) _iconText(Icons.perm_identity, "PAN Card\nRequired"),
                                    if (isPassportRequired) _iconText(Icons.flight, "Passport\nRequired"),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // SizedBox(
                                //   width: double.infinity,
                                //   child: ElevatedButton(
                                //     onPressed: () {
                                //       Navigator.pop(
                                //         context,
                                //         SelectedUpsellData(result: result, price: fare),
                                //       );
                                //     },
                                //     child: const Text("Select"),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return SizedBox(
      width: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
