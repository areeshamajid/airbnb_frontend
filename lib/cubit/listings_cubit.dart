// lib/cubit/listings_cubit.dart

import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'listings_state.dart';

class ListingsCubit extends Cubit<ListingsState> {
  String selectedState = 'vic';
  bool toggleOn = true;

  ListingsCubit() : super(ListingsInitial());

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

    final uri = Uri.parse(
      'http://localhost:3000/listings'
      '?stateToggle=${toggleOn ? "on" : "off"}'
      '&allowedStates=$selectedState',
    );

    try {
      final response =
          await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final listings =
            data is List ? data : (data['listings'] ?? data['data'] ?? []);

        emit(ListingsSuccess(
          listings: listings,
          selectedState: selectedState,
          toggleOn: toggleOn,
        ));
      } else {
        emit(ListingsError(
          message: 'Server error: ${response.statusCode}',
          selectedState: selectedState,
          toggleOn: toggleOn,
        ));
      }
    } catch (_) {
      emit(ListingsError(
        message:
            'Could not connect to backend.\nMake sure your Node server is running on port 3000.',
        selectedState: selectedState,
        toggleOn: toggleOn,
      ));
    }
  }
}