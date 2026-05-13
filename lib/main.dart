// lib/main.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

import 'localization/app_localizations.dart';

void main() {
  runApp(const AirbnbApp());
}

// ─────────────────────────────────────────────
// App root
// ─────────────────────────────────────────────
class AirbnbApp extends StatelessWidget {
  const AirbnbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (ctx) => AppLocalizations.of(ctx).appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5A5F)),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: const ListingsPage(),
    );
  }
}

// ─────────────────────────────────────────────
// Listings page
// ─────────────────────────────────────────────
class ListingsPage extends StatefulWidget {
  const ListingsPage({super.key});

  @override
  State<ListingsPage> createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  String _selectedState = 'vic';
  bool _toggleOn = true;
  List<dynamic> _listings = [];
  bool _loading = false;
  String? _error;

  Map<String, String> _stateLabels(AppLocalizations l10n) => {
        'vic': l10n.stateVic,
        'nsw': l10n.stateNsw,
        'qld': l10n.stateQld,
        'sa': l10n.stateSa,
      };

  Future<void> _fetchListings(AppLocalizations l10n) async {
    setState(() {
      _loading = true;
      _error = null;
      _listings = [];
    });

    final uri = Uri.parse(
      'http://localhost:3000/listings'
      '?stateToggle=${_toggleOn ? "on" : "off"}'
      '&allowedStates=$_selectedState',
    );

    try {
      final response =
          await http.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listings =
              data is List ? data : (data['listings'] ?? data['data'] ?? []);
        });
      } else {
        setState(() => _error = l10n.serverError(response.statusCode));
      }
    } catch (_) {
      setState(() => _error = l10n.connectionError);
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stateLabels = _stateLabels(l10n);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5A5F),
        foregroundColor: Colors.white,
        title: Text(
          l10n.appTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Filter card ───────────────────────────
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.filterListings,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(l10n.stateLabel),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _selectedState,
                            isExpanded: true,
                            items: stateLabels.entries
                                .map((e) => DropdownMenuItem(
                                    value: e.key, child: Text(e.value)))
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _selectedState = v!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(l10n.jurisdictionFilter),
                        Switch(
                          value: _toggleOn,
                          activeColor: const Color(0xFFFF5A5F),
                          onChanged: (v) => setState(() => _toggleOn = v),
                        ),
                        Text(
                          _toggleOn ? l10n.toggleOn : l10n.toggleOff,
                          style: TextStyle(
                            color: _toggleOn
                                ? const Color(0xFFFF5A5F)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5A5F),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed:
                            _loading ? null : () => _fetchListings(l10n),
                        child: _loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : Text(
                                l10n.fetchButton,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Error / empty / listings ──────────────
            if (_error != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (_listings.isEmpty && !_loading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    l10n.emptyState,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _toggleOn
                        ? l10n.premiumListingsTitle(
                            _listings.length,
                            stateLabels[_selectedState]!,
                          )
                        : l10n.allListingsTitle(
                            stateLabels[_selectedState]!,
                          ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _listings.length,
                    itemBuilder: (context, i) {
                      final l = _listings[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.home,
                                      color: Color(0xFFFF5A5F), size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      l['name'] ??
                                          l10n.listingFallbackName(i + 1),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 13, color: Colors.grey),
                                  const SizedBox(width: 3),
                                  Text(
                                    l['neighbourhood'] ?? l['suburb'] ?? '—',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.bed,
                                      size: 13, color: Colors.grey),
                                  const SizedBox(width: 3),
                                  Text(
                                    l['room_type'] ?? '—',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    l10n.pricePerNight(
                                        l['price']?.toString() ?? '?'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF5A5F),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.star,
                                      size: 14, color: Colors.amber),
                                  Text(
                                    ' ${l10n.reviewCount(int.tryParse(l['number_of_reviews']?.toString() ?? '0') ?? 0)}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}