
import 'package:mechpro/feature/orders/data/models/order_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders; 
  OrdersSuccess(this.orders);
}

class OrdersError extends OrdersState {
  final String message;
  OrdersError(this.message);
}

class OrderSavedSuccess extends OrdersState {}

class OrderSavedError extends OrdersState {
  final String message;
  OrderSavedError(this.message);
}