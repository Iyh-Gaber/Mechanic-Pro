/*import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

class CarRentalView extends StatefulWidget {
  const CarRentalView({super.key});

  @override
  State<CarRentalView> createState() => _CarRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Sedan Car.png',
  'assets/images/SUV Car.png',
];

class _CarRentalViewState extends State<CarRentalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Car Rental", showLeading: false),
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
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد مكتبة flutter_bloc
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_cubit.dart'; // استيراد الـ Cubit الخاص بك
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_state.dart'; // استيراد الحالات الخاصة بك

class CarRentalView extends StatefulWidget {
  const CarRentalView({super.key});

  @override
  State<CarRentalView> createState() => _CarRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Sedan Car.png',
  'assets/images/SUV Car.png',
  // تأكد من أن مسارات الصور هذه صحيحة وموجودة في مجلد الأصول الخاص بك
];

class _CarRentalViewState extends State<CarRentalView> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند تهيئة الودجت
    context.read<CarRentalCubit>().getCarRental();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Car Rental", showLeading: false),
      body: BlocConsumer<CarRentalCubit, CarRentalStates>(
        listener: (context, state) {
          if (state is CarRentalErrorState) {
            // عرض رسالة خطأ إذا حدث خطأ ما
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is CarRentalLoadingState) {
            // عرض مؤشر التحميل أثناء جلب البيانات
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarRentalSuccessState) {
            // عرض البيانات عند تحميلها بنجاح
            final carRentalServices = state.carRentalResponse.data;

            if (carRentalServices == null || carRentalServices.isEmpty) {
              return const Center(child: Text('لا توجد خدمات تأجير سيارات متاحة.'));
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                // التأكد من أن الفهرس ضمن حدود _imagePaths
                final imageIndex = index % _imagePaths.length;
                return CustomServiceCard(
                  imageUrl: _imagePaths[imageIndex], // استخدام نمط متكرر للصور
                  serviceName: carRentalServices[index].subServiceName ?? 'غير متوفر',
                  serviceDescription: carRentalServices[index].description ?? 'لا يوجد وصف متاح.',
                  onButtonPressed: () {
                    // هذا سيكون لوظيفة الحجز لاحقًا
                    print('تم الضغط على زر الحجز لـ: ${carRentalServices[index].subServiceName}');
                  },
                );
              },
              separatorBuilder: (context, index) => 7.verticalSpace,
              itemCount: carRentalServices.length, // استخدام العدد الفعلي من API
            );
          } else if (state is CarRentalErrorState) {
            // عرض رسالة خطأ إذا فشل الجلب
            return Center(child: Text('خطأ: ${state.error}'));
          }
          // الحالة الأولية أو حالة غير متوقعة
          return const Center(child: Text('اضغط لتحميل خدمات تأجير السيارات.'));
        },
      ),
    );
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد مكتبة flutter_bloc
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_cubit.dart'; // استيراد الـ Cubit الخاص بك
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_state.dart'; // استيراد الحالات الخاصة بك
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart'; // استيراد موديل طلب الأوردر
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart'; // استيراد موديل خدمة الأوردر
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart'; // استيراد موديل الخدمة الفرعية للأوردر
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart'; // استيراد الـ Cubit الخاص بالأوردرات
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart'; // استيراد حالات الـ Cubit الخاص بالأوردرات
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth للحصول على معلومات المستخدم
import 'package:mechpro/core/routing/routes.dart'; // لاستخدام الـ routes

class CarRentalView extends StatefulWidget {
  const CarRentalView({super.key});

  @override
  State<CarRentalView> createState() => _CarRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Sedan Car.png',
  'assets/images/SUV Car.png',
  // تأكد من أن مسارات الصور هذه صحيحة وموجودة في مجلد الأصول الخاص بك
];

class _CarRentalViewState extends State<CarRentalView> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند تهيئة الودجت
    context.read<CarRentalCubit>().getCarRental();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Car Rental", showLeading: false),
      body: MultiBlocListener( // استخدام MultiBlocListener للاستماع لأكثر من Cubit
        listeners: [
          BlocListener<CarRentalCubit, CarRentalStates>(
            listener: (context, state) {
              if (state is CarRentalErrorState) {
                // عرض رسالة خطأ إذا حدث خطأ ما في جلب خدمات تأجير السيارات
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                // يمكنك عرض مؤشر تحميل هنا إذا أردت
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('جاري إنشاء الطلب...')),
                // );
              } else if (state is CreateOrderSuccess) {
                // عرض رسالة نجاح عند إنشاء الطلب
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // بعد النجاح، يمكن التوجيه إلى شاشة الطلبات
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                // عرض رسالة خطأ عند فشل إنشاء الطلب
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CarRentalCubit, CarRentalStates>(
          builder: (context, state) {
            if (state is CarRentalLoadingState) {
              // عرض مؤشر التحميل أثناء جلب البيانات
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarRentalSuccessState) {
              // عرض البيانات عند تحميلها بنجاح
              final carRentalServices = state.carRentalResponse.data;

              if (carRentalServices == null || carRentalServices.isEmpty) {
                return const Center(child: Text('لا توجد خدمات تأجير سيارات متاحة.'));
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  // التأكد من أن الفهرس ضمن حدود _imagePaths
                  final imageIndex = index % _imagePaths.length;
                  final service = carRentalServices[index]; // الخدمة الحالية

                  return CustomServiceCard(
                    imageUrl: _imagePaths[imageIndex], // استخدام نمط متكرر للصور
                    serviceName: service.subServiceName ?? 'غير متوفر',
                    serviceDescription: service.description ?? 'لا يوجد وصف متاح.',
                    onButtonPressed: () {
                      // منطق الحجز: عند الضغط على زر الحجز
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('الرجاء تسجيل الدخول لإجراء طلب.')),
                        );
                        return;
                      }

                      // إنشاء OrderRequestSubService
                      final orderSubService = OrderRequestSubService(
                        orderSubServiceName: service.subServiceName,
                      );

                      // إنشاء OrderRequestService
                      final orderRequestService = OrderRequestService(
                        orderServiceName: "Car Rental Service", // اسم عام لخدمة تأجير السيارات
                        orderSubServices: [orderSubService],
                      );

                      // إنشاء OrderRequest
                      // ملاحظة: userId في OrderRequest هو int. إذا كان الـ API يتوقع Firebase UID (String)
                      // كـ userId، فستحتاج إلى تعديل موديل OrderRequest أو طريقة إرسال الـ userId.
                      // حاليًا، سنستخدم قيمة افتراضية لـ userId (0) واسم المستخدم من Firebase.
                      final orderRequest = OrderRequest(
                        userId: 0, // يجب استبدال هذا بمعرف المستخدم الصحيح من الـ API أو قاعدة البيانات
                        userName: user.displayName ?? user.email ?? 'Unknown User',
                        orderServices: [orderRequestService],
                        maintenanceCenter: "N/A", // يمكن تعديل هذا إذا كان هناك مركز صيانة محدد
                        isHomeService: false, // تأجير السيارات ليس خدمة منزلية عادةً
                        orderDate: DateTime.now(),
                      );

                      // استدعاء Cubit لإنشاء الطلب
                      context.read<OrdersCubit>().createNewOrder(orderRequest);

                      print('تم الضغط على زر الحجز لـ: ${service.subServiceName}');
                    },
                  );
                },
                separatorBuilder: (context, index) => 7.verticalSpace,
                itemCount: carRentalServices.length, // استخدام العدد الفعلي من API
              );
            } else if (state is CarRentalErrorState) {
              // عرض رسالة خطأ إذا فشل الجلب
              return Center(child: Text('خطأ: ${state.error}'));
            }
            // الحالة الأولية أو حالة غير متوقعة
            return const Center(child: Text('اضغط لتحميل خدمات تأجير السيارات.'));
          },
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // استيراد مكتبة flutter_bloc
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_cubit.dart'; // استيراد الـ Cubit الخاص بك
import 'package:mechpro/feature/car_rental/presentation/cubit/car_rental_state.dart'; // استيراد الحالات الخاصة بك
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart'; // استيراد موديل طلب الأوردر
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart'; // استيراد موديل خدمة الأوردر
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart'; // استيراد موديل الخدمة الفرعية للأوردر
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart'; // استيراد الـ Cubit الخاص بالأوردرات
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart'; // استيراد حالات الـ Cubit الخاص بالأوردرات
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth للحصول على معلومات المستخدم
import 'package:mechpro/core/routing/routes.dart'; // لاستخدام الـ routes

class CarRentalView extends StatefulWidget {
  const CarRentalView({super.key});

  @override
  State<CarRentalView> createState() => _CarRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Sedan Car.png',
  'assets/images/SUV Car.png',
  // تأكد من أن مسارات الصور هذه صحيحة وموجودة في مجلد الأصول الخاص بك
];

class _CarRentalViewState extends State<CarRentalView> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات عند تهيئة الودجت
    context.read<CarRentalCubit>().getCarRental();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Car Rental", showLeading: false),
      body: MultiBlocListener(
        // استخدام MultiBlocListener للاستماع لأكثر من Cubit
        listeners: [
          BlocListener<CarRentalCubit, CarRentalStates>(
            listener: (context, state) {
              if (state is CarRentalErrorState) {
                // عرض رسالة خطأ إذا حدث خطأ ما في جلب خدمات تأجير السيارات
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                // يمكنك عرض مؤشر تحميل هنا إذا أردت
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(content: Text('جاري إنشاء الطلب...')),
                // );
              } else if (state is CreateOrderSuccess) {
                // عرض رسالة نجاح عند إنشاء الطلب
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                // بعد النجاح، يمكن التوجيه إلى شاشة الطلبات
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                // عرض رسالة خطأ عند فشل إنشاء الطلب
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: BlocBuilder<CarRentalCubit, CarRentalStates>(
          builder: (context, state) {
            if (state is CarRentalLoadingState) {
              // عرض مؤشر التحميل أثناء جلب البيانات
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarRentalSuccessState) {
              // عرض البيانات عند تحميلها بنجاح
              final carRentalServices = state.carRentalResponse.data;

              if (carRentalServices == null || carRentalServices.isEmpty) {
                return const Center(
                  child: Text('لا توجد خدمات تأجير سيارات متاحة.'),
                );
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  // التأكد من أن الفهرس ضمن حدود _imagePaths
                  final imageIndex = index % _imagePaths.length;
                  final service = carRentalServices[index]; // الخدمة الحالية

                  return CustomServiceCard(
                    imageUrl:
                        _imagePaths[imageIndex], // استخدام نمط متكرر للصور
                    serviceName: service.subServiceName ?? 'غير متوفر',
                    serviceDescription:
                        service.description ?? 'لا يوجد وصف متاح.',
                    onButtonPressed: () {
                      // منطق الحجز: عند الضغط على زر الحجز
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('الرجاء تسجيل الدخول لإجراء طلب.'),
                          ),
                        );
                        return;
                      }

                      // *** هذا هو التغيير الرئيسي: استخدام user.uid (String) مباشرةً ***
                      // *** هذا يفترض أن موديل OrderRequest قد تم تحديثه ليقبل String لـ userId. ***
                      // *** عندما يقوم الباك إند بتغيير نوع userId إلى String، سيعمل هذا الكود تلقائيًا. ***
                      // *** إذا كان الباك إند ما زال يتوقع int، فسيظل هذا يسبب خطأ 400 Bad Request. ***
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

                      // إنشاء OrderRequestSubService
                      final orderSubService = OrderRequestSubService(
                        orderSubServiceName: service.subServiceName,
                      );

                      // إنشاء OrderRequestService
                      final orderRequestService = OrderRequestService(
                        orderServiceName:
                            "Car Rental Service", // اسم عام لخدمة تأجير السيارات
                        orderSubServices: [orderSubService],
                      );

                      // إنشاء OrderRequest
                      final orderRequest = OrderRequest(
                        userId:
                            firebaseUserId, // استخدام Firebase UID كـ String
                        userName:
                            user.displayName ?? user.email ?? 'Unknown User',
                        orderServices: [orderRequestService],
                        maintenanceCenter:
                            "N/A", // يمكن تعديل هذا إذا كان هناك مركز صيانة محدد
                        isHomeService:
                            false, // تأجير السيارات ليس خدمة منزلية عادةً
                        orderDate: DateTime.now(),
                      );

                      // استدعاء Cubit لإنشاء الطلب
                      context.read<OrdersCubit>().createNewOrder(orderRequest);

                      print(
                        'تم الضغط على زر الحجز لـ: ${service.subServiceName}',
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => 7.verticalSpace,
                itemCount:
                    carRentalServices.length, // استخدام العدد الفعلي من API
              );
            } else if (state is CarRentalErrorState) {
              // عرض رسالة خطأ إذا فشل الجلب
              return Center(child: Text('خطأ: ${state.error}'));
            }
            // الحالة الأولية أو حالة غير متوقعة
            return const Center(
              child: Text('اضغط لتحميل خدمات تأجير السيارات.'),
            );
          },
        ),
      ),
    );
  }
}
