/*import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/notifications/presentation/widgets/notification_service.dart';
import 'notification_state.dart'; 


// --- تعريف الـ Cubit ---
// الـ Cubit مسؤول عن إدارة الحالة وتحديثها.
class NotificationCubit extends Cubit<NotificationState> {
  // هذا هو الخدمة التي ستتواصل مع Firebase أو أي API
  final NotificationService _notificationService;

  // في الـ constructor، نقوم باستقبال الخدمة كـ dependency
  NotificationCubit(this._notificationService)
      : super(NotificationState(
          notifications: [],
          unreadCount: 0,
          isLoading: false,
          errorMessage: null,
        ));

  // دالة لجلب الإشعارات من الخدمة
  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // هنا نقوم باستدعاء الدالة الحقيقية لجلب الإشعارات من الخدمة
      final fetchedNotifications = await NotificationService.getNotifications();
      
      // حساب عدد الإشعارات غير المقروءة
      final unread = fetchedNotifications.where((n) => n['isRead'] == false).length;

      // إرسال حالة جديدة بالبيانات المحدثة
      emit(state.copyWith(
        notifications: fetchedNotifications,
        unreadCount: unread,
        isLoading: false,
      ));
    } catch (e) {
      // إرسال حالة خطأ في حالة وجود مشكلة
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch notifications: ${e.toString()}',
      ));
    }
  }

  // دالة لوضع علامة "مقروء" على إشعار معين
  void markNotificationAsRead(int index) {
    if (state.notifications.isNotEmpty && index >= 0 && index < state.notifications.length) {
      final updatedNotifications = List<Map<String, dynamic>>.from(state.notifications);
      if (updatedNotifications[index]['isRead'] == false) {
        updatedNotifications[index]['isRead'] = true;
        
        // هنا يجب أن يتم استدعاء الخدمة لتحديث حالة الإشعار في Firebase
        // _notificationService.markNotificationAsRead(updatedNotifications[index]['id']);

        final unread = updatedNotifications.where((n) => n['isRead'] == false).length;
        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadCount: unread,
        ));
      }
    }
  }
}
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/notifications/presentation/widgets/notification_service.dart';
import 'notification_state.dart'; 


// --- تعريف الـ Cubit ---
// الـ Cubit مسؤول عن إدارة الحالة وتحديثها.
class NotificationCubit extends Cubit<NotificationState> {
  // لا نحتاج إلى استقبال الخدمة كـ dependency لأن دوالها static
  NotificationCubit()
      : super(NotificationState(
          notifications: [],
          unreadCount: 0,
          isLoading: false,
          errorMessage: null,
        ));

  // دالة لجلب الإشعارات من الخدمة
  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // هنا نقوم باستدعاء الدالة الحقيقية لجلب الإشعارات من الخدمة
      final fetchedNotifications = await NotificationService.getNotifications();
      
      // حساب عدد الإشعارات غير المقروءة
      final unread = fetchedNotifications.where((n) => n['isRead'] == false).length;

      // إرسال حالة جديدة بالبيانات المحدثة
      emit(state.copyWith(
        notifications: fetchedNotifications,
        unreadCount: unread,
        isLoading: false,
      ));
    } catch (e) {
      // إرسال حالة خطأ في حالة وجود مشكلة
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch notifications: ${e.toString()}',
      ));
    }
  }

  // دالة لوضع علامة "مقروء" على إشعار معين
  void markNotificationAsRead(int index) {
    if (state.notifications.isNotEmpty && index >= 0 && index < state.notifications.length) {
      final updatedNotifications = List<Map<String, dynamic>>.from(state.notifications);
      if (updatedNotifications[index]['isRead'] == false) {
        updatedNotifications[index]['isRead'] = true;
        
        // هنا نقوم باستدعاء الخدمة لتحديث حالة الإشعار في SharedPreferences
        NotificationService.markNotificationAsRead(index);

        final unread = updatedNotifications.where((n) => n['isRead'] == false).length;
        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadCount: unread,
        ));
      }
    }
  }
}