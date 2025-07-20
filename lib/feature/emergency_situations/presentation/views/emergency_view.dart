import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/emergency_situations/presentation/widgets/emergency_buttons_custom.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      backgroundColor: AppColors.whColor,
        elevation: 0,
      
        
        title:  Text(
          LocaleKeys.EmergencySituations.tr(),
          style: getBodyStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text(
              LocaleKeys.pleaseChooseTheTypeOfAssistanceRequired.tr(),
              textAlign: TextAlign.center,
              style: getSmallStyle(),
            ),
            

         
            EmergencyButtonsCustom(context: context, text: LocaleKeys.CallNow.tr(), icon: Icons.phone, color: const Color(0xFFEB5757), onPressed: () {}),
           

         
            EmergencyButtonsCustom(context: context, text: LocaleKeys.Transportcrane.tr(), icon: Icons.car_repair, color: AppColors.primaryColor, onPressed: () {}),
            

          
            EmergencyButtonsCustom(context: context, text: LocaleKeys.ReportAccident.tr(), icon: Icons.warning_amber_rounded, color: AppColors.primaryColor, onPressed: () {}),
           

            // Current Location Section
         
         
         /*   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your current location: $_currentLocation',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _copyLocationToClipboard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  ),
                  child: const Text('Copy'),
                ),
              ],
            ),
            */
            
22.verticalSpace,

          ],

        ),
      ),
    );
  }

 
}
