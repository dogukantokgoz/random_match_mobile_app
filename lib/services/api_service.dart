import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';  // Android emulator için localhost
  // static const String baseUrl = 'http://10.0.2.2:8080/api';  // Android emulator için localhost
  // static const String baseUrl = 'http://0.0.0.0:8080/api';  // All interfaces
  // static const String baseUrl = 'http://192.168.1.62:8080/api';  // Local network IP
  late final SharedPreferences _prefs;

  ApiService() {
    SharedPreferences.getInstance().then((prefs) => _prefs = prefs);
  }

  String? get token => _prefs.getString('token');

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }

  Future<User> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: _headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        await _prefs.setString('token', data['token']);
        return user;
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String age,
    required String gender,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: _headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'age': age,
          'gender': gender,
        }),
      );

      print('Register Response: ${response.body}'); // Debug için

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        await _prefs.setString('token', data['token']);
        return user;
      } else {
        throw Exception(jsonDecode(response.body)['message'] ?? 'Registration failed');
      }
    } catch (e) {
      print('Register Error: $e'); // Debug için
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: _headers,
      );
      await _prefs.remove('token');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
} 