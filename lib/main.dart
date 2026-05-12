import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const AirbnbApp());
}

class AirbnbApp extends StatelessWidget {
  const AirbnbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbnb Premium Listings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5A5F)),
        useMaterial3: true,
      ),
      home: const ListingsPage(),
    );
  }
}

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

  final Map<String, String> _stateLabels = {
    'vic': 'VIC – Melbourne',
    'nsw': 'NSW – Sydney',
    'qld': 'QLD – Brisbane',
    'sa':  'SA – Barossa Valley',
  };

  Future<void> _fetchListings() async {
    setState(() {
      _loading = true;
      _error = null;
      _listings = [];
    });

    final uri = Uri.parse(
      'http://localhost:3000/listings?stateToggle=${_toggleOn ? "on" : "off"}&allowedStates=$_selectedState',
    );

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listings = data is List ? data : (data['listings'] ?? data['data'] ?? []);
        });
      } else {
        setState(() => _error = 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _error = 'Could not connect to backend.\nMake sure your Node server is running on port 3000.');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5A5F),
        foregroundColor: Colors.white,
        title: const Text(
          'Airbnb Premium Listings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Filter Listings',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('State: '),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _selectedState,
                            isExpanded: true,
                            items: _stateLabels.entries
                                .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                                .toList(),
                            onChanged: (v) => setState(() => _selectedState = v!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Jurisdiction filter:'),
                        Switch(
                          value: _toggleOn,
                          activeColor: const Color(0xFFFF5A5F),
                          onChanged: (v) => setState(() => _toggleOn = v),
                        ),
                        Text(_toggleOn ? 'ON' : 'OFF',
                            style: TextStyle(
                                color: _toggleOn ? const Color(0xFFFF5A5F) : Colors.grey)),
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
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _loading ? null : _fetchListings,
                        child: _loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text('Fetch Premium Listings',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(_error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red)),
                ),
              )
            else if (_listings.isEmpty && !_loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text('Select a state and press Fetch',
                      style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top ${_listings.length} premium listings — ${_stateLabels[_selectedState]}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                  const Icon(Icons.home, color: Color(0xFFFF5A5F), size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      l['name'] ?? 'Listing ${i + 1}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 13, color: Colors.grey),
                                  const SizedBox(width: 3),
                                  Text(l['neighbourhood'] ?? l['suburb'] ?? '—',
                                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.bed, size: 13, color: Colors.grey),
                                  const SizedBox(width: 3),
                                  Text(l['room_type'] ?? '—',
                                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text('\$${l['price'] ?? '?'}/night',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF5A5F))),
                                  const Spacer(),
                                  const Icon(Icons.star, size: 14, color: Colors.amber),
                                  Text(' ${l['number_of_reviews'] ?? 0} reviews',
                                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
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