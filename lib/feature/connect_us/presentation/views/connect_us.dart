/*import 'package:flutter/material.dart';

class ConnectUsView extends StatelessWidget {
  const ConnectUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // استيراد حزمة url_launcher



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
        title: const Text(' Contact Us'), // عنوان الشاشة
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم الاتصال الهاتفي
            _buildContactCard(
              icon: Icons.call,
              title: ' Call Us',
              subtitle: phoneNumber,
              onTap: () => _launchURL('tel:$phoneNumber'),
            ),
            const SizedBox(height: 15),

            // قسم البريد الإلكتروني
            _buildContactCard(
              icon: Icons.email,
              title: 'Contact Us by Email',
              subtitle: emailAddress,
              onTap: () => _launchURL('mailto:$emailAddress'),
            ),
            const SizedBox(height: 25),

            // قسم الأسئلة الشائعة
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            _buildFAQItem(
              question: 'كيف يمكنني حجز موعد لصيانة سيارتي؟',
              answer: 'يمكنك حجز موعد من خلال قسم "الخدمات" في التطبيق واختيار نوع الخدمة والموعد المناسب.',
            ),
            _buildFAQItem(
              question: 'ما هي طرق الدفع المتاحة؟',
              answer: 'نقبل الدفع النقدي، البطاقات الائتمانية، والدفع عبر المحافظ الإلكترونية.',
            ),
            _buildFAQItem(
              question: 'هل تقدمون خدمة الصيانة الطارئة؟',
              answer: 'نعم، نقدم خدمة الصيانة الطارئة على مدار الساعة. يمكنك طلبها من شاشة "الطوارئ".',
            ),
            _buildFAQItem(
              question: '    ما تكلفه طلب الخدمه ؟',
              answer: 'تكلفه طلب الخدمه  250 جنيه.',
            ),

            const SizedBox(height: 25),

            // قسم وسائل التواصل الاجتماعي
            Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSocialMediaIcon(
                  icon: Icons.facebook, // يمكنك استخدام أيقونات مخصصة لفيسبوك وتويتر وانستجرام
                  label: 'فيسبوك',
                  onTap: () => _launchURL(facebookUrl),
                ),
                _buildSocialMediaIcon(
                  icon: Icons.dataset, // مثال لأيقونة تويتر، يفضل استخدام أيقونة تويتر الفعلية
                  label: 'تويتر',
                  onTap: () => _launchURL(twitterUrl),
                ),
                _buildSocialMediaIcon(
                  icon: Icons.camera_alt, // مثال لأيقونة انستجرام، يفضل استخدام أيقونة انستجرام الفعلية
                  label: 'انستجرام',
                  onTap: () => _launchURL(instagramUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget مساعد لإنشاء بطاقات الاتصال
  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero, // إزالة الهامش الافتراضي للـ Card
      child: InkWell( // لجعل البطاقة قابلة للضغط
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: const Color(0xFF336f67)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Spacer(), // يدفع الأيقونة للسهم لليمين
              const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget مساعد لإنشاء عناصر الأسئلة الشائعة
  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            answer,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  // Widget مساعد لإنشاء أيقونات وسائل التواصل الاجتماعي
  Widget _buildSocialMediaIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF336f67).withOpacity(0.1),
            child: Icon(
              icon,
              size: 35,
              color: const Color(0xFF336f67),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
