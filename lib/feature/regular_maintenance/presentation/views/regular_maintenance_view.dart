/*import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/text_style.dart';


class RegularMaintenanceView extends StatelessWidget {
  const RegularMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: SingleChildScrollView(
  child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
      Header(),
      HeaderServices(),
      Gap(10),
      
      
      ],),
    ),
  ),
),




    );
  }
}

class HeaderServices extends StatelessWidget {
  const HeaderServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.bgColor],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
             '1',
             style: getSmallStyle(color: AppColors.whColor),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
         'Choose your services',
          style: getSmallStyle(color: AppColors.blackColor,fontSize: 20),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                
                    Expanded(
                      child: Text(
                        'Request the services',
                        style: getBodyStyle(),
                        
                        ),

                    ),
         IconButton(
                      icon: Icon(Icons.arrow_forward, color: AppColors.blackColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                 
                  ],
                ),
              );
  }
}



*/

/*

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

class RegularMaintenanceView extends StatefulWidget {
  const RegularMaintenanceView({super.key});

  @override
  State<RegularMaintenanceView> createState() => _RegularMaintenanceViewState();
}
class Service {
  final String name;
  final String description; 
  final IconData icon; 

  Service({required this.name, required this.description, required this.icon});
}
// The State class for RegularMaintenanceView.
// It holds the mutable state for the screen.
class _RegularMaintenanceViewState extends State<RegularMaintenanceView> {
  // List of all available services.
  final List<Service> services = [
    Service(
      name: 'Change Oils and Fluids',
      description: 'Includes changing engine oil, brake fluid, coolant.',
      icon: Icons.oil_barrel, // Icon for oil change.
    ),
    Service(
      name: 'Check and Change Filters',
      description: 'Inspection and replacement of air, oil, and fuel filters.',
      icon: Icons.filter_alt, // Icon for filters.
    ),
    Service(
      name: 'Check Brake and Suspension System',
      description: 'Comprehensive inspection of brakes and suspension system for safety.',
      icon: Icons.car_repair, // Icon for car repair/brakes.
    ),
    Service(
      name: 'Check Cooling System',
      description: 'Checking the cooling system and coolant level.',
      icon: Icons.ac_unit, // Icon for cooling system.
    ),
    Service(
      name: 'Check Tires and Adjust Air Pressure',
      description: 'Tread depth inspection and tire pressure adjustment.',
      icon: Icons.tire_repair, // Icon for tire repair.
    ),
  ];

  // State variables to manage user selections.
  final Set<Service> _selectedServices = {}; // Stores selected services.
  DateTime? _selectedDate; // Stores the chosen date.
  TimeOfDay? _selectedTime; // Stores the chosen time.
  String? _selectedLocationType; // 'my_location' or 'our_branches' to track location choice.
  String? _selectedBranch; // Stores the name of the selected branch.
  bool _hasContactedForLocation = false; // New state variable to track if "Contact Us" button was pressed.

  // Dummy list of branches for demonstration purposes.
  final List<String> _branches = [
    'Riyadh Branch - Al Nakheel District',
    'Jeddah Branch - Prince Sultan Street',
    'Dammam Branch - King Fahd Road',
    'Cairo Branch - Nasr City',
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

  // Function to display a date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Initial date is current date or previously selected.
      firstDate: DateTime.now(), // User cannot select a past date.
      lastDate: DateTime.now().add(const Duration(days: 365)), // User can select up to one year in advance.
      builder: (BuildContext context, Widget? child) {
        return Theme( // Customizes the theme of the date picker.
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF336f67), // Header background color of the date picker.
            colorScheme: const ColorScheme.light(primary: Color(0xFF336f67)), // Color for selected day.
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
    return _selectedServices.isNotEmpty && // At least one service must be selected.
        _selectedDate != null && // A date must be selected.
        _selectedTime != null && // A time must be selected.
        (_selectedLocationType == 'our_branches' && _selectedBranch != null || // If branch, a branch must be chosen.
            _selectedLocationType == 'my_location' && (_addressController.text.isNotEmpty || _hasContactedForLocation)); // If my location, either address or contact button must be used.
  }

  // Function to handle the service confirmation logic.
  void _confirmService() {
    // Collects all selected data for confirmation.
    String servicesList = _selectedServices.map((s) => s.name).join(', '); // Joins selected service names.
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A'; // Formats date.
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A'; // Formats time.
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)), // Rounded corners for the dialog.
          title: const Text(
            'Confirm Service Request', // Dialog title.
            textAlign: TextAlign.left, // Align title to the left for LTR.
          ),
          content: SingleChildScrollView( // Allows content to scroll if it's too long.
            child: ListBody( // Arranges text widgets vertically.
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
            ElevatedButton( // Changed to ElevatedButton for consistency with theme.
              onPressed: () {
                // In a real app, this is where you'd send data to a backend.
                // For this example, we just print to console and show a SnackBar.
                print('Service Confirmed:');
                print('Services: $servicesList');
                print('Date: $date');
                print('Time: $time');
                print('Location: $location');
                Navigator.of(context).pop(); // Closes the dialog.
                ScaffoldMessenger.of(context).showSnackBar( // Shows a success message.
                  const SnackBar(content: Text('Your request has been confirmed successfully!')),
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
    return Scaffold( // Provides the basic Material Design visual structure.
      appBar: AppBar( // Top application bar.
       backgroundColor: AppColors.primaryColor,
        title:  Text(
          'Request Your Service', // App bar title.
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true, // Centers the title.
        elevation: 0, // Removes shadow under the app bar.
        shape: const RoundedRectangleBorder( // Adds rounded corners to the bottom of the app bar.
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
     
     
      body: Padding( // Adds padding around the content.
        padding: const EdgeInsets.all(16.0),
        child: ListView( // Makes the content scrollable.
          children: [
            // Section 1: Choose Your Services
            _buildSectionTitle('1. Choose Your Services'), // Helper for section title.
            GridView.builder( // Displays services in a grid.
              shrinkWrap: true, // Takes only as much space as its children.
              physics: const NeverScrollableScrollPhysics(), // Disables GridView's own scrolling.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns in the grid.
                crossAxisSpacing: 16.0, // Horizontal spacing.
                mainAxisSpacing: 16.0, // Vertical spacing.
                childAspectRatio: 0.7, // Aspect ratio for each card.
              ),
              itemCount: services.length, // Number of service cards.
              itemBuilder: (context, index) {
                final service = services[index];
                final isSelected = _selectedServices.contains(service);
                return GestureDetector( // Makes the card tappable.
                  onTap: () {
                    setState(() { // Updates the UI when a service is selected/deselected.
                      if (isSelected) {
                        _selectedServices.remove(service);
                      } else {
                        _selectedServices.add(service);
                      }
                    });
                  },
                  child: ServiceCard( // Custom widget for each service card.
                    service: service,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
            const SizedBox(height: 32.0), // Spacer.

            // Section 2: Select Date and Time
            _buildSectionTitle('2. When Do You Need the Service?'),
            _buildDateTimePicker( // Helper for date input field.
              context,
              label: 'Date',
              value: _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : 'Select Date',
              icon: Icons.calendar_today,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16.0), // Spacer.
            // Time selection using a horizontal list of chips
            if (_selectedDate != null) // Only show time options if a date is selected.
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
                    runSpacing: 8.0, // Vertical space between rows of chips.
                    children: _availableTimes.map((time) {
                      final isSelected = _selectedTime == time;
                      return ChoiceChip(
                        label: Text(time.format(context)),
                        selected: isSelected,
                        selectedColor: const Color(0xFF336f67).withOpacity(0.7), // Selected chip color.
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87, // Text color.
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
                            color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                            width: 1.5,
                          ),
                        ),
                        elevation: isSelected ? 4 : 1,
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 32.0), // Spacer.

            // Section 3: Select Location
            _buildSectionTitle('3. Where Do We Provide the Service?'),
            Column( // Arranges location options vertically.
              children: [
                _buildLocationOption( // Helper for location radio button.
                  title: 'At My Location (anywhere)',
                  value: 'my_location',
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _selectedBranch = null; // Clears branch if 'my_location' is chosen.
                      _hasContactedForLocation = false; // Reset contact status when location type changes.
                    });
                  },
                ),
                const SizedBox(height: 16.0), // Spacer.
                if (_selectedLocationType == 'my_location') // Shows contact button and address input only if 'my_location' is selected.
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField( // Text field for detailed address.
                          controller: _addressController,
                          textAlign: TextAlign.left, // Align text to left for LTR.
                          decoration: InputDecoration(
                            labelText: 'Enter Your Detailed Address (Optional)', // Made optional.
                            hintText: 'e.g., King Fahd St, Building 10, Apt 5',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
                            const SnackBar(content: Text('Navigating to Contact Us screen...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF336f67), 
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          elevation: 5,
                        ),
                        child: const Text(
                         'Contact us to specify the address',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  7.verticalSpace,
                _buildLocationOption( 
                  title: 'At One of Our Branches',
                  value: 'our_branches',
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _addressController.clear(); 
                      _hasContactedForLocation = false; 
                    });
                  },
                ),
                if (_selectedLocationType == 'our_branches') 
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: DropdownButtonFormField<String>( 
                      value: _selectedBranch,
                      hint: const Text('Select Branch', textAlign: TextAlign.left),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: const Icon(Icons.store),
                        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
            40.verticalSpace,
            // Confirmation Button
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null, 
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0), 
                elevation: 5, 
              ),
              child: const Text(
                'Confirm Service', 
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0), 
          ],
        ),
      ),
    );
  }

 
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF336f67), 
        ),
        textAlign: TextAlign.left, 
      ),
    );
  }

  // Helper widget to build consistent date/time picker input fields.
  Widget _buildDateTimePicker(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return InkWell( 
      onTap: onTap,
      child: InputDecorator( 
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF336f67)), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF336f67)), 
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
          textAlign: TextAlign.left, 
        ),
      ),
    );
  }

  // Helper widget to build consistent location radio button options.
  Widget _buildLocationOption({
    required String title,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Card( 
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide( 
          color: groupValue == value ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: groupValue == value ? 2.0 : 1.0,
        ),
      ),
      elevation: groupValue == value ? 4 : 1, 
      child: RadioListTile<String>( 
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: groupValue == value ? const Color(0xFF336f67) : Colors.black87,
          ),
          textAlign: TextAlign.left, 
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: const Color(0xFF336f67), 
        controlAffinity: ListTileControlAffinity.trailing, 
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose(); 
    super.dispose();
  }
}

// Widget for a single service card.
// This is a StatelessWidget as its properties are immutable once created.
class ServiceCard extends StatelessWidget {
  final Service service;
  final bool isSelected; 

  const ServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card( // The card container for each service.
      elevation: isSelected ? 8 : 2, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), 
        side: BorderSide( 
          color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: isSelected ? 3.0 : 1.0,
        ),
      ),
      color: isSelected ? const Color(0xFF336f67).withOpacity(0.1) : Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(12.0), 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Align( // Aligns the selection icon to the top right.
              alignment: Alignment.topRight, 
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked, 
                color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                size: 24,
              ),
            ),
            Icon( // Service icon.
              service.icon,
              size: 50,
              color: isSelected ? const Color(0xFF336f67) : Colors.blueGrey,
            ),
            7.verticalSpace,
           
            Text( // Service name.
              service.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF336f67).withOpacity(0.9) : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, 
            ),
            4.verticalSpace,
           
            Text( // Service description.
              service.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: isSelected ? const Color(0xFF336f67).withOpacity(0.7) : Colors.grey.shade600,
              ),
              maxLines: 2, 
              overflow: TextOverflow.ellipsis,
            ),
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
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';

class RegularMaintenanceView extends StatefulWidget {
  const RegularMaintenanceView({super.key});

  @override
  State<RegularMaintenanceView> createState() => _RegularMaintenanceViewState();
}

class Service {
  final String name;
  final String description;
  final IconData icon;

  Service({required this.name, required this.description, required this.icon});
}

class _RegularMaintenanceViewState extends State<RegularMaintenanceView> {

  final List<Service> services = [
    Service(
      name: 'Change Oils and Fluids',
      description: 'Includes changing engine oil, brake fluid, coolant.',
      icon: Icons.oil_barrel, 
    ),
    Service(
      name: 'Check and Change Filters',
      description: 'Inspection and replacement of air, oil, and fuel filters.',
      icon: Icons.filter_alt, // Icon for filters.
    ),
    Service(
      name: 'Check Brake and Suspension System',
      description:
          'Comprehensive inspection of brakes and suspension system for safety.',
      icon: Icons.car_repair, // Icon for car repair/brakes.
    ),
    Service(
      name: 'Check Cooling System',
      description: 'Checking the cooling system and coolant level.',
      icon: Icons.ac_unit, // Icon for cooling system.
    ),
    Service(
      name: 'Check Tires and Adjust Air Pressure',
      description: 'Tread depth inspection and tire pressure adjustment.',
      icon: Icons.tire_repair, // Icon for tire repair.
    ),
  ];

  // State variables to manage user selections.
  final Set<Service> _selectedServices = {}; // Stores selected services.
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

  // Function to display a date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ??
          DateTime
              .now(), // Initial date is current date or previously selected.
      firstDate: DateTime.now(), // User cannot select a past date.
      lastDate: DateTime.now().add(const Duration(
          days: 365)), // User can select up to one year in advance.
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Customizes the theme of the date picker.
          data: ThemeData.light().copyWith(
            primaryColor: const Color(
                0xFF336f67), // Header background color of the date picker.
            colorScheme: const ColorScheme.light(
                primary: Color(0xFF336f67)), // Color for selected day.
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
        .map((s) => s.name)
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
              borderRadius:
                  BorderRadius.circular(7)), // Rounded corners for the dialog.
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
                          'Your request has been confirmed successfully!')),
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
      // Provides the basic Material Design visual structure.
      appBar: AppBar(
        // Top application bar.
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Request Your Service', // App bar title.
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true, // Centers the title.
        elevation: 0, // Removes shadow under the app bar.
        shape: const RoundedRectangleBorder(
          // Adds rounded corners to the bottom of the app bar.
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),

      body: Padding(
        // Adds padding around the content.
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // Makes the content scrollable.
          children: [
            // Section 1: Choose Your Services
            _buildSectionTitle(
                '1. Choose Your Services'), // Helper for section title.
            GridView.builder(
              // Displays services in a grid.
              shrinkWrap: true, // Takes only as much space as its children.
              physics:
                  const NeverScrollableScrollPhysics(), // Disables GridView's own scrolling.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns in the grid.
                crossAxisSpacing: 16.0, // Horizontal spacing.
                mainAxisSpacing: 16.0, // Vertical spacing.
                childAspectRatio: 0.7, // Aspect ratio for each card.
              ),
              itemCount: services.length, // Number of service cards.
              itemBuilder: (context, index) {
                final service = services[index];
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
                  ),
                );
              },
            ),
            const SizedBox(height: 32.0), // Spacer.

            // Section 2: Select Date and Time
            _buildSectionTitle('2. When Do You Need the Service?'),
            _buildDateTimePicker(
              // Helper for date input field.
              context,
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
                    runSpacing: 8.0, // Vertical space between rows of chips.
                    children: _availableTimes.map((time) {
                      final isSelected = _selectedTime == time;
                      return ChoiceChip(
                        label: Text(time.format(context)),
                        selected: isSelected,
                        selectedColor: const Color(0xFF336f67)
                            .withOpacity(0.7), // Selected chip color.
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black87, // Text color.
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
            const SizedBox(height: 32.0), // Spacer.

            // Section 3: Select Location
            _buildSectionTitle('3. Where Do We Provide the Service?'),
            Column(
              // Arranges location options vertically.
              children: [
                _buildLocationOption(
                  // Helper for location radio button.
                  title: 'At My Location (anywhere)',
                  value: 'my_location',
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
                const SizedBox(height: 16.0), // Spacer.
                if (_selectedLocationType ==
                    'my_location') // Shows contact button and address input only if 'my_location' is selected.
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          // Text field for detailed address.
                          controller: _addressController,
                          textAlign:
                              TextAlign.left, // Align text to left for LTR.
                          decoration: InputDecoration(
                            labelText:
                                'Enter Your Detailed Address (Optional)', // Made optional.
                            hintText: 'e.g., King Fahd St, Building 10, Apt 5',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.location_on),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
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
                            const SnackBar(
                                content:
                                    Text('Navigating to Contact Us screen...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF336f67),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Contact us to specify the address',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                7.verticalSpace,
                _buildLocationOption(
                  title: 'At One of Our Branches',
                  value: 'our_branches',
                  groupValue: _selectedLocationType,
                  onChanged: (value) {
                    setState(() {
                      _selectedLocationType = value;
                      _addressController.clear();
                      _hasContactedForLocation = false;
                    });
                  },
                ),
                if (_selectedLocationType == 'our_branches')
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedBranch,
                      hint: const Text('Select Branch',
                          textAlign: TextAlign.left),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        prefixIcon: const Icon(Icons.store),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                      ),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBranch = newValue;
                        });
                      },
                      items: _branches
                          .map<DropdownMenuItem<String>>((String branch) {
                        return DropdownMenuItem<String>(
                          value: branch,
                          child: Text(branch, textAlign: TextAlign.left),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
            40.verticalSpace,
            // Confirmation Button
            ElevatedButton(
              onPressed: _isConfirmButtonEnabled ? _confirmService : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                elevation: 5,
              ),
              child: const Text(
                'Confirm Service',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF336f67),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  // Helper widget to build consistent date/time picker input fields.
  Widget _buildDateTimePicker(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF336f67)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF336f67)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  // Helper widget to build consistent location radio button options.
  Widget _buildLocationOption({
    required String title,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: groupValue == value
              ? const Color(0xFF336f67)
              : Colors.grey.shade300,
          width: groupValue == value ? 2.0 : 1.0,
        ),
      ),
      elevation: groupValue == value ? 4 : 1,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                groupValue == value ? const Color(0xFF336f67) : Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: const Color(0xFF336f67),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

// Widget for a single service card.
// This is a StatelessWidget as its properties are immutable once created.
class ServiceCard extends StatelessWidget {
  final Service service;
  final bool isSelected;

  const ServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // The card container for each service.
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: isSelected ? 3.0 : 1.0,
        ),
      ),
      color:
          isSelected ? const Color(0xFF336f67).withOpacity(0.1) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              // Aligns the selection icon to the top right.
              alignment: Alignment.topRight,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color:
                    isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                size: 24,
              ),
            ),
            Icon(
              // Service icon.
              service.icon,
              size: 50,
              color: isSelected ? const Color(0xFF336f67) : Colors.blueGrey,
            ),
            7.verticalSpace,
            Text(
              // Service name.
              service.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? const Color(0xFF336f67).withOpacity(0.9)
                    : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            4.verticalSpace,
            Text(
              // Service description.
              service.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: isSelected
                    ? const Color(0xFF336f67).withOpacity(0.7)
                    : Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // import bloc
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/core/utils/app_color.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/text_style.dart';
import '../../data/models/response/regular_response/datum.dart'; // Import the Datum model
import '../cubit/regular_services_cubit.dart'; // Import the Cubit
import '../cubit/regular_services_state.dart'; // Import the States

// قم بإزالة هذا الكلاس Service لأنه سيتم استبداله بـ Datum من الـ API
// class Service {
//   final String name;
//   final String description;
//   final IconData icon;
//   Service({required this.name, required this.description, required this.icon});
// }

class RegularMaintenanceView extends StatefulWidget {
  const RegularMaintenanceView({super.key});

  @override
  State<RegularMaintenanceView> createState() => _RegularMaintenanceViewState();
}

class _RegularMaintenanceViewState extends State<RegularMaintenanceView> {
  // خريطة لربط اسم الخدمة بالأيقونة (حيث أن الـ API لا يوفر أيقونات مباشرة)
  static final Map<String, IconData> _serviceIcons = {
    'Oil and Fluid Change': Icons.oil_barrel,
    'Filter Replacement': Icons.filter_alt,
    'Brake and Suspension Check': Icons.car_repair,
    'Cooling System Check': Icons.ac_unit,
    'Tire Check and Air Pressure': Icons.tire_repair,
    // أضف المزيد من الخدمات هنا إذا كانت موجودة في الـ API مع أيقونات مناسبة
    // استخدم اسم الخدمة الدقيق كما يأتي من الـ API كمفتاح
    // مثال: 'Electrical Check': Icons.electrical_services,
  };

  // State variables to manage user selections.
  final Set<Datum> _selectedServices = {}; // Stores selected services (now Datum objects).
  DateTime? _selectedDate; // Stores the chosen date.
  TimeOfDay? _selectedTime; // Stores the chosen time.
  String? _selectedLocationType; // 'my_location' or 'our_branches' to track location choice.
  String? _selectedBranch; // Stores the name of the selected branch.
  bool _hasContactedForLocation = false; // New state variable to track if "Contact Us" button was pressed.

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
      initialDate: _selectedDate ?? DateTime.now(), // Initial date is current date or previously selected.
      firstDate: DateTime.now(), // User cannot select a past date.
      lastDate: DateTime.now().add(const Duration(days: 365)), // User can select up to one year in advance.
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Customizes the theme of the date picker.
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF336f67), // Header background color of the date picker.
            colorScheme: const ColorScheme.light(primary: Color(0xFF336f67)), // Color for selected day.
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
    return _selectedServices.isNotEmpty && // At least one service must be selected.
        _selectedDate != null && // A date must be selected.
        _selectedTime != null && // A time must be selected.
        (_selectedLocationType == 'our_branches' && _selectedBranch != null || // If branch, a branch must be chosen.
            _selectedLocationType == 'my_location' &&
                (_addressController.text.isNotEmpty || _hasContactedForLocation)); // If my location, either address or contact button must be used.
  }

  // Function to handle the service confirmation logic.
  void _confirmService() {
    // Collects all selected data for confirmation.
    String servicesList = _selectedServices.map((s) => s.subServiceName ?? 'Unknown Service').join(', '); // Joins selected service names.
    String date = _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'N/A'; // Formats date.
    String time = _selectedTime != null ? _selectedTime!.format(context) : 'N/A'; // Formats time.
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)), // Rounded corners for the dialog.
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
                  const SnackBar(content: Text('Your request has been confirmed successfully!')),
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Request Your Service', // App bar title.
          style: getBodyStyle(color: AppColors.whColor),
        ),
        centerTitle: true, // Centers the title.
        elevation: 0, // Removes shadow under the app bar.
        shape: const RoundedRectangleBorder(
          // Adds rounded corners to the bottom of the app bar.
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: BlocBuilder<RegularServicesCubit, RegularServicesState>(
        builder: (context, state) {
          if (state is RegularServicesLoadingState || state is RegularServicesInitial) {
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
            final List<Datum>? servicesFromApi = (state as RegularServicesSuccessState).response.data;

            if (servicesFromApi == null || servicesFromApi.isEmpty) {
              return const Center(child: Text('No regular maintenance services found.'));
            }

            return Padding(
              // Adds padding around the content.
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // Makes the content scrollable.
                children: [
                  // Section 1: Choose Your Services
                  _buildSectionTitle('1. Choose Your Services'), // Helper for section title.
                  GridView.builder(
                    // Displays services in a grid.
                    shrinkWrap: true, // Takes only as much space as its children.
                    physics: const NeverScrollableScrollPhysics(), // Disables GridView's own scrolling.
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two columns in the grid.
                      crossAxisSpacing: 16.0, // Horizontal spacing.
                      mainAxisSpacing: 16.0, // Vertical spacing.
                      childAspectRatio: 0.7, // Aspect ratio for each card.
                    ),
                    itemCount: servicesFromApi.length, // Number of service cards from API.
                    itemBuilder: (context, index) {
                      final service = servicesFromApi[index];
                      // احصل على الأيقونة من الخريطة، أو استخدم أيقونة افتراضية
                      final IconData icon = _serviceIcons[service.subServiceName ?? ''] ?? Icons.miscellaneous_services;
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
                  const SizedBox(height: 32.0), // Spacer.

                  // Section 2: Select Date and Time
                  _buildSectionTitle('2. When Do You Need the Service?'),
                  _buildDateTimePicker(
                    // Helper for date input field.
                    context,
                    label: 'Date',
                    value: _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'Select Date',
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16.0), // Spacer.
                  // Time selection using a horizontal list of chips
                  if (_selectedDate != null) // Only show time options if a date is selected.
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
                          runSpacing: 8.0, // Vertical space between rows of chips.
                          children: _availableTimes.map((time) {
                            final isSelected = _selectedTime == time;
                            return ChoiceChip(
                              label: Text(time.format(context)),
                              selected: isSelected,
                              selectedColor: const Color(0xFF336f67).withOpacity(0.7), // Selected chip color.
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87, // Text color.
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
                                  color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                                  width: 1.5,
                                ),
                              ),
                              elevation: isSelected ? 4 : 1,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  const SizedBox(height: 32.0), // Spacer.

                  // Section 3: Select Location
                  _buildSectionTitle('3. Where Do We Provide the Service?'),
                  Column(
                    // Arranges location options vertically.
                    children: [
                      _buildLocationOption(
                        // Helper for location radio button.
                        title: 'At My Location (anywhere)',
                        value: 'my_location',
                        groupValue: _selectedLocationType,
                        onChanged: (value) {
                          setState(() {
                            _selectedLocationType = value;
                            _selectedBranch = null; // Clears branch if 'my_location' is chosen.
                            _hasContactedForLocation = false; // Reset contact status when location type changes.
                          });
                        },
                      ),
                      const SizedBox(height: 16.0), // Spacer.
                      if (_selectedLocationType ==
                          'my_location') // Shows contact button and address input only if 'my_location' is selected.
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: TextField(
                                // Text field for detailed address.
                                controller: _addressController,
                                textAlign: TextAlign.left, // Align text to left for LTR.
                                decoration: InputDecoration(
                                  labelText: 'Enter Your Detailed Address (Optional)', // Made optional.
                                  hintText: 'e.g., King Fahd St, Building 10, Apt 5',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  prefixIcon: const Icon(Icons.location_on),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
                                  const SnackBar(content: Text('Navigating to Contact Us screen...')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF336f67),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                elevation: 5,
                              ),
                              child: const Text(
                                'Contact us to specify the address',
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      7.verticalSpace,
                      _buildLocationOption(
                        title: 'At One of Our Branches',
                        value: 'our_branches',
                        groupValue: _selectedLocationType,
                        onChanged: (value) {
                          setState(() {
                            _selectedLocationType = value;
                            _addressController.clear();
                            _hasContactedForLocation = false;
                          });
                        },
                      ),
                      if (_selectedLocationType == 'our_branches')
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedBranch,
                            hint: const Text('Select Branch', textAlign: TextAlign.left),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              prefixIcon: const Icon(Icons.store),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
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
                  40.verticalSpace,
                  // Confirmation Button
                  ElevatedButton(
                    onPressed: _isConfirmButtonEnabled ? _confirmService : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Confirm Service',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // Fallback for unhandled states
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF336f67),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  // Helper widget to build consistent date/time picker input fields.
  Widget _buildDateTimePicker(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF336f67)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          prefixIcon: Icon(icon, color: const Color(0xFF336f67)),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  // Helper widget to build consistent location radio button options.
  Widget _buildLocationOption({
    required String title,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: groupValue == value ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: groupValue == value ? 2.0 : 1.0,
        ),
      ),
      elevation: groupValue == value ? 4 : 1,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: groupValue == value ? const Color(0xFF336f67) : Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: const Color(0xFF336f67),
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

// Widget for a single service card.
// This is a StatelessWidget as its properties are immutable once created.
class ServiceCard extends StatelessWidget {
  final Datum service; // Changed type to Datum
  final bool isSelected;
  final IconData icon; // Added icon to constructor

  const ServiceCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.icon, // Required icon
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // The card container for each service.
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade300,
          width: isSelected ? 3.0 : 1.0,
        ),
      ),
      color: isSelected ? const Color(0xFF336f67).withOpacity(0.1) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              // Aligns the selection icon to the top right.
              alignment: Alignment.topRight,
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? const Color(0xFF336f67) : Colors.grey.shade400,
                size: 24,
              ),
            ),
            Icon(
              // Service icon.
              icon, // Use the passed icon
              size: 50,
              color: isSelected ? const Color(0xFF336f67) : Colors.blueGrey,
            ),
            7.verticalSpace,
            Text(
              // Service name.
              service.subServiceName ?? 'N/A', // Use subServiceName from Datum
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF336f67).withOpacity(0.9) : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            4.verticalSpace,
            Text(
              // Service description.
              service.description ?? 'No description available', // Use description from Datum
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: isSelected ? const Color(0xFF336f67).withOpacity(0.7) : Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

