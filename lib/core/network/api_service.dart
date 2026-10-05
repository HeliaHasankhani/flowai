import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({
    required this.baseUrl,
  });

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/chat'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': message,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Request failed: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    return data['message'] as String;
  }
}