import 'package:geolocator/geolocator.dart';

// دالة للحصول على الموقع الحالي للمستخدم
Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // 1. التحقق من تفعيل خدمة الموقع على الجهاز
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // إذا كانت خدمة الموقع غير مفعلة، أرسل خطأ
    return Future.error('Location services are disabled.');
  }

  // 2. التحقق من صلاحيات التطبيق
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // الصلاحيات مرفوضة، أرسل خطأ
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // الصلاحيات مرفوضة بشكل دائم، لا يمكننا طلبها مرة أخرى
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }

  // 3. الحصول على الموقع الحالي
  return await Geolocator.getCurrentPosition();
}