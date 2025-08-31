/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart'; 
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/models/response/regular_response/datumRegular.dart'; 
import '../cubit/regular_services_cubit.dart';
import '../cubit/regular_services_state.dart';


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

  
  final Set<DatumRegular> _selectedServices =
      {}; 
  DateTime? _selectedDate; 
  TimeOfDay? _selectedTime; 
  String?
  _selectedLocationType; 
  String? _selectedBranch; 
  bool _hasContactedForLocation =
      false; 

 
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

 
  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

 
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    context.read<RegularServicesCubit>().getRegularServices();
  }
// **أضف هذه الدالة إلى الكلاس _RegularMaintenanceViewState**
void _getCurrentLocation() async {
  // هنا ستقوم بكتابة منطق جلب الموقع الفعلي
  // مثال باستخدام حزمة geolocator (يجب إضافتها إلى pubspec.yaml)
  try {
    // تحقق من أذونات الموقع
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //
    // String address = "هنا عنوانك الذي تم جلبه من الإنترنت بناءً على خطوط الطول والعرض";
    //
    // setState(() {
    //   _addressController.text = address;
    //   _hasContactedForLocation = false;
    // });

    // كود مؤقت لتوضيح الفكرة
    setState(() {
      _addressController.text = "موقعي الحالي: شارع النزهة، مبنى 5، القاهرة";
      _hasContactedForLocation = false;
    });

  } catch (e) {
    // التعامل مع الأخطاء (مثال: الأذونات مرفوضة)
    print("Error getting location: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("لم نتمكن من جلب موقعك. يرجى إدخال العنوان يدويًا."),
      ),
    );
  }
}
 
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ), 
      builder: (BuildContext context, Widget? child) {
        return Theme(
          
          data: ThemeData.light().copyWith(
            primaryColor: const Color(
              0xFF336f67,
            ), 
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF336f67),
            ), 
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
   
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null; 
      });
    }
  }

 
  bool get _isConfirmButtonEnabled {
    return _selectedServices
            .isNotEmpty && 
        _selectedDate != null && 
        _selectedTime != null && 
        (_selectedLocationType == 'our_branches' &&
                _selectedBranch !=
                    null || 
            _selectedLocationType == 'my_location' &&
                (_addressController.text.isNotEmpty ||
                    _hasContactedForLocation)); 
  }

 

  void _confirmService() {
    
    String servicesList = _selectedServices
        .map((s) => s.subServiceName ?? 'Unknown Service')
        .join(', '); 
    String date = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'N/A'; 
    String time = _selectedTime != null
        ? _selectedTime!.format(context)
        : 'N/A'; 
    String location;

   
    if (_selectedLocationType == 'my_location') {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)'; 
    } else if (_selectedLocationType == 'our_branches') {
      location = 'Branch: $_selectedBranch';
    } else {
      location = 'Location not specified';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ), 
          title: const Text(
            'Confirm Service Request',
            textAlign: TextAlign.left, 
          ),
          content: SingleChildScrollView(
           
            child: ListBody(
            
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
                Navigator.of(context).pop(); 
              },
              child: const Text('Close'), 
            ),
            ElevatedButton(
             
              onPressed: () {
                
                print('Service Confirmed:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');
                Navigator.of(context).pop(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  
                  const SnackBar(
                    content: Text(
                      'Your request has been confirmed successfully!',
                    ),
                  ),
                );
              },
              child: const Text('Confirm'), 
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
        
        title: LocaleKeys.RequestYourService.tr(),
        showLeading:
            false, 
      ),
     
      body: BlocBuilder<RegularServicesCubit, RegularServicesState>(
        builder: (context, state) {
          if (state is RegularServicesLoadingState ||
              state is RegularServicesInitial) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is RegularServicesErrorState) {
            
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
             
              padding: 17.all,
              child: ListView(
               
                children: [
                   17.verticalSpace,
                  SectionHeader(
                    leadingText: '1', 
                    title: LocaleKeys.Chooseyourservices.tr(), 
                  ),
 17.verticalSpace,
                
                  GridView.builder(
                    
                    shrinkWrap:
                        true, 
                    physics:
                        const NeverScrollableScrollPhysics(), 
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 16.0, 
                          mainAxisSpacing: 16.0, 
                          childAspectRatio: 0.7, 
                        ),
                    itemCount: servicesFromApi
                        .length, 
                    itemBuilder: (context, index) {
                      final service = servicesFromApi[index];
                     
                      final IconData icon =
                          _serviceIcons[service.subServiceName ?? ''] ??
                          Icons.miscellaneous_services;
                      final isSelected = _selectedServices.contains(service);
                      return GestureDetector(
                       
                        onTap: () {
                          setState(() {
                           
                            if (isSelected) {
                              _selectedServices.remove(service);
                            } else {
                              _selectedServices.add(service);
                            }
                          });
                        },
                        child: ServiceCard(
                          
                          service: service,
                          isSelected: isSelected,
                          icon: icon, 
                        ),
                      );
                    },
                  ),
                 17.verticalSpace,
               
                  SectionHeader(
                    leadingText: '2', 
                    title:
                        LocaleKeys.WhenDoYouNeedtheService.tr(), 
                  ),

                 
                  17.verticalSpace,

                  DateTimePickerPart(
                    context: context,
                    label: 'Date',
                    value: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select Date',
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),
                  17.verticalSpace,
                
                  if (_selectedDate !=
                      null) 
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
                          spacing: 8.0, 
                          runSpacing:
                              8.0, 
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

                   17.verticalSpace,

                  SectionHeader(
                    leadingText: '3', 
                    title:
                        LocaleKeys.WhereDoWeProvidetheService.tr(), 
                  ),
                 
                  17.verticalSpace,
                  SectionSelectLocation(context),

                  17.verticalSpace,

                  ConfirmationButton(),

                17.verticalSpace,
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

                   // prefixIcon: const Icon(Icons.location_on,color: AppColors.primaryColor,),
                   
                     prefixIcon: IconButton(
                    icon: const Icon(Icons.location_on, color: AppColors.primaryColor),
                    onPressed: () {
                      _getCurrentLocation();
                    },
                  ),


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

*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import 'package:geolocator/geolocator.dart'; // تأكد من إضافة هذه الحزمة
import 'package:geocoding/geocoding.dart'; // تأكد من إضافة هذه الحزمة

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../../data/models/response/regular_response/datumRegular.dart';
import '../cubit/regular_services_cubit.dart';
import '../cubit/regular_services_state.dart';

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

  final Set<DatumRegular> _selectedServices = {};
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocationType;
  String? _selectedBranch;
  bool _hasContactedForLocation = false;

  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<RegularServicesCubit>().getRegularServices();
  }

  // الدالة التي قدمتها للحصول على الموقع الفعلي
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

  // الدالة الجديدة التي تستدعي الدالة أعلاه وتحدث واجهة المستخدم
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF336f67),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF336f67),
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTime = null;
      });
    }
  }

  bool get _isConfirmButtonEnabled {
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == 'our_branches' && _selectedBranch != null ||
            _selectedLocationType == 'my_location' &&
                (_addressController.text.isNotEmpty ||
                    _hasContactedForLocation));
  }

  void _confirmService() {
    String servicesList = _selectedServices
        .map((s) => s.subServiceName ?? 'Unknown Service')
        .join(', ');
    String date = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == 'my_location') {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == 'our_branches') {
      location = 'Branch: $_selectedBranch';
    } else {
      location = 'Location not specified';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          title: const Text(
            'Confirm Service Request',
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
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
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Service Confirmed:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your request has been confirmed successfully!',
                    ),
                  ),
                );
              },
              child: const Text('Confirm'),
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
        title: LocaleKeys.RequestYourService.tr(),
        showLeading: false,
      ),
      body: BlocBuilder<RegularServicesCubit, RegularServicesState>(
        builder: (context, state) {
          if (state is RegularServicesLoadingState ||
              state is RegularServicesInitial) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (state is RegularServicesErrorState) {
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
              padding: 17.all,
              child: ListView(
                children: [
                  17.verticalSpace,
                  SectionHeader(
                    leadingText: '1',
                    title: LocaleKeys.Chooseyourservices.tr(),
                  ),
                  17.verticalSpace,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: servicesFromApi.length,
                    itemBuilder: (context, index) {
                      final service = servicesFromApi[index];
                      final IconData icon =
                          _serviceIcons[service.subServiceName ?? ''] ??
                              Icons.miscellaneous_services;
                      final isSelected = _selectedServices.contains(service);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedServices.remove(service);
                            } else {
                              _selectedServices.add(service);
                            }
                          });
                        },
                        child: ServiceCard(
                          service: service,
                          isSelected: isSelected,
                          icon: icon,
                        ),
                      );
                    },
                  ),
                  17.verticalSpace,
                  SectionHeader(
                    leadingText: '2',
                    title: LocaleKeys.WhenDoYouNeedtheService.tr(),
                  ),
                  17.verticalSpace,
                  DateTimePickerPart(
                    context: context,
                    label: 'Date',
                    value: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select Date',
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),
                  17.verticalSpace,
                  if (_selectedDate != null)
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
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _availableTimes.map((time) {
                            final isSelected = _selectedTime == time;
                            return ChoiceChip(
                              label: Text(time.format(context)),
                              selected: isSelected,
                              selectedColor: const Color(
                                0xFF336f67,
                              ).withOpacity(0.7),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight:
                                    isSelected ? FontWeight.bold : FontWeight.normal,
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
                  17.verticalSpace,
                  SectionHeader(
                    leadingText: '3',
                    title: LocaleKeys.WhereDoWeProvidetheService.tr(),
                  ),
                  17.verticalSpace,
                  SectionSelectLocation(context),
                  17.verticalSpace,
                  ConfirmationButton(),
                  17.verticalSpace,
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
              _selectedBranch = null;
              _hasContactedForLocation = false;
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
                  controller: _addressController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    labelText: LocaleKeys.EnterYourDetailedAddressOptional.tr(),
                    labelStyle: getSmallStyle(
                      color: AppColors.primaryColor,
                    ),
                    hintText: LocaleKeys.ElnezlawyStBuilding10Apt5,
                    hintStyle: getSmallStyle(color: AppColors.primaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.location_on, color: AppColors.primaryColor),
                      onPressed: () {
                        _updateAddressWithCurrentLocation(); 
                      },
                    ),
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