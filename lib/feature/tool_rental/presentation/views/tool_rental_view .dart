/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

class ToolRentalView extends StatefulWidget {
  const ToolRentalView({super.key});

  @override
  State<ToolRentalView> createState() => _ToolRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Jack Rental.png',
  'assets/images/Diagnostic Scanner Renta.png',
];

class _ToolRentalViewState extends State<ToolRentalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tool Rental", showLeading: false),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return CustomServiceCard(
            imageUrl: _imagePaths[index],
            serviceName: '',
            serviceDescription: '',
            onButtonPressed: () {},
          );
        },
        separatorBuilder: (context, index) => 7.verticalSpace,

        itemCount: 2,
      ),
    );
  }
}
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart'; // تأكد من المسار
import 'package:mechpro/core/translate/locale_keys.g.dart'; // تأكد من المسار
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

import 'package:mechpro/feature/tool_rental/data/models/response/tool_rental_response/datum_tool_rental.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_cubit.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_state.dart';
// استخدام نفس الـ CustomServiceCard

import 'package:mechpro/core/routing/app_router.dart'; // تأكد من المسار
import 'package:mechpro/core/routing/routes.dart'; // تأكد من المسار

// استيرادات لمنطق الحجز
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToolRentalView extends StatefulWidget {
  const ToolRentalView({super.key});

  @override
  State<ToolRentalView> createState() => _ToolRentalViewState();
}

class _ToolRentalViewState extends State<ToolRentalView> {
  final List<String> _imagePaths = [
    'assets/images/Jack Rental.png',
    'assets/images/Diagnostic Scanner Renta.png',
    // أضف المزيد من مسارات الصور إذا كان لديك المزيد من الأدوات
  ];

  @override
  void initState() {
    super.initState();
    context.read<ToolRentalCubit>().getToolRental(); // جلب بيانات تأجير الأدوات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.ToolRental.tr(), // استخدام الترجمة للعنوان
        showLeading: true, // للسماح بالعودة للشاشة السابقة
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener(
        // استخدام MultiBlocListener للاستماع لأكثر من Cubit
        listeners: [
          BlocListener<ToolRentalCubit, ToolRentalStates>(
            listener: (context, state) {
              if (state is ToolRentalErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                // يمكنك عرض مؤشر تحميل هنا
              } else if (state is CreateOrderSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                // التوجيه إلى شاشة الطلبات بعد نجاح الطلب
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ToolRentalCubit, ToolRentalStates>(
              builder: (context, state) {
                if (state is ToolRentalLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ToolRentalSuccessState) {
                  final List<DatumToolRental> toolRentalData =
                      state.toolRentalResponse.data ?? [];
                  if (toolRentalData.isEmpty) {
                    return Center(
                      child: Text(LocaleKeys.NoServicesAvailable.tr()),
                    );
                  }
                  return ListView.separated(
                    itemCount: toolRentalData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumToolRental item = toolRentalData[index];

                      // التأكد من أن لديك عدد كافٍ من الصور في _imagePaths
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
                              const SnackBar(
                                content: Text(
                                  'الرجاء تسجيل الدخول لإجراء طلب.',
                                ),
                              ),
                            );
                            return;
                          }

                          final String? firebaseUserId = user.uid;
                          if (firebaseUserId == null) {
                            print(
                              'ERROR: Firebase User ID is null. Cannot create order.',
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'خطأ: لم يتم العثور على معرف المستخدم. الرجاء تسجيل الدخول مرة أخرى.',
                                ),
                              ),
                            );
                            return;
                          }

                          // استخدام قيم افتراضية للتاريخ والوقت والموقع لعملية الحجز المباشرة
                          final String locationDetails =
                              "Online Rental - Pickup at Main Branch";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Tool Rental", // اسم الخدمة
                            orderSubServices: [
                              OrderRequestSubService(
                                orderSubServiceName: item.subServiceName,
                              ),
                            ],
                          );

                          final orderRequest = OrderRequest(
                            userId: firebaseUserId,
                            userName:
                                user.displayName ??
                                user.email ??
                                'Unknown User',
                            orderServices: [orderRequestService],
                            maintenanceCenter: locationDetails,
                            isHomeService: isHomeService,
                            orderDate: orderDateTime,
                          );

                          // استدعاء Cubit لإنشاء الطلب
                          context.read<OrdersCubit>().createNewOrder(
                            orderRequest,
                          );
                          print(
                            'تم الضغط على زر الحجز لـ: Tool Rental - ${item.subServiceName} - تم إنشاء الطلب مباشرة.',
                          );
                        },
                      );
                    },
                  );
                } else if (state is ToolRentalErrorState) {
                  return Center(
                    child: Text(
                      LocaleKeys.ErrorLoadingServices.tr(args: [state.error]),
                    ),
                  );
                }
                return const Center(
                  child: Text(''), // لا حاجة لهذا النص بعد الآن
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
