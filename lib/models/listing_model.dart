
// Freezed model for a single listing.
// - All fields are typed and documented
// - jsonKey maps to the exact backend field names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

@freezed
class ListingModel with _$ListingModel {
  const factory ListingModel({
    // Listing identity
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,

    // Location
    @JsonKey(name: 'neighbourhood') String? neighbourhood,
    @JsonKey(name: 'suburb') String? suburb,

    // Room details
    @JsonKey(name: 'room_type') String? roomType,

    // Pricing — comes as string from backend
    @JsonKey(name: 'price') String? price,

    // Reviews — comes as string from backend
    @JsonKey(name: 'number_of_reviews') dynamic numberOfReviews,
  }) = _ListingModel;

  /// Creates a [ListingModel] from a JSON map
  factory ListingModel.fromJson(Map<String, dynamic> json) =>
      _$ListingModelFromJson(json);
}