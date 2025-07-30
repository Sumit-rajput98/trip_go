import 'package:flutter/material.dart';

import '../../../../../Model/BusM/bus_search_model.dart';

enum BusSortType {
  departure,
  duration,
  price,
}

enum SortOrder {
  ascending,
  descending,
}

class BusSortHelper {
  static List<BusResult> getSortedBusResults({
    required List<BusResult> results,
    required BusSortType sortType,
    required SortOrder sortOrder,
  }) {
    List<BusResult> sorted = List.from(results); // prevent mutating original

    switch (sortType) {
      case BusSortType.departure:
        sorted.sort((a, b) {
          final aTime = DateTime.parse(a.departureTime);
          final bTime = DateTime.parse(b.departureTime);
          return sortOrder == SortOrder.ascending
              ? aTime.compareTo(bTime)
              : bTime.compareTo(aTime);
        });
        break;

      case BusSortType.duration:
        sorted.sort((a, b) {
          final aDuration = DateTime.parse(a.arrivalTime)
              .difference(DateTime.parse(a.departureTime));
          final bDuration = DateTime.parse(b.arrivalTime)
              .difference(DateTime.parse(b.departureTime));
          return sortOrder == SortOrder.ascending
              ? aDuration.compareTo(bDuration)
              : bDuration.compareTo(aDuration);
        });
        break;

      case BusSortType.price:
        sorted.sort((a, b) {
          final aPrice = a.busPrice.basePrice ?? 0.0;
          final bPrice = b.busPrice.basePrice ?? 0.0;
          return sortOrder == SortOrder.ascending
              ? aPrice.compareTo(bPrice)
              : bPrice.compareTo(aPrice);
        });
        break;
    }

    return sorted;
  }

}


