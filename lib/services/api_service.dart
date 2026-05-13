// lib/services/api_service.dart
//
// Responsible for raw HTTP communication only.
// No business logic — just makes the request and returns the response.
// If the API base URL changes, only this file needs updating.

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/listing_model.dart';

class ApiService {
  static const String _baseUrl = 'http://localhost:3000';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<ListingModel>> fetchListings({
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
      final rawList = data is List ? data : (data['listings'] ?? data['data'] ?? []);

      // Convert each map to a typed ListingModel
      return (rawList as List)
          .map((item) => ListingModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}