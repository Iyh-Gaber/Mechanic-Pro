
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
  State<SellingOriginalPartsView> createState() => _SellingOriginalPartsViewState();
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
        title: Text(LocaleKeys.SellingOriginalParts.tr(),
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
                    child: Text('No data available'.tr()), 
                  );
                }
                return ListView.separated(
                  itemCount: sellingData.length,
                  separatorBuilder: (context, index) => 7.verticalSpace,
                  itemBuilder: (context, index) {
                    final DatumSelling item = sellingData[index];
                   
                  
                    final String imageUrl = _imagePaths[index % _imagePaths.length];

                    return CustomServiceCard(
                      imageUrl: imageUrl,
                      serviceName: item.subServiceName ?? 'N/A',
                      serviceDescription: item.description ?? 'No description available',
                      onButtonPressed: () {
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
              return const Center(child: Text('Press the button to load data.'));
            },
          ),
        ),
      ),
    );
  }
}