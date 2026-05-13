// lib/repository/listings_repository.dart
//
// Abstract interface for the listings repository.
// Defines WHAT data operations are available without caring HOW they work.
// This makes it easy to:
//   - Swap implementations (e.g. mock for testing)
//   - Add caching or offline support later
//   - Document what the app can do with listings data

abstract class ListingsRepository {
  /// Fetches listings based on selected state and jurisdiction toggle.
  /// Returns a list of listing maps.
  /// Throws an [Exception] if the request fails.
  Future<List<dynamic>> getListings({
    required String selectedState,
    required bool toggleOn,
  });
}