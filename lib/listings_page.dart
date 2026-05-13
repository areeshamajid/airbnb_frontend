// lib/listings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/listings_cubit.dart';
import 'localization/app_localizations.dart';
import 'theme/app_spacing.dart';
import 'theme/app_theme.dart';

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
          appBar: AppBar(
            title: Text(l10n.appTitle),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Filter card ───────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.filterListings,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            Text(l10n.stateLabel),
                            const SizedBox(width: AppSpacing.sm),
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
                        const SizedBox(height: AppSpacing.sm),
                        Row(
                          children: [
                            Text(l10n.jurisdictionFilter),
                            Switch(
                              value: toggleOn,
                              onChanged: (v) => context
                                  .read<ListingsCubit>()
                                  .updateToggle(v),
                            ),
                            Text(
                              toggleOn ? l10n.toggleOn : l10n.toggleOff,
                              style: TextStyle(
                                color: toggleOn
                                    ? AppColors.primary
                                    : AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is ListingsLoading
                                ? null
                                : () => context
                                    .read<ListingsCubit>()
                                    .fetchListings(),
                            child: state is ListingsLoading
                                ? const SizedBox(
                                    height: AppSpacing.loadingIndicatorSize,
                                    width: AppSpacing.loadingIndicatorSize,
                                    child: CircularProgressIndicator(
                                        color: AppColors.textWhite,
                                        strokeWidth: 2),
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
                const SizedBox(height: AppSpacing.lg),

                // ── Error ─────────────────────────────────
                if (state is ListingsError)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textRed),
                      ),
                    ),
                  )

                // ── Empty state ───────────────────────────
                else if (state is ListingsInitial ||
                    state is ListingsFilterUpdated)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Text(
                        l10n.emptyState,
                        style: const TextStyle(color: AppColors.textGrey),
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
                      const SizedBox(height: AppSpacing.sm),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listings.length,
                        itemBuilder: (context, i) {
                          final listing = state.listings[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.listingPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.home,
                                          color: AppColors.primary,
                                          size: AppSpacing.iconLg),
                                      const SizedBox(width: AppSpacing.xs + 2),
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
                                  const SizedBox(height: AppSpacing.xs + 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: AppSpacing.iconSm,
                                          color: AppColors.iconGrey),
                                      const SizedBox(width: AppSpacing.xs - 1),
                                      Text(
                                        listing.neighbourhood ??
                                            listing.suburb ??
                                            '—',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textGrey),
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      const Icon(Icons.bed,
                                          size: AppSpacing.iconSm,
                                          color: AppColors.iconGrey),
                                      const SizedBox(width: AppSpacing.xs - 1),
                                      Text(
                                        listing.roomType ?? '—',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textGrey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.xs + 2),
                                  Row(
                                    children: [
                                      Text(
                                        l10n.pricePerNight(
                                            listing.price ?? '?'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.star,
                                          size: AppSpacing.iconMd,
                                          color: AppColors.iconAmber),
                                      Text(
                                        ' ${l10n.reviewCount(listing.numberOfReviews ?? 0)}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textGrey),
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