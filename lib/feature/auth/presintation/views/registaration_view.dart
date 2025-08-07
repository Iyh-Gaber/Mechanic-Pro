

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 

import 'package:mechpro/core/extenstions/extentions.dart';
import 'package:mechpro/core/routing/app_router.dart';
import 'package:mechpro/core/routing/routes.dart';
import 'package:mechpro/core/translate/locale_keys.g.dart';
import 'package:mechpro/core/utils/app_color.dart';
import 'package:mechpro/core/utils/MangeSpacing.dart';
import 'package:mechpro/feature/auth/presintation/widgets/tab_buttom_custom.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/text_style.dart';
import '../cubit/auth_cubit.dart'; 
import '../cubit/auth_states.dart'; 

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // Helper method to show SnackBar messages
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      
      create: (context) => AuthCubit(FirebaseAuth.instance),
      child: Scaffold(
        backgroundColor: AppColors.whColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
            //  padding: MangeSpacing.,
              padding: const EdgeInsets.all(17.0),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                 
                  if (state is AuthSuccess) {
                    _showSnackBar(context, LocaleKeys.Authenticationsuccessful.tr());
                  
                    context.pushAndRemoveUntil(
                      Routes.layoutView,
                      routeBuilder: AppRouter.buildRoute,
                      predicate: (route) => false,
                    );
                  } else if (state is AuthError) {
                    _showSnackBar(context, state.message);
                  }
                },
                builder: (context, state) {
                 
                  final authCubit = context.read<AuthCubit>();
                  bool isLoginMode = (state is AuthInitial)
                      ? state.isLoginMode
                      : (state is AuthLoading)
                      ? state.isLoginMode
                      : (state is AuthError)
                      ? state.isLoginMode
                      : true; 

                  bool isLoading = state is AuthLoading;

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(AppAssets.logoIcon, width: 70, height: 70),
                        Text(
                          isLoginMode
                              ? LocaleKeys.Welcomeback.tr()
                              : LocaleKeys.Createanewaccount.tr(),
                          style: getTitleStyle(fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                        
                        17.verticalSpace,
                        Text(
                          isLoginMode
                              ? LocaleKeys.loginaccount.tr()
                              : LocaleKeys.PleaseSignUpToGetStarted.tr(),
                          style: getSmallStyle(fontSize: 17.0),
                          textAlign: TextAlign.center,
                        ),
                        
 17.verticalSpace,
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TabButtomCustom(context: context, text: LocaleKeys.LogIn.tr(), isActive: isLoginMode),
                            TabButtomCustom(context: context, text: LocaleKeys.signup.tr(), isActive: !isLoginMode),
                          ],
                        ),
                       
 17.verticalSpace,
                        _buildAuthFormContainer(
                          context,
                          isLoginMode,
                          isLoading,
                        ),

                         17.verticalSpace,

                        RichText(
                          text: TextSpan(
                            style: getSmallStyle(color: AppColors.blackColor,fontSize: 17),
                            children: <TextSpan>[
                              TextSpan(
                                text: isLoginMode
                                    ? LocaleKeys.DonThaveanaccount.tr()
                                    : LocaleKeys.lreadyhaveaccount.tr(),
                              ),
                              TextSpan(
                                text: isLoginMode
                                    ? LocaleKeys.signup.tr()
                                    : LocaleKeys.LogIn.tr(),
                                style: getSmallStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 17
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    
                                    authCubit.toggleAuthMode();
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }




  
  Widget _buildAuthFormContainer(
    BuildContext context,
    bool isLoginMode,
    bool isLoading,
  ) {
    final authCubit = context.read<AuthCubit>(); 

    return Container(
      padding: const EdgeInsets.all(17.0),
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
          if (!isLoginMode) ...[
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
              style: getSmallStyle(fontSize: 13.0),
            ),
            17.verticalSpace,
          ],
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: LocaleKeys.Email.tr(),
              labelStyle: TextStyle(fontSize: 14.0),
              prefixIcon: Icon(Icons.email, size: 20.0),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.Pleaseenteremail.tr();
              }
              if (!RegExp(
                r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(value)) {
                return LocaleKeys.Pleaseentervalidemail.tr();
              }
              return null;
            },
            style: getSmallStyle(fontSize: 13.0),
          ),
          17.verticalSpace,
          TextFormField(
            controller: _passwordController,
            obscureText: true, 
            decoration: InputDecoration(
              labelText: LocaleKeys.password.tr(),
              labelStyle: TextStyle(fontSize: 14.0),
              prefixIcon: Icon(Icons.lock, size: 20.0),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.Pleaseenterpassword.tr();
              }
              if (value.length < 8) {
                return LocaleKeys.Passwordmustleast8characters.tr();
              }
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return LocaleKeys
                    .Passwordmustcontainatleastoneuppercaseletter.tr();
              }
              if (!value.contains(RegExp(r'[a-z]'))) {
                return LocaleKeys
                    .Passwordmustcontainatleastonelowercaseletter.tr();
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return LocaleKeys.Passwordmustcontainatleastonedigit.tr();
              }
              if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
                return LocaleKeys
                    .PasswordmustcontainatleastoneSpecialcharacter.tr();
              }
              return null;
            },
            style: getSmallStyle(fontSize: 13.0),
          ),
          17.verticalSpace,
          if (!isLoginMode) ...[
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: LocaleKeys.repassword.tr(),
                labelStyle: TextStyle(fontSize: 14.0),
                prefixIcon: Icon(Icons.lock, size: 20.0),
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
              style: getSmallStyle(fontSize: 13),
            ),
           17.verticalSpace,
          ],
          if (isLoginMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushReplacementNamed(Routes.forgetPasswordView);
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
          17.verticalSpace,
          isLoading
              ? CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ) 
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();

                      if (isLoginMode) {
                        authCubit.signIn(email: email, password: password);
                      } else {
                        String name = _nameController.text.trim();
                        authCubit.register(
                          name: name,
                          email: email,
                          password: password,
                        );
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
                    isLoginMode
                        ? LocaleKeys.LogIn.tr()
                        : LocaleKeys.signup.tr(),
                    style: getSmallStyle(
                      color: AppColors.whColor,
                      fontSize: 17.0,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
