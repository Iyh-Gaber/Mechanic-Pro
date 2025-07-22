import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/translate/app_translate.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';

class OtherServicesView extends StatelessWidget {
  const OtherServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.OtherServices.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Card(
            // لون خلفية البطاقة
            color: AppColors.whColor,
            // ارتفاع الظل، يعطي تأثير ثلاثي الأبعاد
            elevation: 5.0,
            // شكل البطاقة، هنا حواف دائرية
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // المسافة بين البطاقة والعناصر المحيطة
            margin: const EdgeInsets.all(12.0),
            // المحتوى داخل البطاقة
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // لجعل العمود يأخذ أقل مساحة ممكنة عموديا
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    Icons.directions_car,
                    size: 50.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10.0), // مسافة فارغة
                  Text(
                    'خدمة صيانة السيارات',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'نقدم أفضل خدمات صيانة وإصلاح السيارات بجودة عالية.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: null, // لا يوجد إجراء عند الضغط حاليا
                    child: Text('احجز الآن'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
