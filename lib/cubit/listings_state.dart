// lib/cubit/listings_state.dart

part of 'listings_cubit.dart';

abstract class ListingsState {}

class ListingsInitial extends ListingsState {}

class ListingsLoading extends ListingsState {}

class ListingsSuccess extends ListingsState {
  final List<ListingModel> listings;
  final String selectedState;
  final bool toggleOn;

  ListingsSuccess({
    required this.listings,
    required this.selectedState,
    required this.toggleOn,
  });
}

class ListingsError extends ListingsState {
  final String message;
  final String selectedState;
  final bool toggleOn;

  ListingsError({
    required this.message,
    required this.selectedState,
    required this.toggleOn,
  });
}

class ListingsFilterUpdated extends ListingsState {
  final String selectedState;
  final bool toggleOn;

  ListingsFilterUpdated({
    required this.selectedState,
    required this.toggleOn,
  });
}