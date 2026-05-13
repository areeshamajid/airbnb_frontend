// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListingModelImpl _$$ListingModelImplFromJson(Map<String, dynamic> json) =>
    _$ListingModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      neighbourhood: json['neighbourhood'] as String?,
      suburb: json['suburb'] as String?,
      roomType: json['room_type'] as String?,
      price: json['price'] as String?,
      numberOfReviews: json['number_of_reviews'],
    );

Map<String, dynamic> _$$ListingModelImplToJson(_$ListingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'neighbourhood': instance.neighbourhood,
      'suburb': instance.suburb,
      'room_type': instance.roomType,
      'price': instance.price,
      'number_of_reviews': instance.numberOfReviews,
    };
