import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/bloc_observer/bloc_observer.dart';
import 'package:to_do_app/features/auth/presentation/ui_screens/login_screen.dart';
import 'package:to_do_app/features/home/controllers/add_to_do/cubit/add_to_do_cubit.dart';
import 'package:to_do_app/features/home/controllers/get_to_do_list/cubit/get_to_do_list_cubit.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/features/home/presentation/ui_screens/home_screen.dart';
import 'package:to_do_app/core/themes/theme_cubit.dart';
import 'package:to_do_app/core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AddToDoCubit()),
          BlocProvider(create: (_) => GetToDoListCubit()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen();
                }
                return LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

