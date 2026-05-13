// lib/localization/app_localizations.dart

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// Abstract base
// ─────────────────────────────────────────────
abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // ── App ──────────────────────────────────
  String get appTitle;

  // ── Filter card ──────────────────────────
  String get filterListings;
  String get stateLabel;
  String get jurisdictionFilter;
  String get toggleOn;
  String get toggleOff;
  String get fetchButton;

  // ── Errors & empty state ─────────────────
  String serverError(int code);
  String get connectionError;
  String get emptyState;

  // ── Listings header ───────────────────────
  String premiumListingsTitle(int count, String state);
  String allListingsTitle(String state);

  // ── Listing card ─────────────────────────
  String listingFallbackName(int index);
  String pricePerNight(String price);
  String reviewCount(dynamic count);

  // ── State dropdown labels ─────────────────
  String get stateVic;
  String get stateNsw;
  String get stateQld;
  String get stateSa;
}

// ─────────────────────────────────────────────
// English implementation
// ─────────────────────────────────────────────
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
  @override String reviewCount(dynamic count) => '${int.tryParse(count.toString()) ?? 0} reviews';

  @override String get stateVic => 'VIC – Melbourne';
  @override String get stateNsw => 'NSW – Sydney';
  @override String get stateQld => 'QLD – Brisbane';
  @override String get stateSa  => 'SA – Barossa Valley';
}

// ─────────────────────────────────────────────
// Delegate
// ─────────────────────────────────────────────
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
      default:
        return AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}