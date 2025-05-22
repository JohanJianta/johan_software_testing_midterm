part of 'models.dart';

class AuthService {
  static const String baseURL = "https://dummyjson.com/auth/login";
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(baseURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Invalid username or password.');
    }
  }

  Future<void> logout() async {
    // Normally invalidate token or session
  }
}
