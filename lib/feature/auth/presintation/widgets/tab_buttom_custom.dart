import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/auth/presintation/cubit/auth_cubit.dart';

class TabButtomCustom extends StatelessWidget {
  const TabButtomCustom({
    super.key,
    required this.context,
    required this.text,
    required this.isActive,
  });

  final BuildContext context;
  final String text;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>(); 
    return GestureDetector(
      onTap: () {
        
        authCubit.toggleAuthMode();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primaryColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? AppColors.primaryColor : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 17.0,
          ),
        ),
      ),
    );
  }
}
