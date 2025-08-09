import 'dart:convert';
import 'dart:io';
import 'package:app/models/ai_response.dart';
import 'package:app/models/startup.dart';
import 'package:app/models/vote_update_request.dart';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static String get baseUrl =>
      Platform.isAndroid ? 'http://10.0.2.2:8000' : 'http://127.0.0.1:8000';

  static Future<AIResponse?> insertStartup(Startup startup) async {
    final url = Uri.parse('$baseUrl/insert-startup');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(startup.toJson()),
    );
    if (response.statusCode == 200) {
      return AIResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<List<Startup>?> getStartups() async {
    var request = http.get(Uri.parse('$baseUrl/get-startups'));

    http.Response response = await request;
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Startup.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  static Future<void> updateVotes(VoteUpdateRequest request) async {
    final url = Uri.parse('$baseUrl/update-votes');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      print("Votes updated successfully: ${response.body}");
    } else {
      print(
        "Failed to update votes: ${response.statusCode} - ${response.body}",
      );
    }
  }
}
