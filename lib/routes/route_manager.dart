import 'package:flutter/material.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/student/student_home_view.dart';
import '../views/student/application_form_view.dart';
import '../views/student/application_detail_view.dart';
import '../views/student/application_edit_view.dart';
import '../models/application_model.dart';

class RouteManager {
//Routes
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String form = '/form';
  static const String detail = '/detail';
  static const String edit = '/edit';

  //Generate Routes dynamically
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case home:
        return MaterialPageRoute(builder: (_) => const StudentHomeView());

      case form:
        return MaterialPageRoute(builder: (_) => const ApplicationFormView());

      case detail:
        final application = settings.arguments as ApplicationModel;

        return MaterialPageRoute(
          builder: (_) => ApplicationDetailView(application: application),
        );

      case edit:
        final application = settings.arguments as ApplicationModel;

        return MaterialPageRoute(
          builder: (_) => ApplicationEditView(application: application),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
