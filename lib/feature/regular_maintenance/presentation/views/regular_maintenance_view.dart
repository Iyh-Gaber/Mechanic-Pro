import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // import bloc
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart'; // تأكد من أن هذا الملف موجود ويحتوي على verticalSpace
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/section_title_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/models/response/regular_response/datumRegular.dart'; // Import the Datum model
import '../cubit/regular_services_cubit.dart';
import '../cubit/regular_services_state.dart';

import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart'; // استيراد الـ Cubit الجديد
// استيراد نموذج الطلب

import 'package:mechpro/feature/regular_maintenance/data/models/response/regular_response/datumRegular.dart';

class RegularMaintenanceView extends StatefulWidget {
  const RegularMaintenanceView({super.key});

  @override
  State<RegularMaintenanceView> createState() => _RegularMaintenanceViewState();
}

class _RegularMaintenanceViewState extends State<RegularMaintenanceView> {
  static final Map<String, IconData> _serviceIcons = {
    'Oil and Fluid Change': Icons.oil_barrel,
    'Filter Replacement': Icons.filter_alt,
    'Brake and Suspension Check': Icons.car_repair,
    'Cooling System Check': Icons.ac_unit,
    'Tire Check and Air Pressure': Icons.tire_repair,
  };

  // State variables to manage user selections.
  final Set<DatumRegular> _selectedServices =
      {}; // Stores selected services (now Datum objects).
  DateTime? _selectedDate; // Stores the chosen date.
  TimeOfDay? _selectedTime; // Stores the chosen time.
  String?
  _selectedLocationType; // 'my_location' or 'our_branches' to track location choice.
  String? _selectedBranch; // Stores the name of the selected branch.
  bool _hasContactedForLocation =
      false; // New state variable to track if "Contact Us" button was pressed.

  // Dummy list of branches for demonstration purposes.
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // Dummy list of available times for demonstration purposes.
  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

  // Controller for the address input text field.
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ابدأ بجلب الخدمات فوراً عند تهيئة الـ State
    context.read<RegularServicesCubit>().getRegularServices();
  }

  // Function to display a date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now(), // Initial date is current date or previously selected.
      firstDate: DateTime.now(), // User cannot select a past date.
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), // User can select up to one year in advance.
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Customizes the theme of the date picker.
          data: ThemeData.light().copyWith(
            primaryColor: const Color(
              0xFF336f67,
            ), // Header background color of the date picker.
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF336f67),
            ), // Color for selected day.
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    // If a date is picked and it's different from the current selected date, update state.
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null; // Reset time when date changes.
      });
    }
  }

  // Getter to determine if the confirmation button should be enabled.
  // It checks if all necessary fields are filled.
  bool get _isConfirmButtonEnabled {
    return _selectedServices
            .isNotEmpty && // At least one service must be selected.
        _selectedDate != null && // A date must be selected.
        _selectedTime != null && // A time must be selected.
        (_selectedLocationType == 'our_branches' &&
                _selectedBranch !=
                    null || // If branch, a branch must be chosen.
            _selectedLocationType == 'my_location' &&
                (_addressController.text.isNotEmpty ||
                    _hasContactedForLocation)); // If my location, either address or contact button must be used.
  }

  // Function to handle the service confirmation logic.

  void _confirmService() {
    // Collects all selected data for confirmation.
    String servicesList = _selectedServices
        .map((s) => s.subServiceName ?? 'Unknown Service')
        .join(', '); // Joins selected service names.
    String date = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'N/A'; // Formats date.
    String time = _selectedTime != null
        ? _selectedTime!.format(context)
        : 'N/A'; // Formats time.
    String location;

    // Determines the location string based on user's choice.
    if (_selectedLocationType == 'my_location') {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)'; // Updated based on address input or contact button.
    } else if (_selectedLocationType == 'our_branches') {
      location = 'Branch: $_selectedBranch';
    } else {
      location = 'Location not specified';
    }

    // Displays a confirmation dialog to the user.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ), // Rounded corners for the dialog.
          title: const Text(
            'Confirm Service Request', // Dialog title.
            textAlign: TextAlign.left, // Align title to the left for LTR.
          ),
          content: SingleChildScrollView(
            // Allows content to scroll if it's too long.
            child: ListBody(
              // Arranges text widgets vertically.
              children: <Widget>[
                Text('Selected Services: $servicesList'),
                const SizedBox(height: 8),
                Text('Date: $date'),
                const SizedBox(height: 8),
                Text('Time: $time'),
                const SizedBox(height: 8),
                Text('Location: $location'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog.
              },
              child: const Text('Close'), // Close button.
            ),
            ElevatedButton(
              // Changed to ElevatedButton for consistency with theme.
              onPressed: () {
                // In a real app, this is where you'd send data to a backend.
                // For this example, we just print to console and show a SnackBar.
                print('Service Confirmed:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');
                Navigator.of(context).pop(); // Closes the dialog.
                ScaffoldMessenger.of(context).showSnackBar(
                  // Shows a success message.
                  const SnackBar(
                    content: Text(
                      'Your request has been confirmed successfully!',
                    ),
                  ),
                );
              },
              child: const Text('Confirm'), // Confirm button.
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // هنا استخدمنا الـ Widget الجديد
        title: LocaleKeys.RequestYourService.tr(),
        showLeading:
            false, // هنا اخترنا إنه ما يظهرش زر الرجوع في الشاشة دي بالذات
        // onLeadingPressed: () => Navigator.of(context).pop(), // لو حبيت تحط وظيفة مخصصة لزر الرجوع
      ),
      body: BlocBuilder<RegularServicesCubit, RegularServicesState>(
        builder: (context, state) {
          if (state is RegularServicesLoadingState ||
              state is RegularServicesInitial) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is RegularServicesErrorState) {
            // Updated to get the actual error message
            return Center(
              child: Text(
                'Error: ${(state as RegularServicesErrorState).message}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is RegularServicesSuccessState) {
            final List<DatumRegular>? servicesFromApi =
                (state as RegularServicesSuccessState).response.data;

            if (servicesFromApi == null || servicesFromApi.isEmpty) {
              return const Center(
                child: Text('No regular maintenance services found.'),
              );
            }

            return Padding(
              // Adds padding around the content.
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // Makes the content scrollable.
                children: [
                  // Section 1: Choose Your Services
                  SectionHeader(
                    leadingText: '1', // الرقم '1' اللي كان ظاهر
                    title: 'Choose your services', // النص اللي كان ظاهر
                  ),

                  // Helper for section title.
                  GridView.builder(
                    // Displays services in a grid.
                    shrinkWrap:
                        true, // Takes only as much space as its children.
                    physics:
                        const NeverScrollableScrollPhysics(), // Disables GridView's own scrolling.
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns in the grid.
                          crossAxisSpacing: 16.0, // Horizontal spacing.
                          mainAxisSpacing: 16.0, // Vertical spacing.
                          childAspectRatio: 0.7, // Aspect ratio for each card.
                        ),
                    itemCount: servicesFromApi
                        .length, // Number of service cards from API.
                    itemBuilder: (context, index) {
                      final service = servicesFromApi[index];
                      // احصل على الأيقونة من الخريطة، أو استخدم أيقونة افتراضية
                      final IconData icon =
                          _serviceIcons[service.subServiceName ?? ''] ??
                          Icons.miscellaneous_services;
                      final isSelected = _selectedServices.contains(service);
                      return GestureDetector(
                        // Makes the card tappable.
                        onTap: () {
                          setState(() {
                            // Updates the UI when a service is selected/deselected.
                            if (isSelected) {
                              _selectedServices.remove(service);
                            } else {
                              _selectedServices.add(service);
                            }
                          });
                        },
                        child: ServiceCard(
                          // Custom widget for each service card.
                          service: service,
                          isSelected: isSelected,
                          icon: icon, // Pass the determined icon
                        ),
                      );
                    },
                  ),
                  // تم تقليل المسافة هنا
                  const SizedBox(height: 24.0), // Spacer.
                  // Section 2: Select Date and Time
                  SectionHeader(
                    leadingText: '2', // الرقم '1' اللي كان ظاهر
                    title:
                        'When Do You Need the Service?', // النص اللي كان ظاهر
                  ),

                  // SectionTitlePart(title: '2. When Do You Need the Service?'),
                  10.verticalSpace,

                  DateTimePickerPart(
                    context: context,
                    label: 'Date',
                    value: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select Date',
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16.0), // Spacer.
                  // Time selection using a horizontal list of chips
                  if (_selectedDate !=
                      null) // Only show time options if a date is selected.
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Select Time:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 8.0, // Horizontal space between chips.
                          runSpacing:
                              8.0, // Vertical space between rows of chips.
                          children: _availableTimes.map((time) {
                            final isSelected = _selectedTime == time;
                            return ChoiceChip(
                              label: Text(time.format(context)),
                              selected: isSelected,
                              selectedColor: const Color(
                                0xFF336f67,
                              ).withOpacity(0.7), // Selected chip color.
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87, // Text color.
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTime = selected ? time : null;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: isSelected
                                      ? const Color(0xFF336f67)
                                      : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                              ),
                              elevation: isSelected ? 4 : 1,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                  10.verticalSpace,

                  SectionHeader(
                    leadingText: '3', // الرقم '1' اللي كان ظاهر
                    title:
                        'Where Do We Provide the Service?', // النص اللي كان ظاهر
                  ),
                  /*  SectionTitlePart(
                    title: LocaleKeys.WhereDoWeProvidetheService.tr(),
                  ),
                  */
                  10.verticalSpace,
                  SectionSelectLocation(context),

                  30.verticalSpace,

                  ConfirmationButton(),

                  20.verticalSpace,
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Column SectionSelectLocation(BuildContext context) {
    return Column(
      children: [
        LocationPart(
          title: LocaleKeys.AtMyLocationanywhere.tr(),
          value: LocaleKeys.mylocation.tr(),
          groupValue: _selectedLocationType,
          onChanged: (value) {
            setState(() {
              _selectedLocationType = value;
              _selectedBranch =
                  null; // Clears branch if 'my_location' is chosen.
              _hasContactedForLocation =
                  false; // Reset contact status when location type changes.
            });
          },
        ),
        17.verticalSpace,
        if (_selectedLocationType == LocaleKeys.mylocation.tr())
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  // Text field for detailed address.
                  controller: _addressController,
                  textAlign: TextAlign.left, // Align text to left for LTR.
                  decoration: InputDecoration(
                    labelText: LocaleKeys.EnterYourDetailedAddressOptional.tr(),
                    labelStyle: getSmallStyle(
                      color: AppColors.primaryColor,
                    ), // Made optional.
                    hintText: LocaleKeys.ElnezlawyStBuilding10Apt5,
                    hintStyle: getSmallStyle(color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _hasContactedForLocation = false;
                      }
                    });
                  },
                ),
              ),
              7.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _hasContactedForLocation = true;
                    _addressController.clear();
                  });

                  context.pushNamed(Routes.connectUsView);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        LocaleKeys.NavigatingtoContactUsscreen,
                        style: getSmallStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 17.0,
                    horizontal: 17,
                  ),
                  elevation: 5,
                ),
                child: Text(
                  LocaleKeys.Contactustospecifytheaddress.tr(),
                  style: getSmallStyle(color: AppColors.whColor),
                ),
              ),
            ],
          ),
        7.verticalSpace,
        LocationPart(
          title: LocaleKeys.AtOneofOurBranches.tr(),
          value: LocaleKeys.ourBranch.tr(),
          groupValue: _selectedLocationType,
          onChanged: (value) {
            setState(() {
              _selectedLocationType = value;
              _addressController.clear();
              _hasContactedForLocation = false;
            });
          },
        ),
        if (_selectedLocationType == LocaleKeys.ourBranch.tr())
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedBranch,
              hint: Text(
                LocaleKeys.SelectBranch.tr(),
                style: getSmallStyle(),
                textAlign: TextAlign.left,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: const Icon(Icons.store),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
              ),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBranch = newValue;
                });
              },
              items: _branches.map<DropdownMenuItem<String>>((String branch) {
                return DropdownMenuItem<String>(
                  value: branch,
                  child: Text(branch, textAlign: TextAlign.left),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  ElevatedButton ConfirmationButton() {
    return ElevatedButton(
      onPressed: _isConfirmButtonEnabled ? _confirmService : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        elevation: 5,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        LocaleKeys.ConfirmService.tr(),
        style: getSmallStyle(color: AppColors.whColor, fontSize: 18.0),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}
