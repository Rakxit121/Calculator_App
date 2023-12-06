import 'package:caculator_app/view/calculator.dart';

class AppRoute {
  AppRoute._();

  static const String calculatorRoute = "/";

  static getApplicationRoute() {
    return {
      calculatorRoute: (context) => const Calculator(),
    };
  }
}
