/*import 'package:dkhoon/core/extenstions/extentions.dart';
import 'package:dkhoon/feature/auth/presintation/views/login_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets_maneger.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter/services.dart';
import 'package:dkhoon/feature/auth/presintation/views/new_pass_view.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        title: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              AssetsManeger.backIcon,
              width: 41,
              height: 41,
            )),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Didn’t received code? ',
            style: getSmallStyle(),
          ),
          TextButton(
            onPressed: () {
              context.pushReplacement(NewPassView());
            },
            child: Text(
              ' Resend',
              style: getSmallStyle(color: AppColors.primaryColor),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(25),
            Text(
              'OPT Verification',
              style: getTitleStyle(),
            ),
            Gap(25),
            Text(
              'Enter the verification code we just sent on your email address.',
              style: getBodyStyle(color: AppColors.greyColor),
            ),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 66,
                  width: 66,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor))),
                  ),
                ),
                SizedBox(
                  height: 66,
                  width: 66,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor))),
                  ),
                ),
                SizedBox(
                  height: 66,
                  width: 66,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor))),
                  ),
                ),
                SizedBox(
                  height: 66,
                  width: 66,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor))),
                  ),
                ),
              ],
            ),
            Gap(30),
            CustomButton(text: 'Verify', onpressed: () {}),
          ],
        ),
      ),
    );
  }
}
*/
