/*import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleStorage {
  static late SharedPreferences _preferences;
  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void chacheData(String key, value) {
    if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else {
      _preferences.setDouble(key, value);
    }
  }

  static dynamic getDate(String Key) {
    return _preferences.get(Key);
  }
}
*/
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleStorage {
  static late SharedPreferences _preferences;

  // دالة لتهيئة SharedPreferences مرة واحدة عند بدء التطبيق
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // دالة لحفظ البيانات في SharedPreferences
  // تم تعديلها للتعامل مع null (لحذف المفتاح) وأنواع البيانات المختلفة
  static void chacheData(String key, dynamic value) {
    if (value == null) {
      _preferences.remove(key); // إذا كانت القيمة null، احذف المفتاح
      return;
    }
    if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else {
      // طباعة تحذير لأنواع البيانات غير المدعومة بشكل صريح
      print('Warning: AppLocaleStorage - Unhandled data type for key $key: ${value.runtimeType}');
    }
  }

  // دالة لجلب البيانات من SharedPreferences
  static dynamic getDate(String Key) {
    return _preferences.get(Key);
  }

  // دالة جديدة لحذف بيانات محددة من SharedPreferences
  static Future<bool> removeData(String key) async {
    return await _preferences.remove(key);
  }
}