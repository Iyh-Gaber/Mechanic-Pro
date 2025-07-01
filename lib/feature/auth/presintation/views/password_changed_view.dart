/*import 'package:dkhoon/core/extenstions/extentions.dart';
import 'package:dkhoon/feature/auth/presintation/views/login_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../../core/widgets/custom_button.dart';

class PasswordChangedView extends StatelessWidget {
  const PasswordChangedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Successmark.png',
              width: 100,
              height: 100,
            ),
            Gap(25),
            Text(
              'Password Changed!',
              style: getTitleStyle(),
            ),
            Gap(25),
            Text(
              'Your password has been changed successfully.',
              style: getBodyStyle(color: AppColors.greyColor),
            ),
            Gap(30),
            CustomButton(
                text: ' Back to Login',
                onpressed: () {
                  context.pushAndRemoveUntil(LoginView());
                }),
          ],
        ),
      ),
    );
  }
}
*/
