import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';
import 'package:mechpro/feature/Selling_%20original_spare%20parts/presentation/widgets/custom_service_card.dart';

class ToolRentalView extends StatefulWidget {
  const ToolRentalView({super.key});

  @override
  State<ToolRentalView> createState() => _ToolRentalViewState();
}

final List<String> _imagePaths = [
  'assets/images/Jack Rental.png',
  'assets/images/Diagnostic Scanner Renta.png',
];

class _ToolRentalViewState extends State<ToolRentalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tool Rental", showLeading: false),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return CustomServiceCard(
            imageUrl: _imagePaths[index],
            serviceName: '',
            serviceDescription: '',
            onButtonPressed: () {},
          );
        },
        separatorBuilder: (context, index) => 7.verticalSpace,

        itemCount: 2,
      ),
    );
  }
}
