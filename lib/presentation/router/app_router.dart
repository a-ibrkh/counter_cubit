import 'package:cubit_bloc_1_example/screens/second_screen.dart';
import 'package:cubit_bloc_1_example/screens/settings_screen.dart';
import 'package:cubit_bloc_1_example/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_bloc_1_example/screens/home_screen.dart';
import 'package:cubit_bloc_1_example/logic/cubit/counter_cubit.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MyHomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => MyHomeScreen(title: 'Home Screen'),
        );
      case SecondScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SecondScreen(),
        );
      case ThirdScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(),
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );

      // TODO: create NotFound Page with route name argument to display with 404 error message
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
