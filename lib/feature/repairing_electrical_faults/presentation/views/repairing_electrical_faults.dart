
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/date_time_picker_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/location_part.dart';
import 'package:mechpro/feature/regular_maintenance/presentation/widgets/service_card.dart'; 
import 'package:mechpro/feature/repairing_electrical_faults/data/models/response/electrical_response/datum_electrical.dart';


import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/section_header.dart';
import '../cubit/electrical_cubit.dart';
import '../cubit/electrical_state.dart';


import 'package:mechpro/feature/orders/data/models/request/order_request/order_request.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_service.dart';
import 'package:mechpro/feature/orders/data/models/request/order_request/order_request_sub_service.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_cubit.dart';
import 'package:mechpro/feature/orders/presentation/cubit/orders_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepairingElectricalFaults extends StatefulWidget {
  const RepairingElectricalFaults({super.key});

  @override
  State<RepairingElectricalFaults> createState() =>
      _RepairingElectricalFaultsState();
}

class _RepairingElectricalFaultsState extends State<RepairingElectricalFaults> {
  
  static final Map<String, IconData> _serviceIcons = {
    'Lighting System Repair': Icons.power_input,
    'Battery and Charging Repair': Icons.battery_charging_full,
    'Electronic Systems Repair': Icons.electric_car,
   
  };

  
  final Set<DatumElectrical> _selectedServices = {};
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
   
    context.read<ElectricalCubit>().getElectricalServices();
  }


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
   
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تسجيل الدخول لإجراء طلب.')),
      );
      return;
    }

   
    final String? firebaseUserId = user.uid;

    if (firebaseUserId == null) {
      print('ERROR: Firebase User ID is null. Cannot create order.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'خطأ: لم يتم العثور على معرف المستخدم. الرجاء تسجيل الدخول مرة أخرى.',
          ),
        ),
      );
      return;
    }

   
    final List<OrderRequestSubService> orderSubServices = _selectedServices
        .map(
          (service) => OrderRequestSubService(
            orderSubServiceName: service.subServiceName,
          ),
        )
        .toList();

  
    final orderRequestService = OrderRequestService(
      orderServiceName:
          "Electrical Fault Repair Service", 
      orderSubServices: orderSubServices,
    );

  
    String locationDetails;
    bool isHomeService = false;
    if (_selectedLocationType == LocaleKeys.mylocation.tr()) {
      locationDetails = _addressController.text.isNotEmpty
          ? _addressController.text
          : 'Will contact for details';
      isHomeService = true;
    } else if (_selectedLocationType == LocaleKeys.ourBranch.tr()) {
      locationDetails = _selectedBranch ?? 'Branch not selected';
      isHomeService = false;
    } else {
      locationDetails = 'Location not specified';
      isHomeService = false;
    }

   
    final orderRequest = OrderRequest(
      userId: firebaseUserId, 
      userName: user.displayName ?? user.email ?? 'Unknown User',
      orderServices: [orderRequestService],
      maintenanceCenter: locationDetails, 
      isHomeService: isHomeService,
      orderDate: DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
    );

   
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
                // تم دمج النصوص مع المتغيرات مباشرة بناءً على ملف الترجمة الحالي
                Text(
                  '${LocaleKeys.SelectedServices.tr()}: ${_selectedServices.map((s) => s.subServiceName).join(', ')}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${LocaleKeys.Date.tr()}: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                ),
                const SizedBox(height: 8),
                Text(
                  '${LocaleKeys.Time.tr()}: ${_selectedTime!.format(context)}',
                ),
                const SizedBox(height: 8),
                Text('${LocaleKeys.Location.tr()}: $locationDetails'),
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
                Navigator.of(
                  context,
                ).pop(); 
               
                context.read<OrdersCubit>().createNewOrder(orderRequest);
                print(
                  'تم الضغط على زر الحجز لـ: Electrical Fault Repair Service',
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
      body: MultiBlocListener(
       
        listeners: [
          BlocListener<ElectricalCubit, ElectricalState>(
            listener: (context, state) {
              if (state is ElectricalErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<OrdersCubit, OrdersState>(
            listener: (context, state) {
              if (state is CreateOrderLoading) {
                
              } else if (state is CreateOrderSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                Navigator.of(context).pushNamed(Routes.ordersView);
              } else if (state is CreateOrderError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: Padding(
          //padding: const EdgeInsets.all(16.0),
padding:  17.all,
          child: ListView(
            children: [
              // القسم 1: اختر خدماتك
              SectionHeader(
                leadingText: '1',
                title: LocaleKeys.Chooseyourservices.tr(),
              ),
              16.verticalSpace,
              BlocBuilder<ElectricalCubit, ElectricalState>(
                builder: (context, state) {
                  if (state is ElectricalLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ElectricalSuccessState) {
                   
                    final List<DatumElectrical> electricalServices =
                        state.response.data ?? [];

                    if (electricalServices.isEmpty) {
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
                      itemCount: electricalServices.length,
                      itemBuilder: (context, index) {
                        final service = electricalServices[index];
                        // استخدام subServiceName من DatumElectrical
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
                        
                          child: ServiceCard<DatumElectrical>(
                          
                            service: service,
                            isSelected: isSelected,
                            icon: icon,
                          ),
                        );
                      },
                    );
                  } else if (state is ElectricalErrorState) {
                    return Center(
                      child: Text(
                        LocaleKeys.ErrorLoadingServices.tr(
                          args: [state.message],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
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
                          selectedColor: AppColors.primaryColor.withOpacity(
                            0.7,
                          ),
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
                              hintText:
                                  LocaleKeys.ElnezlawyStBuilding10Apt5.tr(),
                              hintStyle: getSmallStyle(
                                color: AppColors.primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                             // prefixIcon: const Icon(Icons.location_on),

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
      ),
    );
  }
}
