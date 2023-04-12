// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'View/Admin/Main/admin_main_page.dart';
import 'View/Shared/Authentication/login.dart';
import 'View/Shared/Onboarding/onboarding.dart';
import 'View/User/main/user_main_page.dart';
import 'core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'core/constant/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/local/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  var onBoarding = CacheHelper.getData(key: 'onBoarding');
  var token = CacheHelper.getData(key: 'token');
  var isHr = CacheHelper.getData(key: 'isHr');
  if (onBoarding == true) {
    if (token != null) {
      if (isHr == true) {
        widget = const AdminMainPage();
      } else {
        widget = const UserMainPage();
      }
    } else {
      widget = const LogIn();
    }
  } else {
    widget = const OnBoarding();
  }

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});

  final dynamic widget;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      // home: widget,
      home: widget,
      getPages: routes,
    );
  }
}

// dont forget to move it ?!?!?!
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  // @override
  // void onTransition(Bloc bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print('onTransition -- ${bloc.runtimeType}, $transition');
  // }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
