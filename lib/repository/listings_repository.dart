// lib/repository/listings_repository.dart
//
// Abstract interface for the listings repository.
// Defines WHAT data operations are available without caring HOW they work.
// This makes it easy to:
//   - Swap implementations (e.g. mock for testing)
//   - Add caching or offline support later
//   - Document what the app can do with listings data


import '../models/listing_model.dart';

abstract class ListingsRepository {
  Future<List<ListingModel>> getListings({
    required String selectedState,
    required bool toggleOn,
  });
}