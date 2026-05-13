
// Cubit only talks to the repository 

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/listing_model.dart';
import '../repository/listings_repository.dart';
import '../repository/listings_repository_impl.dart';

part 'listings_state.dart';

class ListingsCubit extends Cubit<ListingsState> {
  final ListingsRepository _repository;

  String selectedState = 'vic';
  bool toggleOn = true;

  // Repository is injected; defaults to real implementation
  ListingsCubit({ListingsRepository? repository})
      : _repository = repository ?? ListingsRepositoryImpl(),
        super(ListingsInitial());

  void updateState(String newState) {
    selectedState = newState;
    emit(ListingsFilterUpdated(
      selectedState: selectedState,
      toggleOn: toggleOn,
    ));
  }

  void updateToggle(bool newToggle) {
    toggleOn = newToggle;
    emit(ListingsFilterUpdated(
      selectedState: selectedState,
      toggleOn: toggleOn,
    ));
  }

  Future<void> fetchListings() async {
    emit(ListingsLoading());

    try {
      final listings = await _repository.getListings(
        selectedState: selectedState,
        toggleOn: toggleOn,
      );

      emit(ListingsSuccess(
        listings: listings,
        selectedState: selectedState,
        toggleOn: toggleOn,
      ));
    } catch (e) {
      emit(ListingsError(
        message: e.toString().contains('Server error')
            ? e.toString().replaceAll('Exception: ', '')
            : 'Could not connect to backend.\nMake sure your Node server is running on port 3000.',
        selectedState: selectedState,
        toggleOn: toggleOn,
      ));
    }
  }
}