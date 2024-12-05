// ignore_for_file: library_prefixes
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_quiz/ui/screens/splash_screen.dart';
import 'package:t_quiz/utils/colors.dart';
import 'env/env_example.dart' as AppEnv;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false, primaryColor: primary, dividerColor: Colors.transparent),
        initialRoute: SplashScreen.routename,
        routes: {
          SplashScreen.routename: (BuildContext context) => const SplashScreen(),
        },
      ),
    );
  }
}

class Config {
  static const String baseUrl = kDebugMode ? AppEnv.BASE_URL_API : AppEnv.BASE_URL_API;
  static const String adsKey = kDebugMode ? AppEnv.TQUIZ_KEY : AppEnv.TQUIZ_KEY;
}
