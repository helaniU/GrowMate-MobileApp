import 'package:flutter/material.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/plant_page.dart';
import 'pages/water_monitor_page.dart';
import 'pages/sunlight_monitor_page.dart';
import 'pages/nutrition_page.dart';

void main() {
  runApp(const PlantMonitorApp());
}

class PlantMonitorApp extends StatelessWidget {
  const PlantMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Monitor App',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const DashboardPage(userName: 'Helani'),
        // '/plant': (context) => const PlantPage(),
        // '/water': (context) => const WaterMonitorPage(),
        // '/sunlight': (context) => const SunlightMonitorPage(),
        // '/nutrition': (context) => NutritionMonitorPage(),
      },
    );
  }
}

