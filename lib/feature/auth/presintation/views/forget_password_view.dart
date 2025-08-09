
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:mechpro/core/extenstions/extentions.dart';

import 'package:mechpro/core/utils/app_assets.dart';
import 'package:mechpro/core/utils/manage_padding.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}


class _ForgetPasswordViewState extends State<ForgetPasswordView> {
 
  final emailController = TextEditingController();

 
  @override
  void dispose() {
    emailController.dispose();
    super.dispose(); 
  }

 
  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(' Sent Successfully!'),
            content: const Text(
                'A password reset link has been sent to your email address.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      String errorMessage;
      if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'too-many-requests') { 
        errorMessage = ' Too many requests. Please try again later.';
      } else {
       
        errorMessage = 'Unexpected error occurred: ${e.message}';
      }
      
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('ok'),
              ),
            ],
          );
        },
      );
    }
  }

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
          icon: Image.asset(AppAssets.logoIcon, width: 41, height: 41),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Remember Password ? ', style: getSmallStyle()),
          TextButton(
            onPressed: () {
              context.pushReplacementNamed(Routes.registrationView);
            },
            child: Text(
              'Login',
              style: getSmallStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: 12.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(25),
            Text('Forget Password ?', style: getTitleStyle()),
            const Gap(25),
            Text(
              'Don\'t worry! It occurs. Please enter the email address linked with your account.',
              style: getBodyStyle(color: AppColors.grColor),
            ),
            const Gap(30),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  hintStyle: getSmallStyle(color: AppColors.primaryColor),
                ),
              ),
            ),
            const Gap(30),
            CustomButton(
              text: 'Password Reset',
              onpressed: sendPasswordResetEmail,
            ),
          ],
        ),
      ),
    );
  }
}