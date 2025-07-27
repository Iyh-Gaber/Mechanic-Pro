/* import 'package:easy_localization/easy_localization.dart';
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
import '../widgets/order_card.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();

    context.read<OrdersCubit>().fetchOrdersFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          LocaleKeys.MyOrders.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
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
                final orderData = state.orders[index];
                return OrderCard(orderData: orderData);
              },
            );
          } else if (state is CreateOrderLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is CreateOrderSuccess) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 80, color: Colors.green),
                  16.verticalSpace,
                  Text(
                      'Last order created: ${state.message}. Please refresh to see it.',
                      style: getSmallStyle(color: Colors.green)),
                  16.verticalSpace,
                  ElevatedButton(
                    onPressed: () =>
                        context.read<OrdersCubit>().fetchOrdersFromApi(),
                    child: const Text('Refresh Orders'),
                  ),
                ],
              ),
            );
          } else if (state is CreateOrderError) {
            return Center(
              child: Text('Creation Error: ${state.message}',
                  style: const TextStyle(color: Colors.red)),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

*/

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
import '../widgets/order_card.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();
    // عند تهيئة الشاشة، نقوم بجلب الطلبات
    context.read<OrdersCubit>().fetchOrdersFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          LocaleKeys.MyOrders.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is LoadingOrders) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is OrdersError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
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
            // 🌟🌟🌟 هنا التعديل الرئيسي: نغلف ListView.builder بـ RefreshIndicator 🌟🌟🌟
            return RefreshIndicator(
              // هذه الدالة يتم استدعاؤها عندما يسحب المستخدم الشاشة للتحديث
              onRefresh: () async {
                // نطلب من الـ Cubit جلب الطلبات من الـ API مرة أخرى
                await context.read<OrdersCubit>().fetchOrdersFromApi();
              },
              color: AppColors.primaryColor, // لون مؤشر التحديث
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final orderData = state.orders[index];
                  return OrderCard(orderData: orderData);
                },
              ),
            );
          } else if (state is CreateOrderLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is CreateOrderSuccess) {
            // 🌟🌟🌟 هنا يمكنك إزالة زر "Refresh Orders" إذا كنت تعتمد على السحب للتحديث 🌟🌟🌟
            // أو يمكنك تركه كخيار إضافي
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 80,
                    color: Colors.green,
                  ),
                  16.verticalSpace,
                  Text(
                    'Last order created: ${state.message}. Please pull down to refresh.', // تغيير الرسالة
                    style: getSmallStyle(color: Colors.green),
                  ),
                  16.verticalSpace,
                  // يمكنك إزالة هذا الزر إذا كنت تفضل الاعتماد على السحب للتحديث فقط
                  // ElevatedButton(
                  //   onPressed: () =>
                  //       context.read<OrdersCubit>().fetchOrdersFromApi(),
                  //   child: const Text('Refresh Orders'),
                  // ),
                ],
              ),
            );
          } else if (state is CreateOrderError) {
            return Center(
              child: Text(
                'Creation Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // حالة افتراضية أو عند التهيئة الأولية
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
