import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:mechpro/core/extenstions/extentions.dart';

import 'package:mechpro/core/utils/app_assets.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whColor,
        title: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(AppAssets.logo, width: 41, height: 41),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Remember Password ? ', style: getSmallStyle()),
          TextButton(
            onPressed: () {
              context.pushReplacementNamed(Routes.registrationView);
              //  context.pushReplacement(RegistrationView());
            },
            child: Text(
              'Login',
              style: getSmallStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(25),
            Text('Forget Password ?', style: getTitleStyle()),
            Gap(25),
            Text(
              'Don\'t worry! It occurs. Please enter the email address linked with your account.',
              style: getBodyStyle(color: AppColors.grColor),
            ),
            Gap(30),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter Your Email'),
            ),
            Gap(30),
            CustomButton(text: 'Send Code', onpressed: () {}),
          ],
        ),
      ),
    );
  }
}
