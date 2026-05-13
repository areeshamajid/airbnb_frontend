// Entry point of the application.
// This file should stay lean
// Adding a new feature should not require changes to this file.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cubit/listings_cubit.dart';
import 'listings_page.dart';
import 'localization/app_localizations.dart';
import 'theme/app_theme.dart';

/// The root entry point of the Flutter application.
void main() {
  runApp(const AirbnbApp());
}


class AirbnbApp extends StatelessWidget {
  const AirbnbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListingsCubit(),
      child: MaterialApp(
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
        debugShowCheckedModeBanner: false,
         // All colors, text styles, and component themes are defined in AppTheme.
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        // The first screen the user sees when the app launches.
        home: const ListingsPage(),
      ),
    );
  }
}