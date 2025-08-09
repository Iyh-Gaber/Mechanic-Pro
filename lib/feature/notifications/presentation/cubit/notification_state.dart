import 'package:flutter_bloc/flutter_bloc.dart';

// --- تعريف الحالة (NotificationState) ---
// هذه هي البيانات التي سيتم مشاركتها مع واجهة المستخدم (UI).
class NotificationState {
  final List<Map<String, dynamic>> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? errorMessage;

  NotificationState({
    required this.notifications,
    required this.unreadCount,
    this.isLoading = false,
    this.errorMessage,
  });

  // هذه الدالة تساعد في إنشاء نسخة جديدة من الحالة مع تغييرات محددة.
  NotificationState copyWith({
    List<Map<String, dynamic>>? notifications,
    int? unreadCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage, // يمكن أن يكون null لإزالة رسالة الخطأ
    );
  }
}