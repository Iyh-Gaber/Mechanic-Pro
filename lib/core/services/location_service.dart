import 'package:geocoding/geocoding.dart';
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


// دالة مستقلة للحصول على عنوان الموقع
Future<Placemark?> getLocationAddress() async {
  try {
    // 1. التحقق من الصلاحيات والخدمة والحصول على الموقع
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('خدمات الموقع غير مفعلة.');
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('تم رفض صلاحيات الموقع.');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('صلاحيات الموقع مرفوضة بشكل دائم.');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();

    // 2. تحويل الإحداثيات إلى عنوان
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: 'ar_EG',
    );

    // 3. إرجاع أول عنوان تم العثور عليه
    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }

    return null;
    
  } catch (e) {
    print('حدث خطأ في الحصول على الموقع: $e');
    return null;
  }
}