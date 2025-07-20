 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/orders/data/models/order_model.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';

import '../../../../core/routing/routes.dart';
class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();
    // قم بجلب الطلبات عند تهيئة الشاشة
    context.read<OrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          LocaleKeys.MyOrders.tr(), 
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          } else if (state is OrdersError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
          } else if (state is OrdersSuccess) {
            if (state.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment, size: 80, color: AppColors.grColor),
                    16.verticalSpace,
                    Text(
                      LocaleKeys.NoOrdersYet.tr(),
                      style: getSmallStyle(color: AppColors.grColor),
                    ),
                    16.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        // ارجع لشاشة طلب الخدمات لإنشاء طلب جديد
                       // Navigator.of(context).pop(); // أو استخدم pushNamedToAndRemoveUntil للعودة لـ home
                     context.pushNamed(Routes.layoutView);
                     
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whColor,
                      ),
                      child: Text(LocaleKeys.MakeNewOrder.tr()), 
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderCard(order: order); // استخدم ويدجت OrderCard لعرض كل طلب
              },
            );
          }
          return const SizedBox.shrink(); // Fallback
        },
      ),
    );
  }
}

// OrderCard Widget
class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${LocaleKeys.OrderId.tr()}: ${order.orderId.substring(0, 8)}...', // أضف OrderId
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,
            Text(
              '${LocaleKeys.Status.tr()}: ${order.status}', // أضف Status
              style: getSmallStyle(color: _getStatusColor(order.status)),
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.Services.tr(),
             // '${LocaleKeys.Services.tr()}: ${order.selectedServices.map((s) => s.subServiceName).join(', ')}', // أضف Services
            style: getBodyStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,
            Text(
              '${LocaleKeys.Date.tr()}: ${DateFormat('yyyy-MM-dd').format(order.selectedDate)}', // أضف Date
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,
            Text(
              '${LocaleKeys.Time.tr()}: ${order.selectedTime.format(context)}', // أضف Time
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            4.verticalSpace,
            Text(
              '${LocaleKeys.Location.tr()}: ${order.locationType == 'my_location' ? LocaleKeys.MyLocation.tr() : LocaleKeys.OurBranches.tr()}', // أضف Location, MyLocation, OurBranches
              style: getSmallStyle(color: AppColors.blackColor),
            ),
            if (order.locationDetails != null && order.locationDetails!.isNotEmpty)
              Text(
                '${LocaleKeys.Details.tr()}: ${order.locationDetails}', // أضف Details
                style: getSmallStyle(color: AppColors.blackColor),
              ),
            8.verticalSpace,
            Text(
              '${LocaleKeys.RequestedAt.tr()}: ${DateFormat('yyyy-MM-dd HH:mm').format(order.createdAt)}', // أضف RequestedAt
              style: getSmallStyle(color: AppColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Confirmed':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}


/*
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Orders'),
      ),
      body: Center(
        child: Text('Orders'),
      ),
    );
  }
}
*/