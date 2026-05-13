// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) {
  return _ListingModel.fromJson(json);
}

/// @nodoc
mixin _$ListingModel {
// Listing identity
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError; // Location
  @JsonKey(name: 'neighbourhood')
  String? get neighbourhood => throw _privateConstructorUsedError;
  @JsonKey(name: 'suburb')
  String? get suburb => throw _privateConstructorUsedError; // Room details
  @JsonKey(name: 'room_type')
  String? get roomType =>
      throw _privateConstructorUsedError; // Pricing — comes as string from backend
  @JsonKey(name: 'price')
  String? get price =>
      throw _privateConstructorUsedError; // Reviews — comes as string from backend
  @JsonKey(name: 'number_of_reviews')
  dynamic get numberOfReviews => throw _privateConstructorUsedError;

  /// Serializes this ListingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingModelCopyWith<ListingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingModelCopyWith<$Res> {
  factory $ListingModelCopyWith(
          ListingModel value, $Res Function(ListingModel) then) =
      _$ListingModelCopyWithImpl<$Res, ListingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'neighbourhood') String? neighbourhood,
      @JsonKey(name: 'suburb') String? suburb,
      @JsonKey(name: 'room_type') String? roomType,
      @JsonKey(name: 'price') String? price,
      @JsonKey(name: 'number_of_reviews') dynamic numberOfReviews});
}

/// @nodoc
class _$ListingModelCopyWithImpl<$Res, $Val extends ListingModel>
    implements $ListingModelCopyWith<$Res> {
  _$ListingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? neighbourhood = freezed,
    Object? suburb = freezed,
    Object? roomType = freezed,
    Object? price = freezed,
    Object? numberOfReviews = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      neighbourhood: freezed == neighbourhood
          ? _value.neighbourhood
          : neighbourhood // ignore: cast_nullable_to_non_nullable
              as String?,
      suburb: freezed == suburb
          ? _value.suburb
          : suburb // ignore: cast_nullable_to_non_nullable
              as String?,
      roomType: freezed == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfReviews: freezed == numberOfReviews
          ? _value.numberOfReviews
          : numberOfReviews // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListingModelImplCopyWith<$Res>
    implements $ListingModelCopyWith<$Res> {
  factory _$$ListingModelImplCopyWith(
          _$ListingModelImpl value, $Res Function(_$ListingModelImpl) then) =
      __$$ListingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'neighbourhood') String? neighbourhood,
      @JsonKey(name: 'suburb') String? suburb,
      @JsonKey(name: 'room_type') String? roomType,
      @JsonKey(name: 'price') String? price,
      @JsonKey(name: 'number_of_reviews') dynamic numberOfReviews});
}

/// @nodoc
class __$$ListingModelImplCopyWithImpl<$Res>
    extends _$ListingModelCopyWithImpl<$Res, _$ListingModelImpl>
    implements _$$ListingModelImplCopyWith<$Res> {
  __$$ListingModelImplCopyWithImpl(
      _$ListingModelImpl _value, $Res Function(_$ListingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? neighbourhood = freezed,
    Object? suburb = freezed,
    Object? roomType = freezed,
    Object? price = freezed,
    Object? numberOfReviews = freezed,
  }) {
    return _then(_$ListingModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      neighbourhood: freezed == neighbourhood
          ? _value.neighbourhood
          : neighbourhood // ignore: cast_nullable_to_non_nullable
              as String?,
      suburb: freezed == suburb
          ? _value.suburb
          : suburb // ignore: cast_nullable_to_non_nullable
              as String?,
      roomType: freezed == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfReviews: freezed == numberOfReviews
          ? _value.numberOfReviews
          : numberOfReviews // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingModelImpl implements _ListingModel {
  const _$ListingModelImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'neighbourhood') this.neighbourhood,
      @JsonKey(name: 'suburb') this.suburb,
      @JsonKey(name: 'room_type') this.roomType,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'number_of_reviews') this.numberOfReviews});

  factory _$ListingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingModelImplFromJson(json);

// Listing identity
  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
// Location
  @override
  @JsonKey(name: 'neighbourhood')
  final String? neighbourhood;
  @override
  @JsonKey(name: 'suburb')
  final String? suburb;
// Room details
  @override
  @JsonKey(name: 'room_type')
  final String? roomType;
// Pricing — comes as string from backend
  @override
  @JsonKey(name: 'price')
  final String? price;
// Reviews — comes as string from backend
  @override
  @JsonKey(name: 'number_of_reviews')
  final dynamic numberOfReviews;

  @override
  String toString() {
    return 'ListingModel(id: $id, name: $name, neighbourhood: $neighbourhood, suburb: $suburb, roomType: $roomType, price: $price, numberOfReviews: $numberOfReviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.neighbourhood, neighbourhood) ||
                other.neighbourhood == neighbourhood) &&
            (identical(other.suburb, suburb) || other.suburb == suburb) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other.numberOfReviews, numberOfReviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, neighbourhood, suburb,
      roomType, price, const DeepCollectionEquality().hash(numberOfReviews));

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith =>
      __$$ListingModelImplCopyWithImpl<_$ListingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingModelImplToJson(
      this,
    );
  }
}

abstract class _ListingModel implements ListingModel {
  const factory _ListingModel(
          {@JsonKey(name: 'id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'neighbourhood') final String? neighbourhood,
          @JsonKey(name: 'suburb') final String? suburb,
          @JsonKey(name: 'room_type') final String? roomType,
          @JsonKey(name: 'price') final String? price,
          @JsonKey(name: 'number_of_reviews') final dynamic numberOfReviews}) =
      _$ListingModelImpl;

  factory _ListingModel.fromJson(Map<String, dynamic> json) =
      _$ListingModelImpl.fromJson;

// Listing identity
  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name; // Location
  @override
  @JsonKey(name: 'neighbourhood')
  String? get neighbourhood;
  @override
  @JsonKey(name: 'suburb')
  String? get suburb; // Room details
  @override
  @JsonKey(name: 'room_type')
  String? get roomType; // Pricing — comes as string from backend
  @override
  @JsonKey(name: 'price')
  String? get price; // Reviews — comes as string from backend
  @override
  @JsonKey(name: 'number_of_reviews')
  dynamic get numberOfReviews;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
