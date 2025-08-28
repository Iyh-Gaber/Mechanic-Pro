import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// هذا هو StatefulWidget الذي سيحتوي على الزر
class LocationButtonWidget extends StatefulWidget {
  const LocationButtonWidget({Key? key}) : super(key: key);

  @override
  State<LocationButtonWidget> createState() => _LocationButtonWidgetState();
}

class _LocationButtonWidgetState extends State<LocationButtonWidget> {
  // 1. تعريف متغير لتخزين نص الزر وحالة الموقع
  String _buttonText = 'احصل على موقعي';
  Position? _currentPosition;

  // دالة مساعدة للتحقق من الصلاحيات والحصول على الموقع
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('خدمات الموقع غير مفعلة.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('تم رفض صلاحيات الموقع.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('صلاحيات الموقع مرفوضة بشكل دائم.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // 2. الدالة التي يتم تشغيلها عند الضغط على الزر
  void _getLocation() async {
    try {
      // تحديث نص الزر إلى "جاري التحميل..."
      setState(() {
        _buttonText = 'جاري الحصول على الموقع...';
      });

      // الحصول على الإحداثيات
      Position position = await _determinePosition();
      
      // تحويل الإحداثيات إلى عنوان باستخدام geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'ar_EG',
      );

      // تحديث نص الزر بالعنوان
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _buttonText = 'Location: ${place.country}, ${place.locality}, ${place.street}';
         // _currentPosition = position;
        });
      } else {
        setState(() {
          _buttonText = 'لم يتم العثور على عنوان.';
        });
      }

    } catch (e) {
      // في حالة حدوث خطأ، تحديث نص الزر بالخطأ
      setState(() {
        _buttonText = 'حدث خطأ: ${e.toString()}';
      });
    }
  }

  // 3. بناء واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _getLocation, // هنا يتم ربط الزر بالدالة
          child: Text(_buttonText), // هنا نستخدم المتغير الذي يتغير قيمته
        ),
        if (_currentPosition != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'خط الطول: ${_currentPosition!.latitude}\nخط العرض: ${_currentPosition!.longitude}',
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

// مثال على كيفية استدعاء LocationButtonWidget في تطبيقك
/*
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: LocationButtonWidget(),
        ),
      ),
    ),
  );
}
*/