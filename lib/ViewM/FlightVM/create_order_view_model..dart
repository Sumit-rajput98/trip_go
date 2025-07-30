import '../../AppManager/Api/api_service/FlightSearchService/create_order_service.dart';
import '../../Model/FlightM/create_order_model.dart';

class CreateOrderViewModel {
  final CreateOrderService _service = CreateOrderService();
  CreateOrderResponse? _response;

  CreateOrderResponse? get response => _response;

  Future<bool> createOrder(int amount, String traceId) async {
    _response = await _service.createOrder(amount: amount, traceId: traceId);
    return _response != null;
  }
}
