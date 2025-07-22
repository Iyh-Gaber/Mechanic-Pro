/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/translate/app_translate.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/contact_card.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/f_a_q_item.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/social_media_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_color.dart'; // استيراد حزمة url_launcher



class ConnectUsView extends StatelessWidget {
  const ConnectUsView({super.key});

  // معلومات الاتصال
  final String phoneNumber = '01097265913';
  final String emailAddress = 'iyh.gaber@gmail.com';
  final String facebookUrl = 'https://www.facebook.com/yourcarapp'; // رابط فيسبوك وهمي
  final String twitterUrl = 'https://www.twitter.com/yourcarapp';   // رابط تويتر وهمي
  final String instagramUrl = 'https://www.instagram.com/yourcarapp'; // رابط انستجرام وهمي

  // دالة لفتح الروابط (الهاتف، البريد الإلكتروني، الويب)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // يمكنك عرض رسالة خطأ للمستخدم هنا
      debugPrint('Could not launch $url');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Could not open: $url')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false, 
        title:  Text(LocaleKeys.ContactUs.tr(),style: getBodyStyle(color: AppColors.whColor),),
        centerTitle: true,
        
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم الاتصال الهاتفي
            ContactCard(icon: Icons.call, title: LocaleKeys.CallUs.tr(), subtitle: phoneNumber, onTap: () => _launchURL('tel:$phoneNumber')),
            const SizedBox(height: 15),

            // قسم البريد الإلكتروني
            ContactCard(icon: Icons.email, title: LocaleKeys.ContactUsbyEmail.tr(), subtitle: emailAddress, onTap: () => _launchURL('mailto:$emailAddress')),
            const SizedBox(height: 25),

            // قسم الأسئلة الشائعة
            Text(
              LocaleKeys.FrequentlyAskedQuestions.tr(),
              style: getBodyStyle(color: AppColors.blackColor,fontSize: 22),
            ),
            const SizedBox(height: 10),
            FAQItem(question: LocaleKeys.HowcanIbookanappointmentformyvehicle.tr(), answer: LocaleKeys.Youcanbookanappointmentforyourvehicle.tr()),
            FAQItem(question: LocaleKeys.Whatpaymentmethodsdoyouaccept.tr(), answer: LocaleKeys.Weacceptcashandcreditcardsandanyother.tr()),
            FAQItem(question: LocaleKeys.Doyouprovideemergencymaintenanceservice.tr(), answer: LocaleKeys.Yesweprovidemaintenancearoundtheclock.tr()),
            FAQItem(question: LocaleKeys.Thecostofrequestingservice.tr(), answer: LocaleKeys.Thecostofrequestingserviceis250pounds.tr()),

            const SizedBox(height: 25),

            // قسم وسائل التواصل الاجتماعي
            Text(
              LocaleKeys.FollowUs.tr(),
              style: getBodyStyle(color: AppColors.blackColor,fontSize: 22),
            ),
           
            17.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaIcon(icon: Icons.facebook, label: LocaleKeys.facebook.tr(), onTap: () => _launchURL(facebookUrl)),
                SocialMediaIcon(icon: Icons.snapchat, label: LocaleKeys.twitter.tr(), onTap: () => _launchURL(twitterUrl)),
                SocialMediaIcon(icon: Icons.payment, label: LocaleKeys.instagram.tr(), onTap: () => _launchURL(instagramUrl)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  

}

*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/translate/app_translate.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/contact_card.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/f_a_q_item.dart';
import 'package:mechpro/feature/connect_us/presentation/widgets/social_media_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_color.dart'; // استيراد حزمة url_launcher

class ConnectUsView extends StatelessWidget {
  const ConnectUsView({super.key});

  // معلومات الاتصال
  final String phoneNumber = '01097265913';
  final String emailAddress = 'iyh.gaber@gmail.com';
  final String facebookUrl =
      'https://www.facebook.com/yourcarapp'; // رابط فيسبوك وهمي
  final String twitterUrl =
      'https://www.twitter.com/yourcarapp'; // رابط تويتر وهمي
  final String instagramUrl =
      'https://www.instagram.com/yourcarapp'; // رابط انستجرام وهمي
  final String whatsappNumber = '01097265913'; // رقم الواتساب الخاص بك
  // ملاحظة: لرابط الواتساب، يفضل استخدام الرقم بالصيغة الدولية بدون '+'.
  // مثال: إذا كان رقمك +201097265913، استخدم '201097265913'. رابط 'wa.me' يتعامل مع هذا بشكل جيد.

  // دالة لفتح الروابط (الهاتف، البريد الإلكتروني، الويب)
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // يمكنك عرض رسالة خطأ للمستخدم هنا
      debugPrint('Could not launch $url');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Could not open: $url')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    // بناء رابط الواتساب
    final String whatsappUrl = 'https://wa.me/$whatsappNumber';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.ContactUs.tr(),
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم الاتصال الهاتفي
            ContactCard(
                icon: Icons.call,
                title: LocaleKeys.CallUs.tr(),
                subtitle: phoneNumber,
                onTap: () => _launchURL('tel:$phoneNumber')),
            const SizedBox(height: 15),

            // قسم البريد الإلكتروني
            ContactCard(
                icon: Icons.email,
                title: LocaleKeys.ContactUsbyEmail.tr(),
                subtitle: emailAddress,
                onTap: () => _launchURL('mailto:$emailAddress')),
            const SizedBox(height: 15), // أضفنا مسافة للبطاقة الجديدة

            ContactCard(
              icon: Icons.chat, // أيقونة محادثة مناسبة للواتساب
              title: LocaleKeys.ContactUsbyChat
                  .tr(), // ستحتاج لإضافة هذا المفتاح لملف الترجمة الخاص بك
              subtitle: whatsappNumber,
              onTap: () => _launchURL(whatsappUrl),
            ),
            const SizedBox(height: 25),

            Text(
              LocaleKeys.FrequentlyAskedQuestions.tr(),
              style: getBodyStyle(color: AppColors.blackColor, fontSize: 22),
            ),
            const SizedBox(height: 10),
            FAQItem(
                question: LocaleKeys.HowcanIbookanappointmentformyvehicle.tr(),
                answer: LocaleKeys.Youcanbookanappointmentforyourvehicle.tr()),
            FAQItem(
                question: LocaleKeys.Whatpaymentmethodsdoyouaccept.tr(),
                answer: LocaleKeys.Weacceptcashandcreditcardsandanyother.tr()),
            FAQItem(
                question:
                    LocaleKeys.Doyouprovideemergencymaintenanceservice.tr(),
                answer: LocaleKeys.Yesweprovidemaintenancearoundtheclock.tr()),
            FAQItem(
                question: LocaleKeys.Thecostofrequestingservice.tr(),
                answer: LocaleKeys.Thecostofrequestingserviceis250pounds.tr()),

            const SizedBox(height: 25),

            Text(
              LocaleKeys.FollowUs.tr(),
              style: getBodyStyle(color: AppColors.blackColor, fontSize: 22),
            ),

            17.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SocialMediaIcon(
                    icon: Icons.facebook,
                    label: LocaleKeys.facebook.tr(),
                    onTap: () => _launchURL(facebookUrl)),

                SocialMediaIcon(
                    icon: Icons.flutter_dash,
                    label: LocaleKeys.twitter.tr(),
                    onTap: () => _launchURL(
                        twitterUrl)), // تم تغيير الأيقونة لأيقونة عامة
                SocialMediaIcon(
                    icon: Icons.camera_alt,
                    label: LocaleKeys.instagram.tr(),
                    onTap: () => _launchURL(
                        instagramUrl)), // تم تغيير الأيقونة لأيقونة عامة
              ],
            ),
          ],
        ),
      ),
    );
  }
}
