
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechpro/core/services/location_service.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/manage_padding.dart';
import 'package:mechpro/core/utils/text_style.dart';
import 'package:mechpro/core/widgets/custom_app_bar.dart';

import 'dart:io';


import 'package:mechpro/feature/cars_registration/presentation/views/add_new_car.dart';
import 'package:mechpro/feature/cars_registration/presentation/views/show_cars.dart';

import 'package:mechpro/feature/orders/presentation/views/orders_view.dart';




class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  User? _currentUser;
  bool _isLoading = true;
  bool _hasCars = false; 
  File? _imageFile; 
  String _userLanguage = 'en'; 

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
   
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = FirebaseAuth.instance.currentUser;
   
    _hasCars = false;

  
    _nameController.text = _currentUser?.displayName ?? '';
    _emailController.text = _currentUser?.email ?? '';
    _phoneController.text = '9752456789876'; 

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
     
      SystemNavigator.pop();
    } catch (e) {
      print("Error signing out: $e");
    }
  }


  Future<void> _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('From Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('From Internet (URL)'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showUrlInputDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  
  Future<void> _pickImage(ImageSource source) async {
 
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
    
    
      }
    // ignore: empty_catches
    } catch (e) {
   
    
    }
  }

 
  Future<void> _showUrlInputDialog() async {
    String? imageUrl = '';
    await showDialog(
      barrierColor: AppColors.primaryColor,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Image URL'),
          content: TextField(
            onChanged: (value) {
              imageUrl = value;
            },
            decoration: const InputDecoration(hintText: "Paste image URL here"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (imageUrl != null && imageUrl!.isNotEmpty) {
                 
                  print("Uploading image from URL: $imageUrl");
                  
                   setState(() { _imageFile = null; });
                   _currentUser?.updatePhotoURL(imageUrl!);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Load'),
            ),
          ],
        );
      },
    );
  }

 
  Future<void> _showSettingsDialog() async {
    final newUserData = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String currentLanguageInDialog = _userLanguage;
           return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Settings'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Language'),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentLanguageInDialog =
                                  currentLanguageInDialog == 'ar' ? 'en' : 'ar';
                            });
                          },
                          child: const Icon(
                            Icons.language,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(currentLanguageInDialog, style: getSmallStyle()),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      user.updateDisplayName(_nameController.text);
                    }

                    Navigator.of(context).pop({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'language': currentLanguageInDialog,
                    });
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (newUserData != null) {
     
      setState(() {
        _userLanguage = newUserData['language'];
        _currentUser = _currentUser?.copyWith(
          displayName: newUserData['name'],
          email: newUserData['email'],
        );
        _nameController.text = newUserData['name'];
        _emailController.text = newUserData['email'];
      });
    }
  }


  Future<void> _showPersonalDetailsDialog() async {
    final String? userName = _currentUser?.displayName;
    final String? userEmail = _currentUser?.email;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Personal Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(title: 'Name', value: userName ?? 'N/A'),
              const SizedBox(height: 10),
              _buildInfoRow(title: 'Email', value: userEmail ?? 'N/A'),
              const SizedBox(height: 10),
              _buildInfoRow(title: 'Phone', value: _phoneController.text),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)));
    }

    if (_currentUser == null) {
      return const Scaffold(body: Center(child: Text('User not signed in.')));
    }

    return Scaffold(
appBar: CustomAppBar(title: LocaleKeys.profile.tr(), showLeading: false
  
),
      

      body: SingleChildScrollView(
        child: Column(
          children: [


    


            _buildUserInfoSection(context),
            const SizedBox(height: 20),
            _buildProfileOptionsList(context),
            const SizedBox(height: 30),
            _buildLogoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    final String? profileImageUrl = _currentUser?.photoURL;
    final ImageProvider<Object>? backgroundImage;

    if (_imageFile != null) {
      backgroundImage = FileImage(_imageFile!);
    } else if (profileImageUrl != null) {
      backgroundImage = NetworkImage(profileImageUrl);
    } else {
      backgroundImage = null;
    }

    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 20),
      padding: 17.vertical,
      width: double.infinity,
      color: AppColors.whColor,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.grColor,
              backgroundImage: backgroundImage,
              child: backgroundImage == null
                  ? const Icon(Icons.person, size: 50, color: AppColors.whColor)
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.whColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم عرض المعلومات الشخصية في نفس الشاشة
  Widget _buildInfoRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: getSmallStyle(color: AppColors.grColor)),
        Text(value, style: getSmallStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProfileOptionsList(BuildContext context) {
    return Column(
      children: [
        _buildProfileOptionItem(
          icon: Icons.person,
          title: 'Personal Information',
          onTap: () {
            _showPersonalDetailsDialog();
          },
        ),
        _buildProfileOptionItem(
          icon: Icons.directions_car,
          title: 'Registered Cars',
          onTap: () {
            if (_hasCars) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ShowCarsView()),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNewCarsView()),
              );
            }
          },
        ),
        _buildProfileOptionItem(
          icon: Icons.history,
          title: 'Order History',
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const OrdersView()));
          },
        ),
        _buildProfileOptionItem(
          icon: Icons.credit_card,
          title: 'Payment Methods',
          onTap: () {
            _showPaymentMethods(context);
          },
        ),
        _buildProfileOptionItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () {
            _showSettingsDialog();
          },
          trailing: Text(
            _userLanguage,
            style: getSmallStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  void _showPaymentMethods(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Payment Methods', style: getTitleStyle(fontSize: 20)),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.money),
                title: Text('Cash', style: getSmallStyle()),
                subtitle: Text(
                  'Available',
                  style: getSmallStyle(color: Colors.green),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: Text('Credit/Debit Card', style: getSmallStyle()),
                subtitle: Text(
                  'Coming Soon',
                  style: getSmallStyle(color: AppColors.grColor),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.paypal),
                title: Text('PayPal', style: getSmallStyle()),
                subtitle: Text(
                  'Coming Soon',
                  style: getSmallStyle(color: AppColors.grColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(title, style: getSmallStyle(fontSize: 16)),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.redColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: _logout,
        child: Text(
          'Logout',
          style: getTitleStyle(
            color: AppColors.whColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


extension UserCopy on User {
  User copyWith({String? displayName, String? email}) {
    return _UserWithNewData(this, displayName: displayName, email: email);
  }
}


class _UserWithNewData implements User {
  final User _originalUser;
  final String? _newDisplayName;
  final String? _newEmail;

  _UserWithNewData(this._originalUser, {String? displayName, String? email})
    : _newDisplayName = displayName,
      _newEmail = email;

  @override

  String get uid => _originalUser.uid;
  @override
  String? get photoURL => _originalUser.photoURL;

  @override
  String? get displayName => _newDisplayName ?? _originalUser.displayName;
  @override
  String? get email => _newEmail ?? _originalUser.email;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return _originalUser.noSuchMethod(invocation);
  }
}
