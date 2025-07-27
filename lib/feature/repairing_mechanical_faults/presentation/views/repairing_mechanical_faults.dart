/*import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';


import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/section_header.dart' show SectionHeader;


class RepairingMechanicalFaultsView extends StatefulWidget {
  RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() =>
      _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState
    extends State<RepairingMechanicalFaultsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar( // هنا استخدمنا الـ Widget الجديد
        title: LocaleKeys.RequestYourService.tr(),
        showLeading: false, // هنا اخترنا إنه ما يظهرش زر الرجوع في الشاشة دي بالذات
        // onLeadingPressed: () => Navigator.of(context).pop(), // لو حبيت تحط وظيفة مخصصة لزر الرجوع
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
          SectionHeader(
          leadingText: '1', // الرقم '1' اللي كان ظاهر
          title: 'Choose your services', // النص اللي كان ظاهر
        ),
        7.verticalSpace,
        
        ]),
      ) ,
    );
  }
}
*/
/*


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/translate/locale_keys.g.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/selectable_card.dart';
import '../../../regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import '../../../regular_maintenance/presentation/widgets/location_part.dart';



class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() =>
      _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState
    extends State<RepairingMechanicalFaultsView> {
  // --- Dummy Data for UI demonstration ---
  // هذه البيانات وهمية فقط لعرض الـ UI، ولا تدير حالة حقيقية (state management)
  // This data is for UI display only and does not manage actual state
  String? _selectedLocationType; // لـ LocationPart
  String? _selectedBranch; // لـ DropdownMenu
  bool _isEngineSelected = false; // مثال على حالة لبطاقة خدمة
  bool _isOilChangeSelected = false; // مثال آخر

  // نفس قائمة الفروع من RegularMaintenanceView
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // بيانات وهمية لخدمات الصيانة
  final List<Map<String, dynamic>> _dummyServices = [
    {
      'name': 'Engine Diagnostics',
      'description': 'Full scan and error code reading',
      'icon': Icons.car_crash,
    },
    {
      'name': 'Gearbox Repair',
      'description': 'Fixing transmission issues',
      'icon': Icons.settings,
    },
    {
      'name': 'Suspension Check',
      'description': 'Shocks and struts inspection',
      'icon': Icons.shopping_cart_checkout,
    },
    {
      'name': 'Brake System Overhaul',
      'description': 'Pads, rotors, and fluid replacement',
      'icon': Icons.car_repair,
    },
  ];

  // --- End Dummy Data ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.RequestYourService.tr(),
        showLeading: true, // عادةً ما يكون زر الرجوع ظاهرًا في الشاشات الداخلية
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // القسم 1: اختر خدماتك
            // Section 1: Choose Your Services
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            7.verticalSpace,
            // استخدام GridView لعرض SelectableCard للخدمات
            // Using GridView to display SelectableCard for services
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // لمنع التمرير المزدوج
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عمودين
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7, // نسبة العرض إلى الارتفاع للبطاقات
              ),
              itemCount: _dummyServices.length,
              itemBuilder: (context, index) {
                final service = _dummyServices[index];
                bool isSelected;
                // هذا الجزء يعرض كيفية التحكم الوهمي في التحديد
                // This part demonstrates dummy control over selection
                if (index == 0) {
                  isSelected = _isEngineSelected;
                } else if (index == 1) {
                  isSelected = _isOilChangeSelected;
                } else {
                  isSelected = false; // باقي البطاقات غير مختارة افتراضيًا
                }

                return SelectableCard(
                  isSelected: isSelected,
                  onTap: () {
                    // تحديث الحالة الوهمية وعرض رسالة
                    setState(() {
                      if (index == 0) {
                        _isEngineSelected = !_isEngineSelected;
                      } else if (index == 1) {
                        _isOilChangeSelected = !_isOilChangeSelected;
                      }
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tapped on ${service['name']} (Dummy Selection)')),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        service['icon'] as IconData,
                        size: 50,
                        color: isSelected ? AppColors.whColor : AppColors.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        service['name'] as String,
                        style: getSmallStyle(
                          color: isSelected ? AppColors.whColor : AppColors.blackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        service['description'] as String,
                        style: getSmallStyle(
                          color: isSelected ? AppColors.whColor : AppColors.grColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            24.verticalSpace,

            // القسم 2: متى تحتاج الخدمة؟
            // Section 2: When Do You Need the Service?
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            10.verticalSpace,
            // استخدام DateTimePickerPart للتاريخ
            // Using DateTimePickerPart for Date
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: 'Select Date (Dummy)', // قيمة وهمية
              icon: Icons.calendar_today,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Date Picker Tapped (No Logic)')),
                );
              },
            ),
            16.verticalSpace,
            // استخدام DateTimePickerPart للوقت (يمكن إعادة استخدامه أو بناء جزء مخصص للوقت)
            // Using DateTimePickerPart for Time (can be reused or a custom time part)
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.SelectTime.tr(),
              value: 'Select Time (Dummy)', // قيمة وهمية
              icon: Icons.access_time,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Time Picker Tapped (No Logic)')),
                );
              },
            ),

            24.verticalSpace,

            // القسم 3: أين نقدم الخدمة؟
            // Section 3: Where Do We Provide the Service?
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            10.verticalSpace,
            Column(
              children: [
                // خيار "في موقعي" باستخدام LocationPart
                // "At my location" option using LocationPart
                LocationPart(
                  title: LocaleKeys.AtMyLocationanywhere.tr(),
                  value: LocaleKeys.mylocation.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('My Location Selected (Dummy)')),
                    );
                  },
                ),
                17.verticalSpace,
                // حقل العنوان التفصيلي يظهر فقط إذا تم اختيار "في موقعي"
                // Detailed address field only appears if "My Location" is selected
                if (_selectedLocationType == LocaleKeys.mylocation.tr())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: LocaleKeys.EnterYourDetailedAddressOptional.tr(),
                        labelStyle: getSmallStyle(color: AppColors.primaryColor),
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
                    ),
                  ),
                7.verticalSpace,
                // خيار "في أحد فروعنا" باستخدام LocationPart
                // "At one of our branches" option using LocationPart
                LocationPart(
                  title: LocaleKeys.AtOneofOurBranches.tr(),
                  value: LocaleKeys.ourBranch.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Our Branch Selected (Dummy)')),
                    );
                  },
                ),
                // قائمة الفروع المنسدلة تظهر فقط إذا تم اختيار "في أحد فروعنا"
                // Branch dropdown appears only if "Our Branch" is selected
                if (_selectedLocationType == LocaleKeys.ourBranch.tr())
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedBranch,
                      hint: Text(
                        LocaleKeys.SelectBranch.tr(),
                        style: getSmallStyle(),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Branch Selected: $newValue (Dummy)')),
                        );
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
            ),

            30.verticalSpace,

            // زر تأكيد الخدمة
            // Confirm Service Button
            CustomButton(
              text: LocaleKeys.ConfirmService.tr(),
               onpressed: () { ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Confirm Button Tapped (No Logic)')),
                ); },
            ),

            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart'; // يُعاد استخدامها

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';

// <<<<<<< ملاحظة مهمة: قمت بإنشاء هذا الكلاس Placeholder لـ DatumRegular >>>>>>>>
// بما أننا لا نستخدم Bloc، قد لا يكون لديك نموذج DatumRegular مُستورد من API.
// هذا الكلاس يحل محله لغرض عرض الـ UI. إذا كان لديك DatumRegular حقيقي في مشروعك،
// فيمكنك حذف هذا الكلاس وإعادة استيراد ملف DatumRegular الأصلي.
class DatumRegular {
  final int? id;
  final String? subServiceName;
  final String? subServiceDescription;
  // أضف أي حقول أخرى تحتاجها هنا
  DatumRegular({this.id, this.subServiceName, this.subServiceDescription});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DatumRegular && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
// <<<<<<<<<<<<<< نهاية Placeholder >>>>>>>>>>>>>>>>


class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() => _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState extends State<RepairingMechanicalFaultsView> {
  static final Map<String, IconData> _serviceIcons = {
    'Engine Diagnostics': Icons.car_crash,
    'Gearbox Repair': Icons.settings,
    'Suspension Check': Icons.shock_abs_filter,
    'Brake System Overhaul': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  // State variables to manage user selections.
  final Set<DatumRegular> _selectedServices = {};
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocationType;
  String? _selectedBranch;
  bool _hasContactedForLocation = false;

  // Dummy list of branches.
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // Dummy list of available times.
  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

  // Dummy Services for Mechanical Faults
  // هذه البيانات تحل محل البيانات التي كانت تأتي من الـ API
  final List<DatumRegular> _dummyMechanicalFaultServices = [
    DatumRegular(id: 1, subServiceName: 'Engine Diagnostics', subServiceDescription: 'Full scan and error code reading'),
    DatumRegular(id: 2, subServiceName: 'Gearbox Repair', subServiceDescription: 'Fixing transmission issues'),
    DatumRegular(id: 3, subServiceName: 'Suspension Check', subServiceDescription: 'Shocks and struts inspection'),
    DatumRegular(id: 4, subServiceName: 'Brake System Overhaul', subServiceDescription: 'Pads, rotors, and fluid replacement'),
    DatumRegular(id: 5, subServiceName: 'Electrical Faults', subServiceDescription: 'Troubleshooting wiring and electrical components'),
    DatumRegular(id: 6, subServiceName: 'AC System Repair', subServiceDescription: 'Fixing air conditioning issues'),
    DatumRegular(id: 7, subServiceName: 'Exhaust System Fix', subServiceDescription: 'Repairing muffler and exhaust pipes'),
    DatumRegular(id: 8, subServiceName: 'Other Mechanical Issues', subServiceDescription: 'General troubleshooting and repair'),
  ];


  // Controller for the address input text field.
  final TextEditingController _addressController = TextEditingController();

  // Function to display a date picker dialog.
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
        _selectedTime = null; // Reset time when date changes.
      });
    }
  }

  // Getter to determine if the confirmation button should be enabled.
  bool get _isConfirmButtonEnabled {
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == LocaleKeys.ourBranch.tr() && _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation));
  }

  // Function to handle the service confirmation logic.
  void _confirmService() {
    String servicesList = _selectedServices.map((s) => s.subServiceName ?? 'Unknown Service').join(', ');
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
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
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                // هنا لا يوجد استدعاء لـ Cubit أو API
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
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
        showLeading: true, // زر الرجوع ظاهر
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section 1: Choose Your Services
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            16.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _dummyMechanicalFaultServices.length, // استخدام البيانات الوهمية
              itemBuilder: (context, index) {
                final service = _dummyMechanicalFaultServices[index];
                final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
            24.verticalSpace,

            // Section 2: When Do You Need the Service?
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            10.verticalSpace,

            // Date Picker Part
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : LocaleKeys.SelectDate.tr(),
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            16.verticalSpace,

            // Time selection using a horizontal list of chips
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.SelectTime.tr(),
                      style: getSmallStyle(
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
                        selectedColor: AppColors.primaryColor.withOpacity(0.7),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        elevation: isSelected ? 4 : 1,
                      );
                    }).toList(),
                  ),
                ],
              ),

            24.verticalSpace,

            // Section 3: Where Do We Provide the Service?
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            10.verticalSpace,

            // Location selection part
            Column(
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
                            labelStyle: getSmallStyle(color: AppColors.primaryColor),
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
                                LocaleKeys.NavigatingtoContactUsscreen.tr(),
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
            ),

            30.verticalSpace,

            // Confirmation Button
            ElevatedButton(
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
            ),

            20.verticalSpace,
          ],
        ),
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
/*

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // import Bloc
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';

// <<<<< استيراد الكلاسات الجديدة الخاصة بـ Mechanical Faults >>>>>
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/presentation/cubit/mechanical_cubit.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/presentation/cubit/mechanical_state.dart';


class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() => _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState extends State<RepairingMechanicalFaultsView> {
  static final Map<String, IconData> _serviceIcons = {
    'Engine Diagnostics': Icons.car_crash,
    'Gearbox Repair': Icons.settings,
    'Suspension Check': Icons.sports_hockey_sharp,
    'Brake System Overhaul': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  // State variables to manage user selections.
  // تم تغيير النوع من DatumRegular إلى DatumMechanical
  final Set<DatumMechanical> _selectedServices = {};
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocationType;
  String? _selectedBranch;
  bool _hasContactedForLocation = false;

  // Dummy list of branches.
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // Dummy list of available times.
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
    // استدعاء Cubit لجلب بيانات الأعطال الميكانيكية عند بدء الشاشة
    context.read<MechanicalCubit>().getMechanical();
  }

  // Function to display a date picker dialog.
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
        _selectedTime = null; // Reset time when date changes.
      });
    }
  }

  // Getter to determine if the confirmation button should be enabled.
  bool get _isConfirmButtonEnabled {
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == LocaleKeys.ourBranch.tr() && _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation));
  }

  // Function to handle the service confirmation logic.
  void _confirmService() {
    String servicesList = _selectedServices.map((s) => s.subServiceName ?? 'Unknown Service').join(', ');
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
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
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                // هنا يمكنك إضافة لوجيك إرسال الطلب عبر Cubit إذا كان لديك Cubit لإدارة الطلبات
                // مثال (افتراضي): context.read<OrdersCubit>().submitMechanicalFaultOrder(servicesList, date, time, location);
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
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
        showLeading: true, // زر الرجوع ظاهر
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      // <<<BlocBuilder لإدارة حالات تحميل البيانات وعرضها>>>
      body: BlocBuilder<MechanicalCubit, MechanicalStates>(
        builder: (context, state) {
          if (state is MechanicalLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MechanicalSuccessState) {
            // الوصول إلى قائمة الخدمات من state.value.data
            // تأكد أن `value` في `MechanicalSuccessState` يتم تمريرها بشكل صحيح
            final List<DatumMechanical> mechanicalServices = state.value?.data ?? [];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Section 1: Choose Your Services
                  SectionHeader(
                    leadingText: '1',
                    title: LocaleKeys.Chooseyourservices.tr(),
                  ),
                  16.verticalSpace,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: mechanicalServices.length, // استخدام الخدمات من الـ API
                    itemBuilder: (context, index) {
                      final service = mechanicalServices[index];
                      // لاحظ أن ServiceCard تتوقع DatumRegular
                      // سنحتاج إلى تحويل DatumMechanical إلى DatumRegular أو تعديل ServiceCard لقبول DatumMechanical
                      // الأفضل هو تعديل ServiceCard
                      // مؤقتًا، سنستخدم DatumMechanical مباشرةً، بافتراض أن ServiceCard تتوقع الخصائص `subServiceName` و `description`
                      final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
                        // ServiceCard يجب أن تكون قادرة على التعامل مع DatumMechanical أو نقوم بتحويل البيانات
                        // الأفضل تعديل ServiceCard لقبول generic type T أو DatumMechanical
                        // للتوافق المباشر هنا، نتوقع أن ServiceCard تستقبل الكلاس الذي يحتوي على subServiceName و description
                        child: ServiceCard(
                          service: service, // تمرير DatumMechanical هنا
                          isSelected: isSelected,
                          icon: icon,
                        ),
                      );
                    },
                  ),
                  24.verticalSpace,

                  // Section 2: When Do You Need the Service?
                  SectionHeader(
                    leadingText: '2',
                    title: LocaleKeys.WhenDoYouNeedtheService.tr(),
                  ),
                  10.verticalSpace,

                  // Date Picker Part
                  DateTimePickerPart(
                    context: context,
                    label: LocaleKeys.Date.tr(),
                    value: _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : LocaleKeys.SelectDate.tr(),
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),
                  16.verticalSpace,

                  // Time selection using a horizontal list of chips
                  if (_selectedDate != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            LocaleKeys.SelectTime.tr(),
                            style: getSmallStyle(
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
                              selectedColor: AppColors.primaryColor.withOpacity(0.7),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTime = selected ? time : null;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                  color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                              ),
                              elevation: isSelected ? 4 : 1,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                  24.verticalSpace,

                  // Section 3: Where Do We Provide the Service?
                  SectionHeader(
                    leadingText: '3',
                    title: LocaleKeys.WhereDoWeProvidetheService.tr(),
                  ),
                  10.verticalSpace,

                  // Location selection part
                  Column(
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
                                  labelStyle: getSmallStyle(color: AppColors.primaryColor),
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
                                      LocaleKeys.NavigatingtoContactUsscreen.tr(),
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
                  ),

                  30.verticalSpace,

                  // Confirmation Button
                  ElevatedButton(
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
                  ),

                  20.verticalSpace,
                ],
              ),
            );
          } else if (state is MechanicalErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  10.verticalSpace,
                  Text(
                    LocaleKeys.SomethingWentWrong.tr(), // Use a localized string for error
                    style: getSmallStyle(color: Colors.red),
                  ),
                  Text(
                    state.error, // Display the actual error message
                    style: getSmallStyle(color: Colors.red.shade700),
                    textAlign: TextAlign.center,
                  ),
                  20.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      context.read<MechanicalCubit>().getMechanical(); // Try again
                    },
                    child: Text(LocaleKeys.TryAgain.tr()),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // Fallback for initial state or unexpected states
        },
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
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
// استيراد DatumMechanical لتمثيل خدمات الأعطال الميكانيكية
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart'; // يُعاد استخدامها

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';


class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() => _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState extends State<RepairingMechanicalFaultsView> {
  static final Map<String, IconData> _serviceIcons = {
    'Engine Diagnostics': Icons.car_crash,
    'Gearbox Repair': Icons.settings,
    'Suspension Check': Icons.sports_hockey_sharp,
    'Brake System Overhaul': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  // المتغيرات اللي بتخزن اختيارات المستخدم
  final Set<DatumMechanical> _selectedServices = {}; // تم تغيير النوع إلى DatumMechanical
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocationType;
  String? _selectedBranch;
  bool _hasContactedForLocation = false;

  // قائمة الفروع الوهمية
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // قائمة الأوقات المتاحة الوهمية
  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

  // قائمة خدمات الأعطال الميكانيكية الوهمية (تستخدم DatumMechanical)
  final List<DatumMechanical> _dummyMechanicalFaultServices = [
    DatumMechanical(subServiceId: 1, serviceId: 101, subServiceName: 'Engine Diagnostics', description: 'Full scan and error code reading'),
    DatumMechanical(subServiceId: 2, serviceId: 101, subServiceName: 'Gearbox Repair', description: 'Fixing transmission issues'),
    DatumMechanical(subServiceId: 3, serviceId: 101, subServiceName: 'Suspension Check', description: 'Shocks and struts inspection'),
    DatumMechanical(subServiceId: 4, serviceId: 101, subServiceName: 'Brake System Overhaul', description: 'Pads, rotors, and fluid replacement'),
    DatumMechanical(subServiceId: 5, serviceId: 102, subServiceName: 'Electrical Faults', description: 'Troubleshooting wiring and electrical components'),
    DatumMechanical(subServiceId: 6, serviceId: 102, subServiceName: 'AC System Repair', description: 'Fixing air conditioning issues'),
    DatumMechanical(subServiceId: 7, serviceId: 103, subServiceName: 'Exhaust System Fix', description: 'Repairing muffler and exhaust pipes'),
    DatumMechanical(subServiceId: 8, serviceId: 103, subServiceName: 'Other Mechanical Issues', description: 'General troubleshooting and repair'),
  ];


  // Controller لحقل إدخال العنوان
  final TextEditingController _addressController = TextEditingController();

  // دالة لعرض منتقي التاريخ
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
        _selectedTime = null; // إعادة تعيين الوقت عند تغيير التاريخ
      });
    }
  }

  // Getter لتحديد ما إذا كان زر التأكيد يجب أن يكون مفعّلاً
  bool get _isConfirmButtonEnabled {
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == LocaleKeys.ourBranch.tr() && _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation));
  }

  // دالة للتعامل مع منطق تأكيد الخدمة
  void _confirmService() {
    String servicesList = _selectedServices.map((s) => '${s.subServiceName} (${s.description})').join(', ');
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
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
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                // هنا لا يوجد استدعاء لـ Cubit أو API
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
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
        showLeading: true, // زر الرجوع ظاهر
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // القسم 1: اختر خدماتك
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            16.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: _dummyMechanicalFaultServices.length, // استخدام البيانات الوهمية من نوع DatumMechanical
              itemBuilder: (context, index) {
                final service = _dummyMechanicalFaultServices[index];
                final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
                    service: service, // هنا بنبعت DatumMechanical للـ ServiceCard
                    isSelected: isSelected,
                    icon: icon,
                  ),
                );
              },
            ),
            24.verticalSpace,

            // القسم 2: متى تحتاج الخدمة؟
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار التاريخ
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : LocaleKeys.SelectDate.tr(),
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            16.verticalSpace,

            // جزء اختيار الوقت باستخدام قائمة أفقية من الـ chips
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.SelectTime.tr(),
                      style: getSmallStyle(
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
                        selectedColor: AppColors.primaryColor.withOpacity(0.7),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        elevation: isSelected ? 4 : 1,
                      );
                    }).toList(),
                  ),
                ],
              ),

            24.verticalSpace,

            // القسم 3: أين نقدم الخدمة؟
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار الموقع
            Column(
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
                            labelStyle: getSmallStyle(color: AppColors.primaryColor),
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
                                LocaleKeys.NavigatingtoContactUsscreen.tr(),
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
            ),

            30.verticalSpace,

            // زر تأكيد الخدمة
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null, // الزر بيكون مفعل فقط لو كل الحقول المطلوبة مليانة
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
                LocaleKeys.ConfirmService.tr(),
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../cubit/mechanical_cubit.dart';
import '../cubit/mechanical_state.dart';


class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() => _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState extends State<RepairingMechanicalFaultsView> {
  static final Map<String, IconData> _serviceIcons = {
    'Engine Diagnostics': Icons.car_crash,
    'Gearbox Repair': Icons.settings,
    'Suspension Check': Icons.sports_hockey_sharp,
    'Brake System Overhaul': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  final Set<DatumMechanical> _selectedServices = {};
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
    // جلب الخدمات الميكانيكية عند تهيئة الشاشة
    context.read<MechanicalCubit>().getMechanical();
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
        _selectedTime = null; // إعادة تعيين الوقت عند تغيير التاريخ
      });
    }
  }

  bool get _isConfirmButtonEnabled {
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == LocaleKeys.ourBranch.tr() && _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation));
  }




void _confirmService() {
    String servicesList = _selectedServices.map((s) => '${s.subServiceName} (${s.description})').join(', ');
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
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
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
            ),
          ],
        );
      },
    );
  }




/*
  bool get _isConfirmButtonEnabled {
  final bool servicesSelected = _selectedServices.isNotEmpty;
  final bool dateSelected = _selectedDate != null;
  final bool timeSelected = _selectedTime != null;
  final bool locationValid;

  if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
    locationValid = _selectedBranch != null;
  } else if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
    locationValid = _addressController.text.isNotEmpty || _hasContactedForLocation;
  } else {
    locationValid = false; // لا يوجد نوع موقع مختار
  }

  print('Services Selected: $servicesSelected');
  print('Date Selected: $dateSelected');
  print('Time Selected: $timeSelected');
  print('Location Type: $_selectedLocationType');
  print('Branch Selected: $_selectedBranch');
  print('Address Not Empty: ${_addressController.text.isNotEmpty}');
  print('Has Contacted: $_hasContactedForLocation');
  print('Location Valid: $locationValid');
  print('Is Confirm Button Enabled: ${servicesSelected && dateSelected && timeSelected && locationValid}');

  return servicesSelected && dateSelected && timeSelected && locationValid;
}

  void _confirmService() {
    String servicesList = _selectedServices.map((s) => '${s.subServiceName} (${s.description})').join(', ');
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
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
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
            ),
          ],
        );
      },
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.RequestYourService.tr(),
        showLeading: true,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // القسم 1: اختر خدماتك
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            16.verticalSpace,
            BlocBuilder<MechanicalCubit, MechanicalStates>(
              builder: (context, state) {
                if (state is MechanicalLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MechanicalSuccessState) {
                  final List<DatumMechanical> mechanicalServices = state.value.data ?? [];
                  if (mechanicalServices.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoServicesAvailable.tr()));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: mechanicalServices.length,
                    itemBuilder: (context, index) {
                      final service = mechanicalServices[index];
                      final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
                  );
                } else if (state is MechanicalErrorState) {
                  return Center(child: Text(LocaleKeys.ErrorLoadingServices.tr(args: [state.error])));
                }
                return const SizedBox.shrink(); // في حالة InitialState أو أي حالة أخرى
              },
            ),
            24.verticalSpace,

            // القسم 2: متى تحتاج الخدمة؟
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار التاريخ
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : LocaleKeys.SelectDate.tr(),
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            16.verticalSpace,

            // جزء اختيار الوقت باستخدام قائمة أفقية من الـ chips
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.SelectTime.tr(),
                      style: getSmallStyle(
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
                        selectedColor: AppColors.primaryColor.withOpacity(0.7),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        elevation: isSelected ? 4 : 1,
                      );
                    }).toList(),
                  ),
                ],
              ),

            24.verticalSpace,

            // القسم 3: أين نقدم الخدمة؟
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار الموقع
            Column(
              children: [
                LocationPart(
                  title: LocaleKeys.AtMyLocationanywhere.tr(),
                  value: LocaleKeys.mylocation.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _selectedBranch = null;
                      _addressController.clear(); // Clear address when switching location type
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
                            labelStyle: getSmallStyle(color: AppColors.primaryColor),
                            hintText: LocaleKeys.ElnezlawyStBuilding10Apt5.tr(),
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
                                LocaleKeys.NavigatingtoContactUsscreen.tr(),
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
            ),

            30.verticalSpace,

            // زر تأكيد الخدمة
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null,
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
                LocaleKeys.ConfirmService.tr(),
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
*/

/*
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../cubit/mechanical_cubit.dart';
import '../cubit/mechanical_state.dart';


class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() => _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState extends State<RepairingMechanicalFaultsView> {
  // تعريف الأيقونات للخدمات المختلفة
  static final Map<String, IconData> _serviceIcons = {
    'Engine Diagnostics': Icons.car_crash,
    'Gearbox Repair': Icons.settings,
    'Suspension Check': Icons.sports_hockey_sharp,
    'Brake System Overhaul': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  // المتغيرات لتخزين اختيار المستخدم
  final Set<DatumMechanical> _selectedServices = {};
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedLocationType;
  String? _selectedBranch;
  bool _hasContactedForLocation = false;

  // قائمة الفروع المتاحة
  final List<String> _branches = [
    'Qatar Branch - Twin Towers A, Street 303',
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
    'Elminia Branch - Palace Square',
  ];

  // قائمة الأوقات المتاحة
  final List<TimeOfDay> _availableTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 10, minute: 30),
    const TimeOfDay(hour: 13, minute: 0), // 1:00 PM
    const TimeOfDay(hour: 15, minute: 0), // 3:00 PM
    const TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    const TimeOfDay(hour: 12, minute: 0), // 12:00 PM
  ];

  // متحكم لحقل العنوان
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // جلب الخدمات الميكانيكية عند تهيئة الشاشة
    context.read<MechanicalCubit>().getMechanical();
  }

  // دالة لاختيار التاريخ
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
        _selectedTime = null; // إعادة تعيين الوقت عند تغيير التاريخ
      });
    }
  }

  // Getter لتحديد ما إذا كان زر التأكيد مفعلاً
  bool get _isConfirmButtonEnabled {
    // يجب أن تكون الخدمات المختارة غير فارغة
    // يجب اختيار تاريخ
    // يجب اختيار وقت
    // يجب أن يكون اختيار الموقع صحيحًا:
    //   - إما فرع مختار إذا كان نوع الموقع "فرعنا"
    //   - أو عنوان مكتوب أو تم تفعيل "اتصل بنا" إذا كان نوع الموقع "موقعي"
    return _selectedServices.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        (_selectedLocationType == LocaleKeys.ourBranch.tr() && _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation));
  }

  // دالة لعرض نافذة تأكيد الطلب
  void _confirmService() {
    // تجهيز قائمة الخدمات المختارة
    String servicesList = _selectedServices.map((s) => '${s.subServiceName} (${s.description})').join(', ');
    // تجهيز التاريخ
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A';
    // تجهيز الوقت
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A';
    // تجهيز تفاصيل الموقع
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
      location = 'Branch: $_selectedBranch';
    } else {
      location = 'Location not specified';
    }

    // عرض AlertDialog واحد فقط لتأكيد الطلب
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(LocaleKeys.SelectedServices.tr(args: [servicesList])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Date.tr(args: [date])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Time.tr(args: [time])),
                const SizedBox(height: 8),
                Text(LocaleKeys.Location.tr(args: [location])),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الـ AlertDialog
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                // طباعة تفاصيل الطلب في الـ Debug Console عند التأكيد
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop(); // إغلاق الـ AlertDialog بعد التأكيد
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
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
        showLeading: true,
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // القسم 1: اختر خدماتك
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            16.verticalSpace,
            BlocBuilder<MechanicalCubit, MechanicalStates>(
              builder: (context, state) {
                if (state is MechanicalLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MechanicalSuccessState) {
                  final List<DatumMechanical> mechanicalServices = state.value.data ?? [];
                  if (mechanicalServices.isEmpty) {
                    return Center(child: Text(LocaleKeys.NoServicesAvailable.tr()));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: mechanicalServices.length,
                    itemBuilder: (context, index) {
                      final service = mechanicalServices[index];
                      final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
                  );
                } else if (state is MechanicalErrorState) {
                  return Center(child: Text(LocaleKeys.ErrorLoadingServices.tr(args: [state.error])));
                }
                return const SizedBox.shrink(); // في حالة InitialState أو أي حالة أخرى
              },
            ),
            24.verticalSpace,

            // القسم 2: متى تحتاج الخدمة؟
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار التاريخ
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : LocaleKeys.SelectDate.tr(),
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            16.verticalSpace,

            // جزء اختيار الوقت باستخدام قائمة أفقية من الـ chips
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys.SelectTime.tr(),
                      style: getSmallStyle(
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
                        selectedColor: AppColors.primaryColor.withOpacity(0.7),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedTime = selected ? time : null;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: isSelected ? AppColors.primaryColor : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        elevation: isSelected ? 4 : 1,
                      );
                    }).toList(),
                  ),
                ],
              ),

            24.verticalSpace,

            // القسم 3: أين نقدم الخدمة؟
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            10.verticalSpace,

            // جزء اختيار الموقع
            Column(
              children: [
                LocationPart(
                  title: LocaleKeys.AtMyLocationanywhere.tr(),
                  value: LocaleKeys.mylocation.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _selectedBranch = null;
                      _addressController.clear(); // Clear address when switching location type
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
                            labelStyle: getSmallStyle(color: AppColors.primaryColor),
                            hintText: LocaleKeys.ElnezlawyStBuilding10Apt5.tr(),
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
                                LocaleKeys.NavigatingtoContactUsscreen.tr(),
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
            ),

            30.verticalSpace,

            // زر تأكيد الخدمة
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null,
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
                LocaleKeys.ConfirmService.tr(),
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
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
import 'package:mechpro/feature/repairing_mechanical_faults/data/models/response/mechanical_response/datum_mechanical.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';

// (هنا تكملة imports)

import '../../../../core/widgets/section_header.dart';
import '../cubit/mechanical_cubit.dart';
import '../cubit/mechanical_state.dart';

class RepairingMechanicalFaultsView extends StatefulWidget {
  const RepairingMechanicalFaultsView({super.key});

  @override
  State<RepairingMechanicalFaultsView> createState() =>
      _RepairingMechanicalFaultsViewState();
}

class _RepairingMechanicalFaultsViewState
    extends State<RepairingMechanicalFaultsView> {
  static final Map<String, IconData> _serviceIcons = {
    'Engine and Transmission Repair': Icons.car_crash,
    'Suspension and Steering Repair': Icons.settings,
    'Brake System Repair': Icons.sports_hockey_sharp,
    'Exhaust System Repair': Icons.car_repair,
    'Electrical Faults': Icons.electrical_services,
    'AC System Repair': Icons.ac_unit,
    'Exhaust System Fix': Icons.car_repair,
    'Other Mechanical Issues': Icons.miscellaneous_services,
  };

  final Set<DatumMechanical> _selectedServices = {};
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
    context.read<MechanicalCubit>().getMechanical();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF336f67),
            colorScheme: const ColorScheme.light(primary: Color(0xFF336f67)),
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
        (_selectedLocationType == LocaleKeys.ourBranch.tr() &&
                _selectedBranch != null ||
            _selectedLocationType == LocaleKeys.mylocation.tr() &&
                (_addressController.text.isNotEmpty ||
                    _hasContactedForLocation));
  }

  void _confirmService() {
    String servicesList = _selectedServices
        .map((s) => '${s.subServiceName} (${s.description})')
        .join(', ');
    String date = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : 'N/A';
    String time = _selectedTime != null
        ? _selectedTime!.format(context)
        : 'N/A';
    String location;

    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      location = _addressController.text.isNotEmpty
          ? 'Customer\'s Location: ${_addressController.text}'
          : 'Customer\'s Location (Will contact for details)';
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
      location = 'Branch: $_selectedBranch';
    } else {
      location = 'Location not specified';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          title: Text(
            LocaleKeys.ConfirmServiceRequest.tr(),
            textAlign: TextAlign.left,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // **تم تعديل هذه السطور لدمج النص مع المتغير مباشرة**
                Text('${LocaleKeys.SelectedServices.tr()}: $servicesList'),
                const SizedBox(height: 8),
                Text('${LocaleKeys.Date.tr()}: $date'),
                const SizedBox(height: 8),
                Text('${LocaleKeys.Time.tr()}: $time'),
                const SizedBox(height: 8),
                Text('${LocaleKeys.Location.tr()}: $location'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocaleKeys.Close.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                print('Service Confirmed for Mechanical Faults:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      LocaleKeys.Yourrequesthasbeenconfirmedsuccessfully.tr(),
                    ),
                  ),
                );
              },
              child: Text(LocaleKeys.Confirm.tr()),
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
        onLeadingPressed: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // القسم 1: اختر خدماتك
            SectionHeader(
              leadingText: '1',
              title: LocaleKeys.Chooseyourservices.tr(),
            ),
            17.verticalSpace,
            BlocBuilder<MechanicalCubit, MechanicalStates>(
              builder: (context, state) {
                if (state is MechanicalLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MechanicalSuccessState) {
                  final List<DatumMechanical> mechanicalServices =
                      state.value.data ?? [];
                  if (mechanicalServices.isEmpty) {
                    return Center(
                      child: Text(LocaleKeys.NoServicesAvailable.tr()),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: mechanicalServices.length,
                    itemBuilder: (context, index) {
                      final service = mechanicalServices[index];
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
                  );
                } else if (state is MechanicalErrorState) {
                  return Center(
                    child: Text(
                      LocaleKeys.ErrorLoadingServices.tr(args: [state.error]),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            17.verticalSpace,

            // القسم 2: متى تحتاج الخدمة؟
            SectionHeader(
              leadingText: '2',
              title: LocaleKeys.WhenDoYouNeedtheService.tr(),
            ),
            17.verticalSpace,

            // جزء اختيار التاريخ
            DateTimePickerPart(
              context: context,
              label: LocaleKeys.Date.tr(),
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : LocaleKeys.SelectDate.tr(),
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            17.verticalSpace,
            // جزء اختيار الوقت
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      LocaleKeys
                          .SelectTime.tr(), // هذا المفتاح موجود في الـ JSON بدون مشكلة
                      style: getSmallStyle(
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
                        selectedColor: AppColors.primaryColor.withOpacity(0.7),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
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
                                ? AppColors.primaryColor
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

            // القسم 3: أين نقدم الخدمة؟
            SectionHeader(
              leadingText: '3',
              title: LocaleKeys.WhereDoWeProvidetheService.tr(),
            ),
            17.verticalSpace,

            // جزء اختيار الموقع
            Column(
              children: [
                LocationPart(
                  title: LocaleKeys.AtMyLocationanywhere.tr(),
                  value: LocaleKeys.mylocation.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _selectedBranch = null;
                      _addressController.clear();
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
                            labelText: LocaleKeys
                                .EnterYourDetailedAddressOptional.tr(),
                            labelStyle: getSmallStyle(
                              color: AppColors.primaryColor,
                            ),
                            hintText: LocaleKeys.ElnezlawyStBuilding10Apt5.tr(),
                            hintStyle: getSmallStyle(
                              color: AppColors.primaryColor,
                            ),
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
                      17.verticalSpace,
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
                                LocaleKeys.NavigatingtoContactUsscreen.tr(),
                                style: getSmallStyle(
                                  color: AppColors.primaryColor,
                                ),
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
                17.verticalSpace,
                LocationPart(
                  title: LocaleKeys.AtOneofOurBranches.tr(),
                  value: LocaleKeys.ourBranch.tr(),
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
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
                      items: _branches.map<DropdownMenuItem<String>>((
                        String branch,
                      ) {
                        return DropdownMenuItem<String>(
                          value: branch,
                          child: Text(branch, textAlign: TextAlign.left),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),

            17.verticalSpace,

            // زر تأكيد الخدمة
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null,
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
                LocaleKeys.ConfirmService.tr(),
                style: getSmallStyle(color: AppColors.whColor),
              ),
            ),
            17.verticalSpace,
          ],
        ),
      ),
    );
  }
}
