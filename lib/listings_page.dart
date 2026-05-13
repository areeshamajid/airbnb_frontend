import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/listings_cubit.dart';
import 'localization/app_localizations.dart';

class ListingsPage extends StatelessWidget {
  const ListingsPage({super.key});

  Map<String, String> _stateLabels(AppLocalizations l10n) => {
        'vic': l10n.stateVic,
        'nsw': l10n.stateNsw,
        'qld': l10n.stateQld,
        'sa': l10n.stateSa,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final stateLabels = _stateLabels(l10n);

    return BlocBuilder<ListingsCubit, ListingsState>(
      builder: (context, state) {
        final selectedState = switch (state) {
          ListingsSuccess s       => s.selectedState,
          ListingsError e         => e.selectedState,
          ListingsFilterUpdated f => f.selectedState,
          _ => context.read<ListingsCubit>().selectedState,
        };

        final toggleOn = switch (state) {
          ListingsSuccess s       => s.toggleOn,
          ListingsError e         => e.toggleOn,
          ListingsFilterUpdated f => f.toggleOn,
          _ => context.read<ListingsCubit>().toggleOn,
        };

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
                                value: selectedState,
                                isExpanded: true,
                                items: stateLabels.entries
                                    .map((e) => DropdownMenuItem(
                                        value: e.key, child: Text(e.value)))
                                    .toList(),
                                onChanged: (v) => context
                                    .read<ListingsCubit>()
                                    .updateState(v!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(l10n.jurisdictionFilter),
                            Switch(
                              value: toggleOn,
                              activeColor: const Color(0xFFFF5A5F),
                              onChanged: (v) => context
                                  .read<ListingsCubit>()
                                  .updateToggle(v),
                            ),
                            Text(
                              toggleOn ? l10n.toggleOn : l10n.toggleOff,
                              style: TextStyle(
                                color: toggleOn
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
                            onPressed: state is ListingsLoading
                                ? null
                                : () => context
                                    .read<ListingsCubit>()
                                    .fetchListings(),
                            child: state is ListingsLoading
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

                // ── Error ─────────────────────────────────
                if (state is ListingsError)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )

                // ── Empty state ───────────────────────────
                else if (state is ListingsInitial ||
                    state is ListingsFilterUpdated)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Text(
                        l10n.emptyState,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  )

                // ── Listings ──────────────────────────────
                else if (state is ListingsSuccess)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toggleOn
                            ? l10n.premiumListingsTitle(
                                state.listings.length,
                                stateLabels[selectedState]!,
                              )
                            : l10n.allListingsTitle(
                                stateLabels[selectedState]!,
                              ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listings.length,
                        itemBuilder: (context, i) {
                          final listing = state.listings[i];
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
                                          listing.name ??
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
                                        listing.neighbourhood ??
                                            listing.suburb ??
                                            '—',
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(Icons.bed,
                                          size: 13, color: Colors.grey),
                                      const SizedBox(width: 3),
                                      Text(
                                        listing.roomType ?? '—',
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
                                            listing.price ?? '?'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF5A5F),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.star,
                                          size: 14, color: Colors.amber),
                                      Text(
                                        ' ${l10n.reviewCount(listing.numberOfReviews ?? 0)}',
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
      },
    );
  }
}