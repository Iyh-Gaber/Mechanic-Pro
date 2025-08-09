/*import 'package:flutter/material.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
      body: Center(
        child: Text(" No Notification Found"),
      ),
    );
  }
}
*/



/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/notifications/presentation/widgets/notification_service.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
   
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {

    final notifications = await NotificationService.getNotifications();
    setState(() {
      _notifications = notifications;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : _notifications.isEmpty
              ? const Center(child: Text("No Notification Found")) 
              : ListView.builder(
                padding: 10.all,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Card(
                      shadowColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(notification['title'] ?? 'There is no title',style: getBodyStyle(color: AppColors.whColor),),
                        subtitle: Text(notification['body'] ?? 'There is no body',style: getSmallStyle(color: AppColors.whColor),
                      ),
                     ), );
                  },
                ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/notifications/presentation/widgets/notification_service.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await NotificationService.getNotifications();
    setState(() {
      _notifications = notifications;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(backgroundColor: AppColors.primaryColor,)) 
          : _notifications.isEmpty
              ? const Center(child: Text("No Notification Found")) 
              : ListView.builder(
                  padding: 10.all,
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Card(
                      shadowColor: AppColors.primaryColor,
                      color: AppColors.primaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExpansionTile( // هنا استخدمنا ExpansionTile
                        iconColor: AppColors.whColor,
                        collapsedIconColor: AppColors.whColor,
                        title: Text(
                          notification['title'] ?? 'There is no title',
                          style: getBodyStyle(color: AppColors.whColor),
                        ),
                        children: <Widget>[
                          // هذا الجزء سيظهر عند الضغط على العنوان
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              notification['body'] ?? 'There is no body',
                              style: getSmallStyle(color: AppColors.whColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';


import 'package:mechpro/feature/notifications/presentation/cubit/notification_cubit.dart';
import 'package:mechpro/feature/notifications/presentation/cubit/notification_state.dart'; // استيراد الحالة


class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {

  @override
  void initState() {
    super.initState();
    // عند فتح الصفحة، نطلب من الـ Cubit جلب الإشعارات
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
      // BlocConsumer يسمح لنا بالاستماع إلى التغييرات وإعادة بناء الـ widget
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          // يمكن استخدام الـ listener لإظهار رسالة خطأ مثلاً
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          // عرض حالة التحميل
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // عرض حالة عدم وجود إشعارات
          if (state.notifications.isEmpty) {
            return const Center(child: Text("No Notification Found"));
          }
          // عرض قائمة الإشعارات
          return ListView.builder(
            padding: 10.all,
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return Card(
                shadowColor: AppColors.primaryColor,
                color: AppColors.primaryColor,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ExpansionTile(
                  iconColor: AppColors.whColor,
                  collapsedIconColor: AppColors.whColor,
                  title: Text(
                    notification['title'] ?? 'There is no title',
                    style: getBodyStyle(color: AppColors.whColor),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        notification['body'] ?? 'There is no body',
                        style: getSmallStyle(color: AppColors.whColor),
                      ),
                    ),
                  ],
                  // عند التوسع، نطلب من الـ Cubit وضع علامة "مقروء"
                  onExpansionChanged: (isExpanded) {
                    if (isExpanded) {
                      context.read<NotificationCubit>().markNotificationAsRead(index);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}