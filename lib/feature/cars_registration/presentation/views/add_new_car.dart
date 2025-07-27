import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';

import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/textFormField_widget.dart';

class AddNewCarsView extends StatelessWidget {
  const AddNewCarsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SafeArea(
          child: ListView(
            children: [
              Text(LocaleKeys.carInformation.tr(), style: getSmallStyle()),
              SizedBox(height: 7),
              TextformfieldWidget(
                title: LocaleKeys.CarName.tr(),
                //  hiteTitle: 'Write Name',
              ),
              TextformfieldWidget(
                title: LocaleKeys.CarType.tr(),
                // hiteTitle: 'Write Type',
              ),
              TextformfieldWidget(
                title: LocaleKeys.Manufacturer.tr(),
                //  hiteTitle: 'Write Manufacturer',
              ),
              TextformfieldWidget(
                title: LocaleKeys.Model.tr(),
                //  hiteTitle: 'Write Model',
              ),
              TextformfieldWidget(
                title: LocaleKeys.YearofManufacture.tr(),
                //  hiteTitle: 'Write Year of Manufacture',
              ),
              TextformfieldWidget(
                title: LocaleKeys.MeterReading.tr(),
                //  hiteTitle: 'Write Meter Reading (km)',
              ),
              CustomButton(
                text: LocaleKeys.RegisterCar.tr(),
                onpressed: () {
                  context.pushNamed(Routes.carsRegister);
                  //  context.pushTo(CarsRegister());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
