import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/text_style.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose(); // Dispose the new controller
    _nameController.dispose(); // Dispose name controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(AppAssets.logoIcon, width: 70, height: 70),
                  Text(
                    _isLogin
                        ? LocaleKeys.Welcomeback.tr()
                        : LocaleKeys.Createanewaccount.tr(),
                    style: getTitleStyle(fontSize: 20.0), // Smaller title
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    _isLogin
                        ? LocaleKeys.loginaccount.tr()
                        : LocaleKeys.PleaseSignUpToGetStarted
                            .tr(), // Placeholder text
                    style: getSmallStyle(fontSize: 12.0), // Smaller subtitle
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30.0), // Reduced height

                  // Login/Signup Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTabButton(LocaleKeys.LogIn.tr(), _isLogin),
                      _buildTabButton(LocaleKeys.signup.tr(), !_isLogin),
                    ],
                  ),
                  SizedBox(height: 15.0),

                  ContainerCustom(),

                  15.verticalSpace,

                  RichText(
                    text: TextSpan(
                      style: getSmallStyle(color: AppColors.blackColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: _isLogin
                                ? LocaleKeys.DonThaveanaccount.tr()
                                : LocaleKeys.lreadyhaveaccount.tr()),
                        TextSpan(
                          text: _isLogin
                              ? LocaleKeys.signup.tr()
                              : LocaleKeys.LogIn.tr(),
                          style: getSmallStyle(color: AppColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });

                              print(_isLogin
                                  ? 'Navigate to Login'
                                  : 'Navigate to Sign Up');
                            },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container ContainerCustom() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.whColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor,
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          if (!_isLogin) ...[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: LocaleKeys.name.tr(),
                labelStyle: TextStyle(fontSize: 14.0),
                prefixIcon: Icon(Icons.person, size: 20.0),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.Pleaseentername.tr();
                }
                return null;
              },
              style: const TextStyle(fontSize: 14.0),
            ),
            15.verticalSpace,
          ],
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: LocaleKeys.Email.tr(),
              labelStyle: TextStyle(fontSize: 14.0), // Smaller label
              prefixIcon: Icon(Icons.email, size: 17.0), // Smaller icon
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.Pleaseenteremail.tr();
              }
              // Email validation regex
              if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return LocaleKeys.Pleaseentervalidemail.tr();
              }
              return null;
            },
            style: const TextStyle(fontSize: 14.0), // Smaller text
          ),
          15.verticalSpace,
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: LocaleKeys.password.tr(),
              labelStyle: TextStyle(fontSize: 14.0), // Smaller label
              prefixIcon: Icon(Icons.lock, size: 17.0), // Smaller icon
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.Pleaseenterpassword.tr();
              }
              // Password strength validation
              if (value.length < 8) {
                return LocaleKeys.Passwordmustleast8characters.tr();
              }
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return LocaleKeys.Passwordmustcontainatleastoneuppercaseletter
                    .tr();
              }
              if (!value.contains(RegExp(r'[a-z]'))) {
                return LocaleKeys.Passwordmustcontainatleastonelowercaseletter
                    .tr();
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return LocaleKeys.Passwordmustcontainatleastonedigit.tr();
              }
              if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                return LocaleKeys.PasswordmustcontainatleastoneSpecialcharacter
                    .tr();
              }
              return null;
            },
            style: const TextStyle(fontSize: 14.0), // Smaller text
          ),
          15.verticalSpace,
          if (!_isLogin) ...[
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: LocaleKeys.repassword.tr(),
                labelStyle: TextStyle(fontSize: 14.0),
                prefixIcon: Icon(Icons.lock, size: 17.0),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.Pleaseconfirmyourpassword.tr();
                }
                if (value != _passwordController.text) {
                  return LocaleKeys.Passwordsdonotmatch.tr();
                }
                return null;
              },
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 10.0),
          ],
          if (_isLogin)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushReplacementNamed(Routes.forgetPasswordView);
                    //   context.pushReplacement(ForgetPasswordView());
                  },
                  child: Text(
                    LocaleKeys.forgotPassword.tr(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
          20.verticalSpace,
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String email = _emailController.text;
                String password = _passwordController.text;
                if (_isLogin) {
                  context.pushAndRemoveUntil(
                    Routes.layoutView,
                    routeBuilder:
                        AppRouter.buildRoute, // تمرير الدالة كـ callback
                    predicate: (route) => false,
                  );

                  // context.pushAndRemoveUntil(LayoutView());
                } else {
                  String name = _nameController.text;
                  print(
                      'Signup - Name: $name, Email: $email, Password: $password');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              _isLogin ? LocaleKeys.LogIn.tr() : LocaleKeys.signup.tr(),
              style: getSmallStyle(color: AppColors.whColor, fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  // Tab button widget
  Widget _buildTabButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLogin = text == LocaleKeys.LogIn.tr();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primaryColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? AppColors.primaryColor : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
