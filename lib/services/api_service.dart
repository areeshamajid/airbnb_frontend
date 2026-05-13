// lib/services/api_service.dart
//
// Responsible for raw HTTP communication only.
// No business logic — just makes the request and returns the response.
// If the API base URL changes, only this file needs updating.

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL — change this once if backend moves
  static const String _baseUrl = 'http://localhost:3000';

  // Timeout duration — centralised so it's easy to adjust
  static const Duration _timeout = Duration(seconds: 10);

  /// Fetches listings from the backend.
  /// Returns the decoded response body as a [List<dynamic>].
  /// Throws an [Exception] on failure so the repository can handle it.
  Future<List<dynamic>> fetchListings({
    required String selectedState,
    required bool toggleOn,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/listings'
      '?stateToggle=${toggleOn ? "on" : "off"}'
      '&allowedStates=$selectedState',
    );

    final response = await http.get(uri).timeout(_timeout);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data is List ? data : (data['listings'] ?? data['data'] ?? []);
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}