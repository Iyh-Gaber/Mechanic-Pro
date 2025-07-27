/*import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';


class RegularMaintenanceView extends StatelessWidget {
  const RegularMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: SingleChildScrollView(
  child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
      Header(),
      HeaderServices(),
      Gap(10),
      
      
      ],),
    ),
  ),
),




    );
  }
}

class HeaderServices extends StatelessWidget {
  const HeaderServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.bgColor],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
             '1',
             style: getSmallStyle(color: AppColors.whColor),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
         'Choose your services',
          style: getSmallStyle(color: AppColors.blackColor,fontSize: 20),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                
                    Expanded(
                      child: Text(
                        'Request the services',
                        style: getBodyStyle(),
                        
                        ),

                    ),
         IconButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.blackColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                 
                  ],
                ),
              );
  }
}



*/

import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';

class DateTimePickerPart extends StatelessWidget {
  const DateTimePickerPart({
    super.key,
    required this.context,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final BuildContext context;
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.primaryColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 12.0,
          ),
        ),
        child: Text(
          value,
          style: getSmallStyle(fontSize: 16.0, color: AppColors.blackColor),
          // const TextStyle(fontSize: 16.0, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
