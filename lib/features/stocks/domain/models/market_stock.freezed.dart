// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MarketStock {
  String get symbol => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get lastPrice => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;
  double get pChange => throw _privateConstructorUsedError;
  bool get isPositive => throw _privateConstructorUsedError;

  /// Create a copy of MarketStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketStockCopyWith<MarketStock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketStockCopyWith<$Res> {
  factory $MarketStockCopyWith(
          MarketStock value, $Res Function(MarketStock) then) =
      _$MarketStockCopyWithImpl<$Res, MarketStock>;
  @useResult
  $Res call(
      {String symbol,
      String name,
      double lastPrice,
      double change,
      double pChange,
      bool isPositive});
}

/// @nodoc
class _$MarketStockCopyWithImpl<$Res, $Val extends MarketStock>
    implements $MarketStockCopyWith<$Res> {
  _$MarketStockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? lastPrice = null,
    Object? change = null,
    Object? pChange = null,
    Object? isPositive = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastPrice: null == lastPrice
          ? _value.lastPrice
          : lastPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      pChange: null == pChange
          ? _value.pChange
          : pChange // ignore: cast_nullable_to_non_nullable
              as double,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketStockImplCopyWith<$Res>
    implements $MarketStockCopyWith<$Res> {
  factory _$$MarketStockImplCopyWith(
          _$MarketStockImpl value, $Res Function(_$MarketStockImpl) then) =
      __$$MarketStockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String name,
      double lastPrice,
      double change,
      double pChange,
      bool isPositive});
}

/// @nodoc
class __$$MarketStockImplCopyWithImpl<$Res>
    extends _$MarketStockCopyWithImpl<$Res, _$MarketStockImpl>
    implements _$$MarketStockImplCopyWith<$Res> {
  __$$MarketStockImplCopyWithImpl(
      _$MarketStockImpl _value, $Res Function(_$MarketStockImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketStock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? lastPrice = null,
    Object? change = null,
    Object? pChange = null,
    Object? isPositive = null,
  }) {
    return _then(_$MarketStockImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastPrice: null == lastPrice
          ? _value.lastPrice
          : lastPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      pChange: null == pChange
          ? _value.pChange
          : pChange // ignore: cast_nullable_to_non_nullable
              as double,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MarketStockImpl implements _MarketStock {
  const _$MarketStockImpl(
      {required this.symbol,
      required this.name,
      required this.lastPrice,
      required this.change,
      required this.pChange,
      this.isPositive = true});

  @override
  final String symbol;
  @override
  final String name;
  @override
  final double lastPrice;
  @override
  final double change;
  @override
  final double pChange;
  @override
  @JsonKey()
  final bool isPositive;

  @override
  String toString() {
    return 'MarketStock(symbol: $symbol, name: $name, lastPrice: $lastPrice, change: $change, pChange: $pChange, isPositive: $isPositive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketStockImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastPrice, lastPrice) ||
                other.lastPrice == lastPrice) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.pChange, pChange) || other.pChange == pChange) &&
            (identical(other.isPositive, isPositive) ||
                other.isPositive == isPositive));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, symbol, name, lastPrice, change, pChange, isPositive);

  /// Create a copy of MarketStock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketStockImplCopyWith<_$MarketStockImpl> get copyWith =>
      __$$MarketStockImplCopyWithImpl<_$MarketStockImpl>(this, _$identity);
}

abstract class _MarketStock implements MarketStock {
  const factory _MarketStock(
      {required final String symbol,
      required final String name,
      required final double lastPrice,
      required final double change,
      required final double pChange,
      final bool isPositive}) = _$MarketStockImpl;

  @override
  String get symbol;
  @override
  String get name;
  @override
  double get lastPrice;
  @override
  double get change;
  @override
  double get pChange;
  @override
  bool get isPositive;

  /// Create a copy of MarketStock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketStockImplCopyWith<_$MarketStockImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
