

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/emergency_situations/presentation/widgets/emergency_buttons_custom.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';

class EmergencyView extends StatefulWidget {
  const EmergencyView({super.key});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
   final TextEditingController _addressController = TextEditingController();
   bool _hasContactedForLocation = false;
  final String _phoneNumberToCall = "1234567890"; 
  final String _accidentReportNumber = "45678"; 

 
  Future<Placemark?> getLocationAddress() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('the location services are disabled.');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('the location permissions are denied.');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('the location permissions are permanently denied.');
        return null;
      }

      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: 'ar_EG',
      );

      if (placemarks.isNotEmpty) {
        return placemarks.first;
      }

      return null;
    } catch (e) {
      print('Error getting location address: $e');
      return null;
    }
  }


  Future<void> _updateAddressWithCurrentLocation() async {
    Placemark? placemark = await getLocationAddress();

    if (placemark != null) {
      setState(() {
        _addressController.text =
            "${placemark.street}, ${placemark.locality}, ${placemark.country}";
        _hasContactedForLocation = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to get location address please give us your address manually."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


   
          appBar: CustomAppBar(
        title: LocaleKeys.EmergencySituations.tr(),
        showLeading: false,
        onLeadingPressed: () => Navigator.of(context).pop(),
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

           
            EmergencyButtonsCustom(
              context: context,
              text: LocaleKeys.CallNow.tr(),
              icon: Icons.phone,
              color: const Color(0xFFEB5757),
              onPressed: () {
                _showCallConfirmationDialog(context);
              },
            ),

          
            EmergencyButtonsCustom(
              context: context,
              text: LocaleKeys.Transportcrane.tr(),
              icon: Icons.car_repair,
              color: AppColors.primaryColor,
              onPressed: () {
                _showTransportCraneDialog(context);
              },
            ),

          
            EmergencyButtonsCustom(
              context: context,
              text: LocaleKeys.ReportAccident.tr(),
              icon: Icons.warning_amber_rounded,
              color: AppColors.primaryColor,
              onPressed: () {
                _showReportAccidentDialog(context);
              },
            ),

            22.verticalSpace,
          ],
        ),
      ),
    );
  }


  void _showCallConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Text("Call Confirmation".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة
          content: Text("Are you sure you want to call؟".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة
          actions: <Widget>[
            TextButton(
              child: Text("Cancel".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة
              onPressed: () {
                Navigator.of(dialogContext).pop(); // إغلاق مربع الحوار
              },
            ),
            TextButton(
              child: Text("Call".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة
              onPressed: () {
                Navigator.of(dialogContext).pop(); // إغلاق مربع الحوار أولاً
                _makePhoneCall(_phoneNumberToCall); // ثم إجراء المكالمة
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
  
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch dialer'.tr(),style: getSmallStyle(color: AppColors.primaryColor))),
      );
    }
  }

 
  void _showTransportCraneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Text("Request a Transport Crane".tr(),style: getSmallStyle(color: AppColors.whColor)), 
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please enter your address and we will send it to you as soon as possible".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة
              SizedBox(height: 16.h),
            
     
TextField(
  decoration: InputDecoration(
    fillColor: AppColors.whColor, 
    filled: true, 

    labelText: "Your Address".tr(),
    labelStyle: getSmallStyle(color: AppColors.blackColor), 
    hintText: "Enter your full address here".tr(), 
    hintStyle: getSmallStyle(color: AppColors.grColor), 

   prefixIcon: IconButton(
                      icon: const Icon(Icons.location_on, color: AppColors.primaryColor),
                      onPressed: () {
                        _updateAddressWithCurrentLocation(); 
                      },
                    ),


    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder( 
      borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder( 
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  style: getBodyStyle(color: AppColors.blackColor), 
),









            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel".tr(),style: getSmallStyle(color: AppColors.whColor)), 
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(" Request Confirm".tr(),style: getSmallStyle(color: AppColors.whColor)), 
              onPressed: () {
                Navigator.of(dialogContext).pop();
               
                ScaffoldMessenger.of(context).showSnackBar(

                  SnackBar(backgroundColor: AppColors.primaryColor, content: Text(' Your request has been confirmed successfully    '.tr(),style: getSmallStyle(color: AppColors.whColor))), // استخدام الترجمة
                );
              },
            ),
          ],
        );
      },
    );
  }

 
  void _showReportAccidentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Text(" Report Accident ".tr(),style: getSmallStyle(color: AppColors.whColor),), 
          content: Text("Please Connect to the Accident Report Number: $_accidentReportNumber".tr(),style: getSmallStyle(color: AppColors.whColor)), // استخدام الترجمة مع الرقم
          actions: <Widget>[
            TextButton(
              child: Text("Call".tr(),style: getSmallStyle(color: AppColors.whColor)), 
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _makePhoneCall(_accidentReportNumber); 
              },
            ),
          ],
        );
      },
    );
  }
}