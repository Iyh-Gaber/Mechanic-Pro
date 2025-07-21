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

class LocationPart extends StatelessWidget {
  const LocationPart({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: groupValue == value
              ? AppColors.primaryColor
              : Colors.grey.shade300,
          width: groupValue == value ? 2.0 : 1.0,
        ),
      ),
      elevation: groupValue == value ? 4 : 1,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: getSmallStyle(fontWeight: FontWeight.bold,
            color:
                groupValue == value ? AppColors.primaryColor : const Color.fromARGB(255, 83, 78, 78),),
          
          /*TextStyle(
            fontWeight: FontWeight.bold,
            color:
                groupValue == value ? AppColors.primaryColor : AppColors.blackColor,
          ),
          */
          textAlign: TextAlign.left,
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
