/*import 'package:dkhoon/core/extenstions/extentions.dart';
import 'package:dkhoon/feature/auth/presintation/views/login_view.dart';
import 'package:dkhoon/feature/auth/presintation/views/password_changed_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets_maneger.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../intro/wellcome_view.dart';
import 'package:flutter_gap/flutter_gap.dart';

class NewPassView extends StatelessWidget {
  const NewPassView({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(25),
            Text(
              'Create New Password',
              style: getTitleStyle(),
            ),
            Gap(25),
            Text(
              'Your new password must be unique from those previously used.',
              style: getBodyStyle(color: AppColors.greyColor),
            ),
            Gap(30),
            TextFormField(
              decoration: InputDecoration(hintText: 'new password'),
            ),
            Gap(30),
            TextFormField(
              decoration: InputDecoration(hintText: '  Confirmnew password'),
            ),
            Gap(30),
            CustomButton(
                text: ' Resend Password',
                onpressed: () {
                  context.pushAndRemoveUntil(PasswordChangedView());
                }),
          ],
        ),
      ),
    );
  }
}
*/
