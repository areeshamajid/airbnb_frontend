// lib/localization/app_localizations.dart
//
// Provides localized strings for the entire app.

import 'package:flutter/material.dart';


// Abstract base
// Defines all string keys the app can use.

abstract class AppLocalizations {
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// The delegate that tells Flutter how to load the correct
  /// [AppLocalizations] implementation based on the device locale.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // ── App 

  /// The main title of the app shown in the AppBar.
  String get appTitle;

  // ── Filter card 

  /// Heading label for the filter card.
  String get filterListings;

  /// Label shown before the state dropdown.
  String get stateLabel;

  /// Label shown before the jurisdiction toggle switch.
  String get jurisdictionFilter;

  /// Label shown when the toggle is on.
  String get toggleOn;

  /// Label shown when the toggle is off.
  String get toggleOff;

  /// Label for the main fetch button.
  String get fetchButton;

  // ── Errors & empty state 

  /// Error message shown when the server returns a non-200 status code.
  /// [code] is the HTTP status code returned by the server.
  String serverError(int code);

  /// Error message shown when the app cannot reach the backend.
  String get connectionError;

  /// Placeholder message shown before the user triggers a fetch.
  String get emptyState;

  // ── Listings header

  /// Heading shown above the listings list when jurisdiction filter is ON.
  /// [count] is the number of listings returned.
  /// [state] is the human-readable state label (e.g. 'VIC – Melbourne').
  String premiumListingsTitle(int count, String state);

  /// Heading shown above the listings list when jurisdiction filter is OFF.
  /// [state] is the human-readable state label (e.g. 'VIC – Melbourne').
  String allListingsTitle(String state);

  // ── Listing card

  /// Fallback name shown on a listing card when the API returns no name.
  /// [index] is the 1-based position of the listing in the list.
  String listingFallbackName(int index);

  /// Price label shown on a listing card.
  /// [price] is the price string returned from the API (e.g. '120').
  String pricePerNight(String price);

  /// Review count label shown on a listing card.
  /// [count] accepts dynamic because the API may return a String or int.
  String reviewCount(dynamic count);

  // ── State dropdown labels

  /// Display label for Victoria.
  String get stateVic;

  /// Display label for New South Wales.
  String get stateNsw;

  /// Display label for Queensland.
  String get stateQld;

  /// Display label for South Australia.
  String get stateSa;
}


// Contains all strings for the app.

class AppLocalizationsEn extends AppLocalizations {
  @override String get appTitle           => 'Airbnb Premium Listings';

  @override String get filterListings     => 'Filter Listings';
  @override String get stateLabel         => 'State:';
  @override String get jurisdictionFilter => 'Jurisdiction filter:';
  @override String get toggleOn           => 'ON';
  @override String get toggleOff          => 'OFF';
  @override String get fetchButton        => 'Fetch Premium Listings';

  @override String serverError(int code)  => 'Server error: $code';
  @override String get connectionError    =>
      'Could not connect to backend.\n'
      'Make sure your Node server is running on port 3000.';
  @override String get emptyState         => 'Select a state and press Fetch';

  @override String premiumListingsTitle(int count, String state) =>
      'Top $count premium listings — $state';
  @override String allListingsTitle(String state) =>
      'Airbnb Listings - $state';

  @override String listingFallbackName(int index) => 'Listing $index';
  @override String pricePerNight(String price)    => '\$$price/night';
  @override String reviewCount(dynamic count) =>
      '${int.tryParse(count.toString()) ?? 0} reviews';

  @override String get stateVic => 'VIC – Melbourne';
  @override String get stateNsw => 'NSW – Sydney';
  @override String get stateQld => 'QLD – Brisbane';
  @override String get stateSa  => 'SA – Barossa Valley';
}


// Delegate
// Tells Flutter which AppLocalizations implementation to load
// based on the device locale.

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  /// Returns true if the given [locale] is supported by this app.
  /// Add new language codes here as new implementations are added.
  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  /// Loads the correct [AppLocalizations] implementation for the given [locale].
  /// Add new cases here as new language implementations are added.
  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
      default:
        return AppLocalizationsEn();
    }
  }

  /// Return false; strings don't change during the app lifecycle.
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}