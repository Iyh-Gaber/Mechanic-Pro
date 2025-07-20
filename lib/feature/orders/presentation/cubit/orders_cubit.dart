
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/home/data/models/response/main_services_response/datum.dart';
import 'package:mechpro/feature/orders/data/models/order_model.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class OrdersCubit extends Cubit<OrdersState> {
  // تذكر: إذا كنت ستنتقل لاستخدام API، يجب أن يستقبل هذا الـ Cubit الـ Repository هنا
  // OrdersCubit(this._ordersRepo) : super(OrdersInitial());
  OrdersCubit() : super(OrdersInitial()); // حافظ على هذا Constructor مؤقتًا إذا لم تكن قد أضفت الـ Repository بعد


  List<OrderModel> _currentOrders = []; // قائمة لتخزين الطلبات محليًا
  final Uuid _uuid = Uuid(); // لتوليد معرفات فريدة

  // دالة لحفظ طلب جديد
  Future<void> saveNewOrder({
    required List<Datum> selectedServices, // تأكد من أن Datum مستوردة بشكل صحيح
    required DateTime selectedDate,
    required TimeOfDay selectedTime,
    required String locationType,
    String? locationDetails,
  }) async {
    emit(OrdersLoading());
    try {
      final newOrder = OrderModel(
        orderId: _uuid.v4(), // توليد معرف فريد للطلب
        selectedServices: selectedServices, // هنا OrderModel يستخدم Datum
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        locationType: locationType,
        locationDetails: locationDetails,
        createdAt: DateTime.now(),
        status: 'Pending', // حالة مبدئية
      );

      _currentOrders.add(newOrder); // أضف الطلب إلى القائمة المحلية

      // هذا الجزء من الكود يستخدم SharedPreferences، وهو مؤقت
      // في تطبيق حقيقي، سترسل هذا الطلب إلى API عبر Repository
      final prefs = await SharedPreferences.getInstance();
      List<String> ordersJson = _currentOrders.map((order) => jsonEncode(order.toJson())).toList();
      await prefs.setStringList('user_orders', ordersJson);

      emit(OrderSavedSuccess());
      getOrders(); // جلب الطلبات بعد الحفظ للتحديث

    } catch (e) {
      emit(OrderSavedError('Failed to save order: ${e.toString()}'));
    }
  }

  // دالة لجلب الطلبات المحفوظة
  Future<void> getOrders() async {
    emit(OrdersLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? ordersJson = prefs.getStringList('user_orders');

      if (ordersJson != null) {
        _currentOrders = ordersJson
            .map((jsonString) => OrderModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>))
            .toList();
      } else {
        _currentOrders = []; // لا توجد طلبات سابقة
      }

      emit(OrdersSuccess(List.from(_currentOrders))); // إرسال نسخة من القائمة

    } catch (e) {
      emit(OrdersError('Failed to load orders: ${e.toString()}'));
    }
  }
}