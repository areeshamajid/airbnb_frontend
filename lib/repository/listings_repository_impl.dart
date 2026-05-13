
// Concrete implementation of [ListingsRepository].
// Uses [ApiService] to fetch data from the backend.
// If we add caching, local storage, or a different data source

import '../models/listing_model.dart';
import '../services/api_service.dart';
import 'listings_repository.dart';

class ListingsRepositoryImpl implements ListingsRepository {
  final ApiService _apiService;

  ListingsRepositoryImpl({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  @override
  Future<List<ListingModel>> getListings({
    required String selectedState,
    required bool toggleOn,
  }) async {
    return _apiService.fetchListings(
      selectedState: selectedState,
      toggleOn: toggleOn,
    );
  }
}