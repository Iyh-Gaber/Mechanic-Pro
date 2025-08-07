

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/manage_padding.dart';

import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

import 'package:mechpro/feature/tool_rental/data/models/response/tool_rental_response/datum_tool_rental.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_cubit.dart';
import 'package:mechpro/feature/tool_rental/presentation/cubit/tool_rental_state.dart';

import 'package:mechpro/core/routing/routes.dart'; 


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
   
  ];

  @override
  void initState() {
    super.initState();
    context.read<ToolRentalCubit>().getToolRental(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.ToolRental.tr(), 
        showLeading: false,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener(
      
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
            
              } else if (state is CreateOrderSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
               
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
            padding: 17.all,

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

                     
                      final String imageUrl =
                          _imagePaths[index % _imagePaths.length];

                      return CustomServiceCard(
                        imageUrl: imageUrl,
                        serviceName: item.subServiceName ?? 'N/A',
                        serviceDescription:
                            item.description ?? 'No description available',
                        onButtonPressed: () {
                         
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

                        
                          final String locationDetails =
                              "Online Rental - Pickup at Main Branch";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Tool Rental", 
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
