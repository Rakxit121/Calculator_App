import 'package:caculator_app/view/app/route/app_route.dart';
import 'package:caculator_app/view/app/theme/theme_data.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      debugShowCheckedModeBanner: false, // Set this property to false
      initialRoute: AppRoute.calculatorRoute,
      routes: AppRoute.getApplicationRoute(),
// Use the custom splash screen as the initial route

      theme: getApplicationTheme(),
    );
  }
}
