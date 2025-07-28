/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/translate/app_translate.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../widgets/custom_service_card.dart';

class SellingOriginalPartsView extends StatelessWidget {
  const SellingOriginalPartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.OtherServices.tr(),
            style: getBodyStyle(color: AppColors.whColor)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              CustomServiceCard(
                imageUrl: 'assets/images/Brake Pads.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
              CustomServiceCard(
                imageUrl: 'assets/images/Oil Filter.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
              CustomServiceCard(
                imageUrl: 'assets/images/Air Filter.png',
                serviceName: 'gjhhjhj',
                serviceDescription:
                    'rgrtuyikuydtjndtyldddddrwesdeerhfgktythrsswtgt',
                onButtonPressed: () {},
              ),
              7.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد flutter_bloc
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/translate/app_translate.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/models/response/selling_response/datumSelling.dart';
import '../cubit/selling_cubit.dart'; // استيراد Cubit
import '../cubit/selling_state.dart'; // استيراد States
import '../widgets/custom_service_card.dart';
// استيراد SellingResponse

class SellingOriginalPartsView extends StatefulWidget {
  const SellingOriginalPartsView({super.key});

  @override
  State<SellingOriginalPartsView> createState() => _SellingOriginalPartsViewState();
}

class _SellingOriginalPartsViewState extends State<SellingOriginalPartsView> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند تهيئة الودجت
    context.read<SellingCubit>().getSelling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(LocaleKeys.OtherServices.tr(),
            style: getBodyStyle(color: AppColors.whColor)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SellingCubit, SellingStates>(
            builder: (context, state) {
              if (state is SellingLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SellingSuccessState) {
                final List<DatumSelling> sellingData = state.sellingResponse.data ?? [];
                if (sellingData.isEmpty) {
                  return Center(
                    child: Text('No data available'), // أضف ترجمة لعدم وجود بيانات
                  );
                }
                return ListView.separated(
                  itemCount: sellingData.length,
                  separatorBuilder: (context, index) => 7.verticalSpace,
                  itemBuilder: (context, index) {
                    final DatumSelling item = sellingData[index];
                    return CustomServiceCard(
                      // قد تحتاج إلى تعديل imageUrl بناءً على استجابة الـ API الخاصة بك
                      // بافتراض صورة افتراضية أو التعامل مع imageUrl فارغ/null
                      imageUrl: 'assets/images/Brake Pads.png', // صورة بديلة
                      serviceName: item.subServiceName ?? 'N/A',
                      serviceDescription: item.description ?? 'No description available',
                      onButtonPressed: () {
                        // تنفيذ التنقل أو إجراء محدد عند الضغط على الزر
                        print('Service ${item.subServiceName} button pressed');
                      },
                    );
                  },
                );
              } else if (state is SellingErrorState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return const Center(child: Text('Press the button to load data.')); // رسالة الحالة الأولية
            },
          ),
        ),
      ),
    );
  }
}
*/
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/translate/app_translate.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/models/response/selling_response/datumSelling.dart';
import '../cubit/selling_cubit.dart';
import '../cubit/selling_state.dart';
import '../widgets/custom_service_card.dart';

class SellingOriginalPartsView extends StatefulWidget {
  const SellingOriginalPartsView({super.key});

  @override
  State<SellingOriginalPartsView> createState() =>
      _SellingOriginalPartsViewState();
}

class _SellingOriginalPartsViewState extends State<SellingOriginalPartsView> {
  final List<String> _imagePaths = [
    'assets/images/Brake Pads.png',
    'assets/images/Oil Filter.png',
    'assets/images/Air Filter.png',
  ];

  @override
  void initState() {
    super.initState();
    context.read<SellingCubit>().getSelling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.SellingOriginalParts.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SellingCubit, SellingStates>(
            builder: (context, state) {
              if (state is SellingLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SellingSuccessState) {
                final List<DatumSelling> sellingData =
                    state.sellingResponse.data ?? [];
                if (sellingData.isEmpty) {
                  return Center(child: Text('No data available'.tr()));
                }
                return ListView.separated(
                  itemCount: sellingData.length,
                  separatorBuilder: (context, index) => 7.verticalSpace,
                  itemBuilder: (context, index) {
                    final DatumSelling item = sellingData[index];

                    final String imageUrl =
                        _imagePaths[index % _imagePaths.length];

                    return CustomServiceCard(
                      imageUrl: imageUrl,
                      serviceName: item.subServiceName ?? 'N/A',
                      serviceDescription:
                          item.description ?? 'No description available',
                      onButtonPressed: () {
                        print('Service ${item.subServiceName} button pressed');
                      },
                    );
                  },
                );
              } else if (state is SellingErrorState) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(
                child: Text('Press the button to load data.'),
              );
            },
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/core/widgets/section_header.dart'; // ستبقى هنا إذا كنت تستخدمها في مكان آخر، وإلا يمكن إزالتها
import 'package:mechpro/feature/Selling_%20original_spare%20parts/data/models/response/selling_response/datumSelling.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_cubit.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/cubit/selling_state.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';



// استيرادات لمنطق الحجز
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

// لم تعد هذه الاستيرادات مستخدمة بعد إزالة الـ dialog
// import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
// import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';


class SellingOriginalPartsView extends StatefulWidget {
  const SellingOriginalPartsView({super.key});

  @override
  State<SellingOriginalPartsView> createState() =>
      _SellingOriginalPartsViewState();
}

class _SellingOriginalPartsViewState extends State<SellingOriginalPartsView> {
  final List<String> _imagePaths = [
    'assets/images/Brake Pads.png',
    'assets/images/Oil Filter.png',
    'assets/images/Air Filter.png',
    // أضف المزيد من مسارات الصور إذا كان لديك المزيد من قطع الغيار
  ];

  @override
  void initState() {
    super.initState();
    context.read<SellingCubit>().getSelling();
  }

  // تم إزالة دالة _selectDate() ومتغيرات الحالة المتعلقة بالـ dialog
  // (مثل _selectedDate, _selectedTime, _selectedLocationType, _selectedBranch, _hasContactedForLocation, _addressController)
  // بالإضافة إلى قوائم _branches و _availableTimes
  // و دالة _showBookingDialog() بالكامل.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.SellingOriginalParts.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: MultiBlocListener( // استخدام MultiBlocListener للاستماع لأكثر من Cubit
        listeners: [
          BlocListener<SellingCubit, SellingStates>(
            listener: (context, state) {
              if (state is SellingErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                // يمكنك عرض مؤشر تحميل هنا
              } else if (state is CreateOrderSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // التوجيه إلى شاشة الطلبات بعد نجاح الطلب
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SellingCubit, SellingStates>(
              builder: (context, state) {
                if (state is SellingLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SellingSuccessState) {
                  final List<DatumSelling> sellingData =
                      state.sellingResponse.data ?? [];
                  if (sellingData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOrdersYet.tr()));
                  }
                  return ListView.separated(
                    itemCount: sellingData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumSelling item = sellingData[index];

                      final String imageUrl =
                          _imagePaths[index % _imagePaths.length];

                      return CustomServiceCard(
                        imageUrl: imageUrl,
                        serviceName: item.subServiceName ?? 'N/A',
                        serviceDescription:
                            item.description ?? 'No description available',
                        onButtonPressed: () {
                          // منطق إنشاء الطلب مباشرة هنا
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الرجاء تسجيل الدخول لإجراء طلب.')),
                            );
                            return;
                          }

                          final String? firebaseUserId = user.uid;
                          if (firebaseUserId == null) {
                            print('ERROR: Firebase User ID is null. Cannot create order.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('خطأ: لم يتم العثور على معرف المستخدم. الرجاء تسجيل الدخول مرة أخرى.')),
                            );
                            return;
                          }

                          // استخدام قيم افتراضية للتاريخ والوقت والموقع لعملية الشراء المباشرة
                          final String locationDetails = "Online Purchase - Pickup at Main Branch";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Selling Original Spare Parts", // اسم الخدمة
                            orderSubServices: [
                              OrderRequestSubService(
                                orderSubServiceName: item.subServiceName,
                              )
                            ],
                          );

                          final orderRequest = OrderRequest(
                            userId: firebaseUserId,
                            userName: user.displayName ?? user.email ?? 'Unknown User',
                            orderServices: [orderRequestService],
                            maintenanceCenter: locationDetails,
                            isHomeService: isHomeService,
                            orderDate: orderDateTime,
                          );

                          // استدعاء Cubit لإنشاء الطلب
                          context.read<OrdersCubit>().createNewOrder(orderRequest);
                          print('تم الضغط على زر الشراء لـ: ${item.subServiceName} - تم إنشاء الطلب مباشرة.');
                        },
                      );
                    },
                  );
                } else if (state is SellingErrorState) {
                  return Center(child: Text(LocaleKeys.ErrorLoadingServices.tr(args: [state.error])));
                }
                return const Center(
                  child: Text(''),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}