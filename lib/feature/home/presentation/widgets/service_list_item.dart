import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';

class ServiceListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const ServiceListItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // ظل خفيف
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.black),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.blackColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* Scaffold(
      backgroundColor: lightGreyBackground, // تعيين لون خلفية الشاشة
      appBar: AppBar(
        backgroundColor: darkBlueGrey, // تعيين لون شريط التطبيق
        elevation: 0, // إزالة الظل من شريط التطبيق
        title: const Text(
          'Main Repair', // عنوان شريط التطبيق
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold), // نمط النص
        ),
        centerTitle: false, // محاذاة العنوان إلى اليسار
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // مد العناصر أفقياً
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(10.0), // مسافة بادئة حول شريط البحث
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search', // نص توضيحي داخل شريط البحث
                hintStyle: TextStyle(color: AppColors.primaryColor), // نمط نص التوضيح
                prefixIcon: Icon(Icons.search,
                    color: AppColors.primaryColor), // أيقونة البحث
                filled: true, // ملء الخلفية
                fillColor: Colors.white, // لون خلفية شريط البحث
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // حواف دائرية لشريط البحث
                  borderSide: BorderSide.none, // إزالة حدود الشريط
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 7.0), // مسافة بادئة عمودية للنص
              ),
            ),
          ),
          // زر الطوارئ
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0), // مسافة بادئة أفقية وعمودية للزر
            child: ElevatedButton.icon(
              onPressed: () {
                // الإجراء عند الضغط على زر الطوارئ
                print('Emergency Button Pressed');
                // يمكنك إضافة منطق خاص بحالة الطوارئ هنا
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700], // لون الزر الأحمر
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // حواف دائرية للزر
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0), // مسافة بادئة عمودية للزر
                elevation: 0, // إزالة الظل من الزر
              ),
              icon: const Icon(Icons.car_crash,
                  color: Colors.white), // أيقونة حادث سيارة
              label: const Text(
                'Emergency Situations', // نص الزر
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold), // نمط النص
              ),
            ),
          ),
          // عنوان "Core Services"
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 20.0, bottom: 10.0), // مسافة بادئة للعنوان
            child: Text(
              'Core Services', // نص العنوان
              style: TextStyle(
                color: Colors.black87, // لون النص
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // قائمة الخدمات
          Expanded(
            // يستخدم المساحة المتبقية
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0), // مسافة بادئة أفقية للقائمة
              children: [
                _buildServiceListItem(
                  icon: Icons.car_repair, // أيقونة الصيانة الدورية
                  title: 'Regular Maintenance', // عنوان الخدمة
                  onTap: () {
                    // إجراء عند الضغط على الخدمة
                    print('Regular Maintenance tapped');
                  },
                ),
                _buildServiceListItem(
                  icon: Icons.handyman, // أيقونة الأعطال الميكانيكية
                  title: 'Mechanical Fault Repairs',
                  onTap: () {
                    print('Mechanical Fault Repairs tapped');
                  },
                ),
                _buildServiceListItem(
                  icon: Icons.flash_on, // أيقونة الأعطال الكهربائية
                  title: 'Electrical Fault Repairs',
                  onTap: () {
                    print('Electrical Fault Repairs tapped');
                  },
                ),
                _buildServiceListItem(
                  icon: Icons.car_crash_outlined, // أيقونة إصلاح هياكل السيارات
                  title: 'Auto Body Repair',
                  onTap: () {
                    print('Auto Body Repair tapped');
                  },
                ),
                _buildServiceListItem(
                  icon: Icons.build, // أيقونة خدمات أخرى
                  title: 'Other Services',
                  onTap: () {
                    print('Other Services tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
     ), );
  }

  // دالة مساعدة لإنشاء عنصر قائمة الخدمة
  Widget _buildServiceListItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0), // مسافة بين البطاقات
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10.0), // حواف دائرية للبطاقة
      ),
      elevation: 0, // إزالة الظل من البطاقة
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0), // مسافة بادئة داخل عنصر القائمة
        leading: Icon(icon, color: darkBlueGrey, size: 28.0), // أيقونة الخدمة
        title: Text(
          title, // عنوان الخدمة
          style: const TextStyle(
            color: Colors.black87, // لون النص
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios,
            color: Colors.grey[400], size: 18.0), // أيقونة السهم
        onTap: onTap, // الإجراء عند الضغط
      ),
    );
  }
}
*/

/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_assets.dart';

import 'package:mechpro/core/utils/text_style.dart';

import 'package:mechpro/feature/home/presentation/views/Commercial_view.dart';
import 'package:mechpro/feature/home/presentation/views/Maintenance_view.dart';
import '../../../../core/utils/app_color.dart';
import '../../../notifications/presentation/views/notification_view.dart';
import '../../../offers/presentation/views/offers.dart';
import '../../../profile/presentation/views/profile_view.dart';
import '../cubit/main_services_cubit.dart';
import '../widgets/new_services.dart';

class HomeView extends StatelessWidget {
   HomeView({super.key});

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pushTo(ProfileView());
          },
          icon: Icon(
            Icons.person,
            color: AppColors.whColor,
          ),
          iconSize: 37,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pushTo(NotificationView());
            },
            icon: Icon(
              Icons.notifications,
              color: AppColors.whColor,
            ),
            iconSize: 33,
          ),
          IconButton(
            onPressed: () {
              context.pushTo(OffersView());
            },
            icon: Icon(
              Icons.local_offer_outlined,
              color: AppColors.whColor,
            ),
          ),
          SizedBox(
            width: 10.h,
          ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.whColor,
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            22.verticalSpace,
           
           
           SizedBox(
              height: 140, // ارتفاع ثابت للبطاقات
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 100.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.whColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.bgColor,
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 100.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.dbColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.bgColor,
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 100.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.bgColor,
                    child: Column(
                      children: [
                      Text('Maintenance',style: getSmallStyle(color: Colors.black),),
                    ]),
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 10),
                    color: AppColors.primaryColor,
                  ),
                  Container(
                    height: 100.h,
                    width: 100.w,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.whColor,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor,
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 22.h,
            ),
            maintenanceRepairServices(context),
            SizedBox(
              height: 44.h,
            ),
            commercialAdditionalServices(context),
         
         
         
         
         
         
          ],
        ),
      ),
    );
  }
}




  GestureDetector maintenanceRepairServices(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTo(BlocProvider(
            create: (BuildContext context) {
              return MainServicesCubit()..getmainServices();
            },
            child: MaintenanceView()));
      },
      child: Container(
        height: 100.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.bgColor,
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              LocaleKeys.MaintenanceRepairServices.tr(),
              style: getSmallStyle(),
            ),
            CircleAvatar(
              backgroundColor: AppColors.whColor,
              radius: 50,
              backgroundImage: AssetImage(AppAssets.activeIcon),
            ),
          ],
        ),
      ),
    );
  }



  GestureDetector commercialAdditionalServices(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTo(CommercialView());
      },
      child: Container(
        height: 100.h,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor,
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              LocaleKeys.CommercialAdditionalServices.tr(),
              style: getSmallStyle(),
            ),
            CircleAvatar(
              backgroundColor: AppColors.whColor,
              radius: 37,
              backgroundImage: AssetImage(AppAssets.sellingIcon),
            ),
          ],
        ),
      ),
    );
  }
  */
