<<<<<<< HEAD

=======
//STUDENT NUMBERS:
//220013730 KL MOHLOLO
//224073145 T PHAGE
//222034858 N SHABALALA
//223000608 AL HADEBE
//221034407 NS MOLOI

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  String? _errorMessage;
  String? _role;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get role => _role;

  bool get isLoggedIn => _supabase.auth.currentSession != null;
  String? get currentUserEmail => _supabase.auth.currentUser?.email;
  String? get currentUserId => _supabase.auth.currentUser?.id;

  Future<void> fetchRole() async {
    try {
      final profile = await _supabase
          .from('profiles')
          .select('role')
          .eq('id', _supabase.auth.currentUser!.id)
          .single();

      _role = profile['role'];
      notifyListeners();
    } catch (e) {
      _role = null;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user != null) {
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'email': email.trim(),
          'username': username.trim(),
          'role': 'student',
        });
      }

      return response.user != null;
    } catch (e) {
      print(e);
      setError(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.user != null) {
        clearError();
        await fetchRole();
      }

      return response.user != null;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    _role = null;
    notifyListeners();
  }

  void setError(String message) {
    if (message.contains('Invalid login')) {
      _errorMessage = 'Incorrect email or password';
    } else if (message.contains('Email already')) {
      _errorMessage = 'Email already registered';
    }

    Future.delayed(const Duration(seconds: 3), () {
      _errorMessage = null;
      notifyListeners();
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
>>>>>>> 9c3c10e (final)
