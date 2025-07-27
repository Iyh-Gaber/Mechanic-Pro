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

class SectionTitlePart extends StatelessWidget {
  const SectionTitlePart({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: getSmallStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
