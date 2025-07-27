/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:mechpro/feature/auth/presintation/cubit/auth_states.dart';
import 'package:bloc/bloc.dart';
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitState());
register ({
  required String name,
 required String email,
 required String password
}
) async {
emit(AuthLoadingState());
try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  emit(AuthSuccessState());
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
   
    emit(AuthErrorState(  error: 'The password provided is too weak.'));
  } else if (e.code == 'email-already-in-use') {
    
    emit(AuthErrorState(  error: 'The account already exists for that email.'));
  }else {
    emit(AuthErrorState(  error: 'Something went wrong'));}
} catch (e) {
  print(e);
}


}



}


// lib/feature/auth/presintation/cubit/auth_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mechpro/feature/auth/presintation/cubit/auth_states.dart'; // تأكد من إضافة هذه المكتبة

// قم بتضمين ملف الحالات


class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  // تهيئة الـ Cubit بالحالة الأولية (وضع تسجيل الدخول افتراضيًا)
  AuthCubit(this._firebaseAuth) : super(const AuthInitial(isLoginMode: true));

  // دالة لتبديل وضع المصادقة (تسجيل الدخول / التسجيل)
  void toggleAuthMode() {
    // الحصول على الوضع الحالي من الحالة الحالية
    final currentMode = (state is AuthInitial)
        ? (state as AuthInitial).isLoginMode
        : true; // افتراضيًا login إذا كانت الحالة ليست AuthInitial
    emit(AuthInitial(isLoginMode: !currentMode)); // إرسال حالة جديدة بالوضع المعكوس
  }

  // دالة لتسجيل مستخدم جديد (Register)
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(isLoginMode: false)); // إرسال حالة التحميل لوضع التسجيل
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // تحديث اسم المستخدم بعد التسجيل (اختياري)
      await userCredential.user?.updateDisplayName(name);
      emit(AuthSuccess()); // إرسال حالة النجاح
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: false)); // إرسال حالة الخطأ
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}', isLoginMode: false));
    }
  }

  // دالة لتسجيل دخول مستخدم موجود (Sign In)
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(isLoginMode: true)); // إرسال حالة التحميل لوضع تسجيل الدخول
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess()); // إرسال حالة النجاح
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: true)); // إرسال حالة الخطأ
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}', isLoginMode: true));
    }
  }
}

*/
/*
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 👈 Make sure this is imported

import 'package:mechpro/feature/auth/presintation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(const AuthInitial(isLoginMode: true));

  void toggleAuthMode() {
    final currentMode =
        (state is AuthInitial) ? (state as AuthInitial).isLoginMode : true;
    emit(AuthInitial(isLoginMode: !currentMode));
  }

  // دالة لتسجيل مستخدم جديد (Register)
  Future<void> register({
    required String name,
    required String email, // 👈 Corrected: Changed 'String' to 'email' here
    required String password,
  }) async {
    emit(const AuthLoading(isLoginMode: false));
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, // 👈 Corrected: Using 'email' variable here
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);

      // استدعاء الدالة لحفظ رمز المصادقة بعد التسجيل بنجاح
      await _getAndSaveFirebaseIdToken();

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: false));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}',
          isLoginMode: false));
    }
  }

  // دالة لتسجيل دخول مستخدم موجود (Sign In)
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(isLoginMode: true));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // استدعاء الدالة لحفظ رمز المصادقة بعد تسجيل الدخول بنجاح
      await _getAndSaveFirebaseIdToken();

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: true));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}',
          isLoginMode: true));
    }
  }

  // هذه هي الدالة التي تحصل على الرمز وتحفظه
  Future<void> _getAndSaveFirebaseIdToken() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken();
      if (idToken != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('firebase_user_id_token', idToken);
        print('Firebase ID Token saved: $idToken');
      }
    }
  }
}
*/
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mechpro/feature/auth/presintation/cubit/auth_states.dart';

import '../../../../core/services/app_locale_storage.dart'; // تأكد من المسار الصحيح لهذا الملف

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(const AuthInitial(isLoginMode: true));

  void toggleAuthMode() {
    final currentMode = (state is AuthInitial)
        ? (state as AuthInitial).isLoginMode
        : true;
    emit(AuthInitial(isLoginMode: !currentMode));
  }

  // دالة لتسجيل مستخدم جديد (Register)
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading(isLoginMode: false));
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);

      // استدعاء الدالة لحفظ رمز المصادقة ومعرف المستخدم بعد التسجيل بنجاح
      await _getAndSaveFirebaseUserData();

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: false));
    } catch (e) {
      emit(
        AuthError(
          'An unexpected error occurred: ${e.toString()}',
          isLoginMode: false,
        ),
      );
    }
  }

  // دالة لتسجيل دخول مستخدم موجود (Sign In)
  Future<void> signIn({required String email, required String password}) async {
    emit(const AuthLoading(isLoginMode: true));
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // استدعاء الدالة لحفظ رمز المصادقة ومعرف المستخدم بعد تسجيل الدخول بنجاح
      await _getAndSaveFirebaseUserData();

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An unknown error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = e.message ?? errorMessage;
      }
      emit(AuthError(errorMessage, isLoginMode: true));
    } catch (e) {
      emit(
        AuthError(
          'An unexpected error occurred: ${e.toString()}',
          isLoginMode: true,
        ),
      );
    }
  }

  // هذه هي الدالة التي تحصل على الرمز ومعرف المستخدم وتحفظهما باستخدام AppLocaleStorage
  Future<void> _getAndSaveFirebaseUserData() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken();
      String uid = user.uid; // الحصول على الـ UID من Firebase

      // استخدام AppLocaleStorage لحفظ البيانات
      if (idToken != null) {
        AppLocaleStorage.chacheData('firebase_user_id_token', idToken);
        print('Firebase ID Token saved via AppLocaleStorage: $idToken');
      }

      AppLocaleStorage.chacheData(
        'firebase_user_uid',
        uid,
      ); // حفظ الـ UID في التخزين المحلي
      print('Firebase User UID saved via AppLocaleStorage: $uid');
    }
  }

  // دالة لتسجيل الخروج ومسح البيانات المخزنة
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // مسح البيانات باستخدام AppLocaleStorage
    await AppLocaleStorage.removeData(
      'firebase_user_id_token',
    ); // مسح الـ token عند تسجيل الخروج
    await AppLocaleStorage.removeData(
      'firebase_user_uid',
    ); // مسح الـ UID عند تسجيل الخروج

    print(
      'User signed out and local Firebase data cleared via AppLocaleStorage.',
    );
    emit(const AuthInitial(isLoginMode: true)); // العودة للحالة الأولية
  }
}
