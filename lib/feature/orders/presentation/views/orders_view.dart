// lib/feature/orders/presentation/views/orders_view.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/order_card.dart'; // استيراد ويدجت OrderCard

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
    context.read<OrdersCubit>().fetchOrdersFromApi();
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
          if (state is LoadingOrders) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is OrdersError) {
            return Center(
              child: Text('Error: ${state.message}',
                  style: const TextStyle(color: Colors.red)),
            );
          } else if (state is OrdersLoaded) {
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
                        context.pushNamed(Routes.layoutView); // تأكد من أن هذا هو المسار الصحيح لشاشة إنشاء الطلب
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
                final orderData = state.orders[index];
                return OrderCard(orderData: orderData); // تمرير كائن Data
              },
            );
          }
          // حالات إنشاء الطلب يمكن عرضها بشكل مختلف أو التعامل معها
          // هنا نعرض رسالة بسيطة أو يمكن تجاهل هذه الحالات إذا لم تكن ذات صلة بعرض قائمة الطلبات
          else if (state is CreateOrderLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is CreateOrderSuccess) {
            // يمكن عرض SnackBar أو رسالة مؤقتة هنا
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
                  16.verticalSpace,
                  Text('Last order created: ${state.message}. Please refresh to see it.', style: getSmallStyle(color: Colors.green)),
                  16.verticalSpace,
                  ElevatedButton(
                    onPressed: () => context.read<OrdersCubit>().fetchOrdersFromApi(),
                    child: const Text('Refresh Orders'),
                  ),
                ],
              ),
            );
          } else if (state is CreateOrderError) {
            return Center(
              child: Text('Creation Error: ${state.message}', style: const TextStyle(color: Colors.red)),
            );
          }
          // الحالة الأولية أو أي حالة غير متوقعة
          return const Center(child: CircularProgressIndicator()); // أو SizedBox.shrink()
        },
      ),
    );
  }
}