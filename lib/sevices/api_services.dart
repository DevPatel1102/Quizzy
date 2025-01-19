import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/Quiz.dart';

class ApiService {
  final String baseUrl = 'https://api.jsonserve.com/Uw5CrX';

  Future<Quiz> fetchQuizData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Print the raw JSON response to check the structure
      print('Raw response: ${response.body}');

      // Parse the JSON data
      Map<String, dynamic> jsonData = json.decode(response.body);

      // Print the parsed JSON to check the types of the fields
      print('Parsed response: $jsonData');

      return Quiz.fromJson(jsonData);
    } else {
      throw Exception('Failed to load quiz data');
    }
  }
}
