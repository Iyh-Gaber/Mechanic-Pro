import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

 
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    
    return Future.error('Location services are disabled.');
  }

 
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
     
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
   
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }


  return await Geolocator.getCurrentPosition();
}



Future<Placemark?> getLocationAddress() async {
  try {
   
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

 
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: 'ar_EG',
    );

   
    if (placemarks.isNotEmpty) {
      return placemarks.first;
    }

    return null;
    
  } catch (e) {
    print('حدث خطأ في الحصول على الموقع: $e');
    return null;
  }
}