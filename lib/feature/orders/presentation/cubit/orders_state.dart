// lib/feature/orders/presentation/cubit/orders_state.dart



import 'package:mechpro/feature/orders/data/models/response/datum_order.dart';

abstract class OrdersState {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

// حالات جلب الطلبات
class LoadingOrders extends OrdersState {
  const LoadingOrders();
}

class OrdersLoaded extends OrdersState {
  final List<DatumOrder> orders;
  const OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;
  const OrdersError(this.message);
}

// حالات إنشاء الطلبات
class CreateOrderLoading extends OrdersState {
  const CreateOrderLoading();
}

class CreateOrderSuccess extends OrdersState {
  final String message;
  const CreateOrderSuccess({required this.message});
}

class CreateOrderError extends OrdersState {
  final String message;
  const CreateOrderError({required this.message});
}
