
// Defines all possible states 

part of 'listings_cubit.dart';

/// Base class for all listings states.
/// All states extend this class.
abstract class ListingsState {}

/// Initial state when the app first loads.
/// No fetch has been triggered yet.
class ListingsInitial extends ListingsState {}

/// Emitted when a fetch is in progress.
/// The UI should show a loading indicator.
class ListingsLoading extends ListingsState {}

/// Emitted when listings are successfully fetched.
/// Contains the fetched listings and the current filter values.
class ListingsSuccess extends ListingsState {
  /// The list of listings returned from the API.
  final List<ListingModel> listings;

  /// The currently selected Australian state (e.g. 'vic', 'nsw').
  final String selectedState;

  /// Whether the jurisdiction filter toggle is on or off.
  final bool toggleOn;

  ListingsSuccess({
    required this.listings,
    required this.selectedState,
    required this.toggleOn,
  });
}

/// Emitted when a fetch fails due to a network or server error.
/// Contains the error message to display and the current filter values.
class ListingsError extends ListingsState {
  /// Human-readable error message to show in the UI.
  final String message;

  /// The currently selected Australian state (e.g. 'vic', 'nsw').
  final String selectedState;

  /// Whether the jurisdiction filter toggle is on or off.
  final bool toggleOn;

  ListingsError({
    required this.message,
    required this.selectedState,
    required this.toggleOn,
  });
}

/// Emitted when the user changes the state dropdown or jurisdiction toggle.
/// No fetch has been triggered yet — just filter values have changed.
class ListingsFilterUpdated extends ListingsState {
  /// The currently selected Australian state (e.g. 'vic', 'nsw').
  final String selectedState;
  
  /// Whether the jurisdiction filter toggle is on or off.
  final bool toggleOn;

  ListingsFilterUpdated({
    required this.selectedState,
    required this.toggleOn,
  });
}