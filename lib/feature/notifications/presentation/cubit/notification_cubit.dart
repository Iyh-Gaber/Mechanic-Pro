
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/feature/notifications/presentation/widgets/notification_service.dart';
import 'notification_state.dart'; 



class NotificationCubit extends Cubit<NotificationState> {

  NotificationCubit()
      : super(NotificationState(
          notifications: [],
          unreadCount: 0,
          isLoading: false,
          errorMessage: null,
        ));

 
  Future<void> fetchNotifications() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {

      final fetchedNotifications = await NotificationService.getNotifications();
      
     
      final unread = fetchedNotifications.where((n) => n['isRead'] == false).length;

   
      emit(state.copyWith(
        notifications: fetchedNotifications,
        unreadCount: unread,
        isLoading: false,
      ));
    } catch (e) {
     
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch notifications: ${e.toString()}',
      ));
    }
  }

 
  void markNotificationAsRead(int index) {
    if (state.notifications.isNotEmpty && index >= 0 && index < state.notifications.length) {
      final updatedNotifications = List<Map<String, dynamic>>.from(state.notifications);
      if (updatedNotifications[index]['isRead'] == false) {
        updatedNotifications[index]['isRead'] = true;
        
      
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