import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shrtcode/resources/app_config.dart';
import 'package:shrtcode/resources/color_const.dart';

void main() {
  BaseUrl.setEnvironment(Environment.PROD);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor is used to set Status bar color in Android devices.
      statusBarColor: Colors.transparent,
      // To make Status bar icons color white in Android devices.
      statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness is used to set Status bar icon color in iOS.
      statusBarBrightness: Brightness.dark,
      // Here light means dark color Status bar icons.
    ));
    return MaterialApp(
      title: 'Shortly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),

      ),
      home: SplashScreen(),
    );
  }
}
