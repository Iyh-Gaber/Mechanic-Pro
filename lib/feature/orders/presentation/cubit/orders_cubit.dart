// lib/feature/orders/presentation/cubit/orders_cubit.dart

// lib/feature/orders/presentation/cubit/orders_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/orders/data/models/request/order_model/order_model.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/data.dart';
import 'package:mechpro/feature/orders/data/models/response/order_response/order_response.dart';
import 'package:mechpro/feature/orders/data/repo/order_repo.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';

// لا حاجة لاستيراد OrderResponse هنا إذا لم يتم استخدامها مباشرة
// import '../../data/models/response/order_response/order_response.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo _ordersRepo;

  OrdersCubit(this._ordersRepo) : super(const OrdersInitial());

  // دالة لإنشاء طلب جديد وإرساله إلى الـ API
  Future<void> createNewOrder(OrderModel order) async {
    emit(const CreateOrderLoading()); // إصدار حالة التحميل

    try {
      final response =
          await _ordersRepo.createOrder(order); // استدعاء Repo لإرسال الطلب

      if (response.isSuccess == true) {
        emit(CreateOrderSuccess(
            message: response.successMessage ?? 'Order created successfully!'));
      } else {
        String errorMessage = 'Failed to create order.';
        if (response.errorList != null && response.errorList!.isNotEmpty) {
          errorMessage = response.errorList!.join(', ');
        } else if (response.successMessage != null &&
            response.successMessage!.isNotEmpty) {
          errorMessage = response.successMessage!;
        } else if (response.statusCode != null) {
          errorMessage = 'Failed with status code: ${response.statusCode}';
        }
        emit(CreateOrderError(message: errorMessage));
      }
    } catch (e) {
      emit(CreateOrderError(message: e.toString()));
    }
  }

  // دالة لجلب الطلبات من الـ API
  Future<void> fetchOrdersFromApi() async {
    emit(const LoadingOrders()); // إصدار حالة التحميل لجلب الطلبات

    try {
      // التأكد من أن getOrdersFromApi ترجع List<Data> أو يمكن تحويلها
      final List<DataOrder> orders = await _ordersRepo.getOrdersFromApi();
      emit(OrdersLoaded(orders)); // إصدار حالة النجاح مع قائمة الطلبات
    } catch (e) {
      emit(OrdersError(e.toString())); // إصدار حالة الخطأ إذا فشل الجلب
    }
  }
}
