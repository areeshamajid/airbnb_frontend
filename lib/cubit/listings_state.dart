// lib/cubit/listings_state.dart

part of 'listings_cubit.dart';

abstract class ListingsState {}

// Initial state
class ListingsInitial extends ListingsState {}

// Loading state 
class ListingsLoading extends ListingsState {}

// Success state 
class ListingsSuccess extends ListingsState {
  final List<dynamic> listings;
  final String selectedState;
  final bool toggleOn;

  ListingsSuccess({
    required this.listings,
    required this.selectedState,
    required this.toggleOn,
  });
}

// Error state 
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

// Filter changed state  
class ListingsFilterUpdated extends ListingsState {
  final String selectedState;
  final bool toggleOn;

  ListingsFilterUpdated({
    required this.selectedState,
    required this.toggleOn,
  });
}