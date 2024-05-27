import 'package:flutter/material.dart';
import 'package:integrador/ApiServices/form_provider.dart';
import 'package:integrador/Providers/plant_provider.dart';
import 'package:integrador/ui/onBoarding_screen.dart';
import 'package:provider/provider.dart';
import './ui/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FormProvider()..fetchForms('hamletcruzpirazan@gmail.com')),
        ChangeNotifierProvider(create: (context) => PlantProvider()),

      ],

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
      ),
    );
  }
}
