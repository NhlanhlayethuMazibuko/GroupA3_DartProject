<<<<<<< HEAD
=======
//STUDENT NUMBERS:
//220013730 KL MOHLOLO
//224073145 T PHAGE
//222034858 N SHABALALA
//223000608 AL HADEBE
//221034407 NS MOLOI

>>>>>>> 9c3c10e (final)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'login_view.dart';
import '../student/student_home_view.dart';
import '../admin/admin_dashboard_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    if (!authViewModel.isLoggedIn) {
      return const LoginView();
    } else {
      if (authViewModel.role == "admin") {
        return const AdminDashboardView();
      } else {
        return const StudentHomeView();
      }
    }
  }
}
