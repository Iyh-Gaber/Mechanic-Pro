/*import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_color.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}
final List<String> _imagePaths = [
  'assets/images/cooling.png',
  'assets/images/mech.png',
  'assets/images/acc.png',
  'assets/images/spare.png',
  'assets/images/elect.png',
  'assets/images/Diagnostic Scanner Renta.png',
  'assets/images/Brake Pads.png',
  'assets/images/Brake Pads.png',
  'assets/images/offer.PNG'
  
  
];
class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Offers", showLeading: false),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          CustomServiceCard(
            serviceName: '',
            serviceDescription: '',
            imageUrl: _imagePaths[index],
          );
        },

        separatorBuilder: (BuildContext context, int index) => 7.verticalSpace,

        itemCount: 9,
      ),
    );
  }
}
*/
/*
import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

// استيرادات لموديلات العروض والـ Cubit
import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart'; // لاحظ اسم الموديل datum_offers.dart
import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';


import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/routing/app_router.dart';

// استيرادات لمنطق الحجز
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  // قائمة صور افتراضية للعروض إذا لم تكن متوفرة من الـ API
  // يمكنك استبدالها بمسارات صور حقيقية أو استخدام imageUrl من DatumOffer
  final List<String> _defaultImagePaths = [
    'assets/images/cooling.png',
    'assets/images/mech.png',
    'assets/images/acc.png',
    'assets/images/spare.png',
    'assets/images/elect.png',
    'assets/images/Diagnostic Scanner Renta.png',
    'assets/images/Brake Pads.png',
    'assets/images/Brake Pads.png',
    'assets/images/offer.PNG', // تأكد من وجود هذه الصور في assets/images
  ];

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getOffers(); // جلب العروض عند تهيئة الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Offers.tr(), // استخدام الترجمة للعنوان
        showLeading: true, // للسماح بالعودة للشاشة السابقة
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener( // استخدام MultiBlocListener للاستماع لأكثر من Cubit
        listeners: [
          BlocListener<OffersCubit, OffersState>(
            listener: (context, state) {
              if (state is OffersError) { // لاحظ تغيير اسم الحالة إلى OffersError
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)), // لاحظ تغيير اسم الخاصية إلى message
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
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading) { // لاحظ تغيير اسم الحالة إلى OffersLoading
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OffersSuccess) { // لاحظ تغيير اسم الحالة إلى OffersSuccess
                  final List<DatumOffers> offersData = state.offerResponse.data ?? []; // لاحظ استخدام offerResponse.data
                  if (offersData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOffersAvailable.tr()));
                  }
                  return ListView.separated(
                    itemCount: offersData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumOffers offer = offersData[index];

                      // استخدام صورة افتراضية بناءً على الـ index
                      final String imageUrl = _defaultImagePaths[index % _defaultImagePaths.length];

                      // بناء نص الوصف للعرض
                      String offerDescription = offer.description ?? 'No description available';
                      if (offer.discountValue != null) {
                        if (offer.isPercentage == true) {
                          offerDescription += '\n${offer.discountValue!}% Discount';
                        } else {
                          offerDescription += '\nDiscount: ${offer.discountValue!}';
                        }
                      }
                      if (offer.startDate != null && offer.endDate != null) {
                        offerDescription += '\nValid: ${DateFormat('yyyy-MM-dd').format(offer.startDate!)} - ${DateFormat('yyyy-MM-dd').format(offer.endDate!)}';
                      }

                      return CustomServiceCard(
                        imageUrl: imageUrl,
                        serviceName: offer.title ?? 'N/A', // استخدام 'title' كاسم للعرض
                        serviceDescription: offerDescription,
                        onButtonPressed: () {
                          // منطق إنشاء الطلب مباشرة هنا
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الرجاء تسجيل الدخول للاستفادة من العرض.')),
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

                          // استخدام قيم افتراضية للتاريخ والوقت والموقع لعملية الحجز المباشرة
                          final String locationDetails = "Online Offer Redemption";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Offer Redemption: ${offer.title ?? 'Unknown Offer'}", // اسم الخدمة
                            orderSubServices: [
                              OrderRequestSubService(
                                orderSubServiceName: offer.title, // اسم العرض
                                // يمكنك إضافة وصف أو معلومات إضافية هنا إذا كانت موجودة في DatumOffers
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
                          print('تم الضغط على زر الاستفادة من العرض لـ: ${offer.title} - تم إنشاء الطلب مباشرة.');
                        },
                      );
                    },
                  );
                } else if (state is OffersError) { // لاحظ تغيير اسم الحالة إلى OffersError
                  return Center(child: Text(LocaleKeys.ErrorLoadingServices.tr())); // لاحظ تغيير اسم الخاصية إلى message
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
*/
/*

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

// استيرادات لموديلات العروض والـ Cubit
import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';


import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/routing/app_router.dart';

// استيرادات لمنطق الحجز
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  final List<String> _defaultImagePaths = [
    'assets/images/cooling.png',
    'assets/images/mech.png',
    'assets/images/acc.png',
    'assets/images/spare.png',
    'assets/images/elect.png',
    'assets/images/Diagnostic Scanner Renta.png',
    'assets/images/Brake Pads.png',
    'assets/images/Brake Pads.png',
    'assets/images/offer.PNG',
  ];

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Offers.tr(),
        showLeading: true,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OffersCubit, OffersState>(
            listener: (context, state) {
              if (state is OffersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
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
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OffersSuccess) {
                  final List<DatumOffers> offersData = state.offerResponse.data ?? [];
                  if (offersData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOffersAvailable.tr()));
                  }
                  return ListView.separated(
                    itemCount: offersData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumOffers offer = offersData[index];

                      final String imageUrl = _defaultImagePaths[index % _defaultImagePaths.length];

                      String offerDescription = offer.description ?? 'No description available';
                      if (offer.discountValue != null) {
                        if (offer.isPercentage == true) {
                          offerDescription += '\n${offer.discountValue!}% Discount';
                        } else {
                          offerDescription += '\nDiscount: ${offer.discountValue!}';
                        }
                      }
                      if (offer.startDate != null && offer.endDate != null) {
                        offerDescription += '\nValid: ${DateFormat('yyyy-MM-dd').format(offer.startDate!)} - ${DateFormat('yyyy-MM-dd').format(offer.endDate!)}';
                      }

                      return CustomServiceCard(
                        imageUrl: imageUrl,
                        serviceName: offer.title ?? 'N/A',
                        serviceDescription: offerDescription,
                        onButtonPressed: () {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الرجاء تسجيل الدخول للاستفادة من العرض.')),
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

                          final String locationDetails = "Online Offer Redemption";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Offer Redemption: ${offer.title ?? 'Unknown Offer'}",
                            orderSubServices: [
                              OrderRequestSubService(
                                orderSubServiceName: offer.title,
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

                          context.read<OrdersCubit>().createNewOrder(orderRequest);
                          print('تم الضغط على زر الاستفادة من العرض لـ: ${offer.title} - تم إنشاء الطلب مباشرة.');
                        },
                      );
                    },
                  );
                } else if (state is OffersError) {
                  // **التعديل هنا: عرض رسالة الخطأ المستلمة من الـ Cubit**
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.ErrorLoadingServices.tr(), // رسالة عامة
                          style: getTitleStyle(color: AppColors.primaryColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message, // رسالة الخطأ المحددة من الـ Cubit
                          textAlign: TextAlign.center,
                          style: getSmallStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OffersCubit>().getOffers(); // إعادة المحاولة
                          },
                          child: Text(LocaleKeys.TryAgain.tr()), // تأكد من وجود هذا المفتاح في الترجمة
                        ),
                      ],
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
*/
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

// استيرادات لموديلات العروض والـ Cubit
import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';


import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/routing/app_router.dart';

// استيرادات لمنطق الحجز
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  final List<String> _defaultImagePaths = [
    'assets/images/cooling.png',
    'assets/images/mech.png',
    'assets/images/acc.png',
    'assets/images/spare.png',
    'assets/images/elect.png',
    'assets/images/Diagnostic Scanner Renta.png',
    'assets/images/Brake Pads.png',
    'assets/images/Brake Pads.png',
    'assets/images/offer.PNG',
  ];

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Offers.tr(),
        showLeading: true,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OffersCubit, OffersState>(
            listener: (context, state) {
              if (state is OffersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
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
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OffersSuccess) {
                  final List<DatumOffers> offersData = state.offerResponse.data ?? [];
                  if (offersData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOffersAvailable.tr()));
                  }
                  return ListView.separated(
                    itemCount: offersData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumOffers offer = offersData[index];

                      final String imageUrl = _defaultImagePaths[index % _defaultImagePaths.length];

                      String offerDescription = offer.description ?? 'No description available';
                      if (offer.discountValue != null) {
                        // هنا نستخدم .toString() للتأكد من أنها سلسلة نصية
                        if (offer.isPercentage == true) {
                          offerDescription += '\n${offer.discountValue!.toStringAsFixed(0)}% Discount'; // استخدام toStringAsFixed(0) لإزالة الأصفار العشرية إذا كانت القيمة عددًا صحيحًا
                        } else {
                          offerDescription += '\nDiscount: ${offer.discountValue!.toStringAsFixed(2)}'; // استخدام toStringAsFixed(2) للحفاظ على منزلتين عشريتين
                        }
                      }
                      if (offer.startDate != null && offer.endDate != null) {
                        offerDescription += '\nValid: ${DateFormat('yyyy-MM-dd').format(offer.startDate!)} - ${DateFormat('yyyy-MM-dd').format(offer.endDate!)}';
                      }

                      return CustomServiceCard(
                        imageUrl: imageUrl,
                        serviceName: offer.title ?? 'N/A',
                        serviceDescription: offerDescription,
                        onButtonPressed: () {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الرجاء تسجيل الدخول للاستفادة من العرض.')),
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

                          final String locationDetails = "Online Offer Redemption";
                          const bool isHomeService = false;
                          final DateTime orderDateTime = DateTime.now();

                          final orderRequestService = OrderRequestService(
                            orderServiceName: "Offer Redemption: ${offer.title ?? 'Unknown Offer'}",
                            orderSubServices: [
                              OrderRequestSubService(
                                orderSubServiceName: offer.title,
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

                          context.read<OrdersCubit>().createNewOrder(orderRequest);
                          print('تم الضغط على زر الاستفادة من العرض لـ: ${offer.title} - تم إنشاء الطلب مباشرة.');
                        },
                      );
                    },
                  );
                } else if (state is OffersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.ErrorLoadingServices.tr(),
                          style: getTitleStyle(color: AppColors.primaryColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: getSmallStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OffersCubit>().getOffers();
                          },
                          child: Text(LocaleKeys.TryAgain.tr()),
                        ),
                      ],
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
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';

// استيرادات لموديلات العروض والـ Cubit
import 'package:mechpro/feature/offers/data/models/response/offers_response/datum_offers.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_cubit.dart';
import 'package:mechpro/feature/offers/presentation/cubit/offers_state.dart';
// استيراد ويدجت OfferCard الجديد
import 'package:mechpro/feature/offers/presentation/widgets/offer_card.dart';

import 'package:mechpro/core/routing/routes.dart';
// لا حاجة لاستيراد app_router هنا لأنه يستخدم في main.dart

// استيرادات لمنطق الحجز (موجودة بالفعل، ولكن للتأكيد)
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  final List<String> _defaultImagePaths = [
    'assets/images/cooling.png',
    'assets/images/mech.png',
    'assets/images/acc.png',
    'assets/images/spare.png',
    'assets/images/elect.png',
    'assets/images/Diagnostic Scanner Renta.png',
    'assets/images/Brake Pads.png',
    'assets/images/Brake Pads.png',
    'assets/images/offer.PNG',
  ];

  @override
  void initState() {
    super.initState();
    context.read<OffersCubit>().getOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.Offers.tr(),
        showLeading: true,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<OffersCubit, OffersState>(
            listener: (context, state) {
              if (state is OffersError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
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
            child: BlocBuilder<OffersCubit, OffersState>(
              builder: (context, state) {
                if (state is OffersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OffersSuccess) {
                  final List<DatumOffers> offersData = state.offerResponse.data ?? [];
                  if (offersData.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoOffersAvailable.tr()));
                  }
                  return ListView.separated(
                    itemCount: offersData.length,
                    separatorBuilder: (context, index) => 7.verticalSpace,
                    itemBuilder: (context, index) {
                      final DatumOffers offer = offersData[index];
                      final String imageUrl = _defaultImagePaths[index % _defaultImagePaths.length];

                      return OfferCard( // استخدام OfferCard الجديد
                        offer: offer,
                        defaultImageUrl: imageUrl,
                      );
                    },
                  );
                } else if (state is OffersError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.ErrorLoadingServices.tr(),
                          style: getTitleStyle(color: AppColors.primaryColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: getSmallStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<OffersCubit>().getOffers();
                          },
                          child: Text(LocaleKeys.TryAgain.tr()),
                        ),
                      ],
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
