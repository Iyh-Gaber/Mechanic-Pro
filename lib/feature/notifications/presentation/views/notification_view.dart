

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
 
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification", showLeading: false),
 
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
        
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
  
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state.notifications.isEmpty) {
            return const Center(child: Text("No Notification Found"));
          }
      
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