import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/cars_registration/presentation/views/add_new_car.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/text_style.dart';

class ShowCarsView extends StatelessWidget {
  const ShowCarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text:
                      LocaleKeys.TherearenoregisteredcarsyetIfyouwanttoregister,
                  style: getSmallStyle(),
                ),
                TextSpan(
                  text: LocaleKeys.clickhere,
                  style: getSmallStyle(color: AppColors.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.pushNamed(Routes.addNewCarView);
                      // context.pushTo(AddNewCarsView());
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
