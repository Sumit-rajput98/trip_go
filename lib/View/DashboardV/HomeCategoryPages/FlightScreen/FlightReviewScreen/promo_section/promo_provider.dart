import 'package:flutter/cupertino.dart';

class PromoProvider extends ChangeNotifier {
  String _selectedCoupon = "";
  bool _isCouponApplied = false;

  String get selectedCoupon => _selectedCoupon;
  bool get isCouponApplied => _isCouponApplied;

  void applyCoupon(String code) {
    _selectedCoupon = code;
    _isCouponApplied = true;
    notifyListeners();
  }

  void removeCoupon() {
    _selectedCoupon = "";
    _isCouponApplied = false;
    notifyListeners();
  }

}
