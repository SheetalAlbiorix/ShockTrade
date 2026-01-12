// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChartPoint {
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double? get open => throw _privateConstructorUsedError;
  double? get high => throw _privateConstructorUsedError;
  double? get low => throw _privateConstructorUsedError;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartPointCopyWith<ChartPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartPointCopyWith<$Res> {
  factory $ChartPointCopyWith(
          ChartPoint value, $Res Function(ChartPoint) then) =
      _$ChartPointCopyWithImpl<$Res, ChartPoint>;
  @useResult
  $Res call(
      {DateTime timestamp,
      double price,
      double? open,
      double? high,
      double? low});
}

/// @nodoc
class _$ChartPointCopyWithImpl<$Res, $Val extends ChartPoint>
    implements $ChartPointCopyWith<$Res> {
  _$ChartPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? price = null,
    Object? open = freezed,
    Object? high = freezed,
    Object? low = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      open: freezed == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double?,
      low: freezed == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartPointImplCopyWith<$Res>
    implements $ChartPointCopyWith<$Res> {
  factory _$$ChartPointImplCopyWith(
          _$ChartPointImpl value, $Res Function(_$ChartPointImpl) then) =
      __$$ChartPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      double price,
      double? open,
      double? high,
      double? low});
}

/// @nodoc
class __$$ChartPointImplCopyWithImpl<$Res>
    extends _$ChartPointCopyWithImpl<$Res, _$ChartPointImpl>
    implements _$$ChartPointImplCopyWith<$Res> {
  __$$ChartPointImplCopyWithImpl(
      _$ChartPointImpl _value, $Res Function(_$ChartPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? price = null,
    Object? open = freezed,
    Object? high = freezed,
    Object? low = freezed,
  }) {
    return _then(_$ChartPointImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      open: freezed == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double?,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double?,
      low: freezed == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ChartPointImpl implements _ChartPoint {
  const _$ChartPointImpl(
      {required this.timestamp,
      required this.price,
      this.open,
      this.high,
      this.low});

  @override
  final DateTime timestamp;
  @override
  final double price;
  @override
  final double? open;
  @override
  final double? high;
  @override
  final double? low;

  @override
  String toString() {
    return 'ChartPoint(timestamp: $timestamp, price: $price, open: $open, high: $high, low: $low)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, timestamp, price, open, high, low);

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      __$$ChartPointImplCopyWithImpl<_$ChartPointImpl>(this, _$identity);
}

abstract class _ChartPoint implements ChartPoint {
  const factory _ChartPoint(
      {required final DateTime timestamp,
      required final double price,
      final double? open,
      final double? high,
      final double? low}) = _$ChartPointImpl;

  @override
  DateTime get timestamp;
  @override
  double get price;
  @override
  double? get open;
  @override
  double? get high;
  @override
  double? get low;

  /// Create a copy of ChartPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartPointImplCopyWith<_$ChartPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Fundamentals {
  String get marketCap => throw _privateConstructorUsedError;
  String get peRatio => throw _privateConstructorUsedError;
  String get eps => throw _privateConstructorUsedError;
  String get dividendYield => throw _privateConstructorUsedError;
  String get beta => throw _privateConstructorUsedError;
  String get revenue => throw _privateConstructorUsedError;

  /// Create a copy of Fundamentals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FundamentalsCopyWith<Fundamentals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FundamentalsCopyWith<$Res> {
  factory $FundamentalsCopyWith(
          Fundamentals value, $Res Function(Fundamentals) then) =
      _$FundamentalsCopyWithImpl<$Res, Fundamentals>;
  @useResult
  $Res call(
      {String marketCap,
      String peRatio,
      String eps,
      String dividendYield,
      String beta,
      String revenue});
}

/// @nodoc
class _$FundamentalsCopyWithImpl<$Res, $Val extends Fundamentals>
    implements $FundamentalsCopyWith<$Res> {
  _$FundamentalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fundamentals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketCap = null,
    Object? peRatio = null,
    Object? eps = null,
    Object? dividendYield = null,
    Object? beta = null,
    Object? revenue = null,
  }) {
    return _then(_value.copyWith(
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as String,
      peRatio: null == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as String,
      eps: null == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as String,
      dividendYield: null == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as String,
      beta: null == beta
          ? _value.beta
          : beta // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FundamentalsImplCopyWith<$Res>
    implements $FundamentalsCopyWith<$Res> {
  factory _$$FundamentalsImplCopyWith(
          _$FundamentalsImpl value, $Res Function(_$FundamentalsImpl) then) =
      __$$FundamentalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String marketCap,
      String peRatio,
      String eps,
      String dividendYield,
      String beta,
      String revenue});
}

/// @nodoc
class __$$FundamentalsImplCopyWithImpl<$Res>
    extends _$FundamentalsCopyWithImpl<$Res, _$FundamentalsImpl>
    implements _$$FundamentalsImplCopyWith<$Res> {
  __$$FundamentalsImplCopyWithImpl(
      _$FundamentalsImpl _value, $Res Function(_$FundamentalsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Fundamentals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketCap = null,
    Object? peRatio = null,
    Object? eps = null,
    Object? dividendYield = null,
    Object? beta = null,
    Object? revenue = null,
  }) {
    return _then(_$FundamentalsImpl(
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as String,
      peRatio: null == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as String,
      eps: null == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as String,
      dividendYield: null == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as String,
      beta: null == beta
          ? _value.beta
          : beta // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FundamentalsImpl implements _Fundamentals {
  const _$FundamentalsImpl(
      {required this.marketCap,
      required this.peRatio,
      required this.eps,
      required this.dividendYield,
      required this.beta,
      required this.revenue});

  @override
  final String marketCap;
  @override
  final String peRatio;
  @override
  final String eps;
  @override
  final String dividendYield;
  @override
  final String beta;
  @override
  final String revenue;

  @override
  String toString() {
    return 'Fundamentals(marketCap: $marketCap, peRatio: $peRatio, eps: $eps, dividendYield: $dividendYield, beta: $beta, revenue: $revenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FundamentalsImpl &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.peRatio, peRatio) || other.peRatio == peRatio) &&
            (identical(other.eps, eps) || other.eps == eps) &&
            (identical(other.dividendYield, dividendYield) ||
                other.dividendYield == dividendYield) &&
            (identical(other.beta, beta) || other.beta == beta) &&
            (identical(other.revenue, revenue) || other.revenue == revenue));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, marketCap, peRatio, eps, dividendYield, beta, revenue);

  /// Create a copy of Fundamentals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FundamentalsImplCopyWith<_$FundamentalsImpl> get copyWith =>
      __$$FundamentalsImplCopyWithImpl<_$FundamentalsImpl>(this, _$identity);
}

abstract class _Fundamentals implements Fundamentals {
  const factory _Fundamentals(
      {required final String marketCap,
      required final String peRatio,
      required final String eps,
      required final String dividendYield,
      required final String beta,
      required final String revenue}) = _$FundamentalsImpl;

  @override
  String get marketCap;
  @override
  String get peRatio;
  @override
  String get eps;
  @override
  String get dividendYield;
  @override
  String get beta;
  @override
  String get revenue;

  /// Create a copy of Fundamentals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FundamentalsImplCopyWith<_$FundamentalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TradingInfo {
  String get open => throw _privateConstructorUsedError;
  String get high => throw _privateConstructorUsedError;
  String get low => throw _privateConstructorUsedError;
  String get prevClose => throw _privateConstructorUsedError;
  String get week52High => throw _privateConstructorUsedError;
  String get week52Low => throw _privateConstructorUsedError;
  String get bid => throw _privateConstructorUsedError;
  String get ask =>
      throw _privateConstructorUsedError; // New fields for Markets Today
  String get lowerCircuit => throw _privateConstructorUsedError;
  String get upperCircuit => throw _privateConstructorUsedError;
  String get volume => throw _privateConstructorUsedError;
  String get avgPrice => throw _privateConstructorUsedError;
  String get lastTradedQty => throw _privateConstructorUsedError;
  String get lastTradedTime => throw _privateConstructorUsedError;

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradingInfoCopyWith<TradingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradingInfoCopyWith<$Res> {
  factory $TradingInfoCopyWith(
          TradingInfo value, $Res Function(TradingInfo) then) =
      _$TradingInfoCopyWithImpl<$Res, TradingInfo>;
  @useResult
  $Res call(
      {String open,
      String high,
      String low,
      String prevClose,
      String week52High,
      String week52Low,
      String bid,
      String ask,
      String lowerCircuit,
      String upperCircuit,
      String volume,
      String avgPrice,
      String lastTradedQty,
      String lastTradedTime});
}

/// @nodoc
class _$TradingInfoCopyWithImpl<$Res, $Val extends TradingInfo>
    implements $TradingInfoCopyWith<$Res> {
  _$TradingInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? prevClose = null,
    Object? week52High = null,
    Object? week52Low = null,
    Object? bid = null,
    Object? ask = null,
    Object? lowerCircuit = null,
    Object? upperCircuit = null,
    Object? volume = null,
    Object? avgPrice = null,
    Object? lastTradedQty = null,
    Object? lastTradedTime = null,
  }) {
    return _then(_value.copyWith(
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as String,
      prevClose: null == prevClose
          ? _value.prevClose
          : prevClose // ignore: cast_nullable_to_non_nullable
              as String,
      week52High: null == week52High
          ? _value.week52High
          : week52High // ignore: cast_nullable_to_non_nullable
              as String,
      week52Low: null == week52Low
          ? _value.week52Low
          : week52Low // ignore: cast_nullable_to_non_nullable
              as String,
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCircuit: null == lowerCircuit
          ? _value.lowerCircuit
          : lowerCircuit // ignore: cast_nullable_to_non_nullable
              as String,
      upperCircuit: null == upperCircuit
          ? _value.upperCircuit
          : upperCircuit // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      avgPrice: null == avgPrice
          ? _value.avgPrice
          : avgPrice // ignore: cast_nullable_to_non_nullable
              as String,
      lastTradedQty: null == lastTradedQty
          ? _value.lastTradedQty
          : lastTradedQty // ignore: cast_nullable_to_non_nullable
              as String,
      lastTradedTime: null == lastTradedTime
          ? _value.lastTradedTime
          : lastTradedTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradingInfoImplCopyWith<$Res>
    implements $TradingInfoCopyWith<$Res> {
  factory _$$TradingInfoImplCopyWith(
          _$TradingInfoImpl value, $Res Function(_$TradingInfoImpl) then) =
      __$$TradingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String open,
      String high,
      String low,
      String prevClose,
      String week52High,
      String week52Low,
      String bid,
      String ask,
      String lowerCircuit,
      String upperCircuit,
      String volume,
      String avgPrice,
      String lastTradedQty,
      String lastTradedTime});
}

/// @nodoc
class __$$TradingInfoImplCopyWithImpl<$Res>
    extends _$TradingInfoCopyWithImpl<$Res, _$TradingInfoImpl>
    implements _$$TradingInfoImplCopyWith<$Res> {
  __$$TradingInfoImplCopyWithImpl(
      _$TradingInfoImpl _value, $Res Function(_$TradingInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? prevClose = null,
    Object? week52High = null,
    Object? week52Low = null,
    Object? bid = null,
    Object? ask = null,
    Object? lowerCircuit = null,
    Object? upperCircuit = null,
    Object? volume = null,
    Object? avgPrice = null,
    Object? lastTradedQty = null,
    Object? lastTradedTime = null,
  }) {
    return _then(_$TradingInfoImpl(
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as String,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as String,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as String,
      prevClose: null == prevClose
          ? _value.prevClose
          : prevClose // ignore: cast_nullable_to_non_nullable
              as String,
      week52High: null == week52High
          ? _value.week52High
          : week52High // ignore: cast_nullable_to_non_nullable
              as String,
      week52Low: null == week52Low
          ? _value.week52Low
          : week52Low // ignore: cast_nullable_to_non_nullable
              as String,
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as String,
      lowerCircuit: null == lowerCircuit
          ? _value.lowerCircuit
          : lowerCircuit // ignore: cast_nullable_to_non_nullable
              as String,
      upperCircuit: null == upperCircuit
          ? _value.upperCircuit
          : upperCircuit // ignore: cast_nullable_to_non_nullable
              as String,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as String,
      avgPrice: null == avgPrice
          ? _value.avgPrice
          : avgPrice // ignore: cast_nullable_to_non_nullable
              as String,
      lastTradedQty: null == lastTradedQty
          ? _value.lastTradedQty
          : lastTradedQty // ignore: cast_nullable_to_non_nullable
              as String,
      lastTradedTime: null == lastTradedTime
          ? _value.lastTradedTime
          : lastTradedTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TradingInfoImpl implements _TradingInfo {
  const _$TradingInfoImpl(
      {required this.open,
      required this.high,
      required this.low,
      required this.prevClose,
      required this.week52High,
      required this.week52Low,
      required this.bid,
      required this.ask,
      required this.lowerCircuit,
      required this.upperCircuit,
      required this.volume,
      required this.avgPrice,
      required this.lastTradedQty,
      required this.lastTradedTime});

  @override
  final String open;
  @override
  final String high;
  @override
  final String low;
  @override
  final String prevClose;
  @override
  final String week52High;
  @override
  final String week52Low;
  @override
  final String bid;
  @override
  final String ask;
// New fields for Markets Today
  @override
  final String lowerCircuit;
  @override
  final String upperCircuit;
  @override
  final String volume;
  @override
  final String avgPrice;
  @override
  final String lastTradedQty;
  @override
  final String lastTradedTime;

  @override
  String toString() {
    return 'TradingInfo(open: $open, high: $high, low: $low, prevClose: $prevClose, week52High: $week52High, week52Low: $week52Low, bid: $bid, ask: $ask, lowerCircuit: $lowerCircuit, upperCircuit: $upperCircuit, volume: $volume, avgPrice: $avgPrice, lastTradedQty: $lastTradedQty, lastTradedTime: $lastTradedTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradingInfoImpl &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.prevClose, prevClose) ||
                other.prevClose == prevClose) &&
            (identical(other.week52High, week52High) ||
                other.week52High == week52High) &&
            (identical(other.week52Low, week52Low) ||
                other.week52Low == week52Low) &&
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.ask, ask) || other.ask == ask) &&
            (identical(other.lowerCircuit, lowerCircuit) ||
                other.lowerCircuit == lowerCircuit) &&
            (identical(other.upperCircuit, upperCircuit) ||
                other.upperCircuit == upperCircuit) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.avgPrice, avgPrice) ||
                other.avgPrice == avgPrice) &&
            (identical(other.lastTradedQty, lastTradedQty) ||
                other.lastTradedQty == lastTradedQty) &&
            (identical(other.lastTradedTime, lastTradedTime) ||
                other.lastTradedTime == lastTradedTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      open,
      high,
      low,
      prevClose,
      week52High,
      week52Low,
      bid,
      ask,
      lowerCircuit,
      upperCircuit,
      volume,
      avgPrice,
      lastTradedQty,
      lastTradedTime);

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradingInfoImplCopyWith<_$TradingInfoImpl> get copyWith =>
      __$$TradingInfoImplCopyWithImpl<_$TradingInfoImpl>(this, _$identity);
}

abstract class _TradingInfo implements TradingInfo {
  const factory _TradingInfo(
      {required final String open,
      required final String high,
      required final String low,
      required final String prevClose,
      required final String week52High,
      required final String week52Low,
      required final String bid,
      required final String ask,
      required final String lowerCircuit,
      required final String upperCircuit,
      required final String volume,
      required final String avgPrice,
      required final String lastTradedQty,
      required final String lastTradedTime}) = _$TradingInfoImpl;

  @override
  String get open;
  @override
  String get high;
  @override
  String get low;
  @override
  String get prevClose;
  @override
  String get week52High;
  @override
  String get week52Low;
  @override
  String get bid;
  @override
  String get ask; // New fields for Markets Today
  @override
  String get lowerCircuit;
  @override
  String get upperCircuit;
  @override
  String get volume;
  @override
  String get avgPrice;
  @override
  String get lastTradedQty;
  @override
  String get lastTradedTime;

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradingInfoImplCopyWith<_$TradingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StockNews {
  String get title => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get timeAgo => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Create a copy of StockNews
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockNewsCopyWith<StockNews> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockNewsCopyWith<$Res> {
  factory $StockNewsCopyWith(StockNews value, $Res Function(StockNews) then) =
      _$StockNewsCopyWithImpl<$Res, StockNews>;
  @useResult
  $Res call(
      {String title,
      String source,
      String timeAgo,
      String? imageUrl,
      String? url});
}

/// @nodoc
class _$StockNewsCopyWithImpl<$Res, $Val extends StockNews>
    implements $StockNewsCopyWith<$Res> {
  _$StockNewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockNews
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? source = null,
    Object? timeAgo = null,
    Object? imageUrl = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      timeAgo: null == timeAgo
          ? _value.timeAgo
          : timeAgo // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockNewsImplCopyWith<$Res>
    implements $StockNewsCopyWith<$Res> {
  factory _$$StockNewsImplCopyWith(
          _$StockNewsImpl value, $Res Function(_$StockNewsImpl) then) =
      __$$StockNewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String source,
      String timeAgo,
      String? imageUrl,
      String? url});
}

/// @nodoc
class __$$StockNewsImplCopyWithImpl<$Res>
    extends _$StockNewsCopyWithImpl<$Res, _$StockNewsImpl>
    implements _$$StockNewsImplCopyWith<$Res> {
  __$$StockNewsImplCopyWithImpl(
      _$StockNewsImpl _value, $Res Function(_$StockNewsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockNews
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? source = null,
    Object? timeAgo = null,
    Object? imageUrl = freezed,
    Object? url = freezed,
  }) {
    return _then(_$StockNewsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      timeAgo: null == timeAgo
          ? _value.timeAgo
          : timeAgo // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StockNewsImpl implements _StockNews {
  const _$StockNewsImpl(
      {required this.title,
      required this.source,
      required this.timeAgo,
      this.imageUrl,
      this.url});

  @override
  final String title;
  @override
  final String source;
  @override
  final String timeAgo;
  @override
  final String? imageUrl;
  @override
  final String? url;

  @override
  String toString() {
    return 'StockNews(title: $title, source: $source, timeAgo: $timeAgo, imageUrl: $imageUrl, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockNewsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.timeAgo, timeAgo) || other.timeAgo == timeAgo) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, source, timeAgo, imageUrl, url);

  /// Create a copy of StockNews
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockNewsImplCopyWith<_$StockNewsImpl> get copyWith =>
      __$$StockNewsImplCopyWithImpl<_$StockNewsImpl>(this, _$identity);
}

abstract class _StockNews implements StockNews {
  const factory _StockNews(
      {required final String title,
      required final String source,
      required final String timeAgo,
      final String? imageUrl,
      final String? url}) = _$StockNewsImpl;

  @override
  String get title;
  @override
  String get source;
  @override
  String get timeAgo;
  @override
  String? get imageUrl;
  @override
  String? get url;

  /// Create a copy of StockNews
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockNewsImplCopyWith<_$StockNewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StockDetailState {
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get priceChange => throw _privateConstructorUsedError;
  double get percentChange => throw _privateConstructorUsedError;
  bool get isPositive => throw _privateConstructorUsedError;
  StockRange get range => throw _privateConstructorUsedError;
  List<ChartPoint> get chartPoints => throw _privateConstructorUsedError;
  Fundamentals get fundamentals => throw _privateConstructorUsedError;
  TradingInfo get tradingInfo => throw _privateConstructorUsedError;
  List<StockNews> get news => throw _privateConstructorUsedError;
  bool get isInWatchlist => throw _privateConstructorUsedError;
  bool get hasAlert => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  RiskMeter? get riskMeter => throw _privateConstructorUsedError;

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockDetailStateCopyWith<StockDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockDetailStateCopyWith<$Res> {
  factory $StockDetailStateCopyWith(
          StockDetailState value, $Res Function(StockDetailState) then) =
      _$StockDetailStateCopyWithImpl<$Res, StockDetailState>;
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double price,
      double priceChange,
      double percentChange,
      bool isPositive,
      StockRange range,
      List<ChartPoint> chartPoints,
      Fundamentals fundamentals,
      TradingInfo tradingInfo,
      List<StockNews> news,
      bool isInWatchlist,
      bool hasAlert,
      String? errorMessage,
      bool isLoading,
      String? imageUrl,
      RiskMeter? riskMeter});

  $FundamentalsCopyWith<$Res> get fundamentals;
  $TradingInfoCopyWith<$Res> get tradingInfo;
  $RiskMeterCopyWith<$Res>? get riskMeter;
}

/// @nodoc
class _$StockDetailStateCopyWithImpl<$Res, $Val extends StockDetailState>
    implements $StockDetailStateCopyWith<$Res> {
  _$StockDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? price = null,
    Object? priceChange = null,
    Object? percentChange = null,
    Object? isPositive = null,
    Object? range = null,
    Object? chartPoints = null,
    Object? fundamentals = null,
    Object? tradingInfo = null,
    Object? news = null,
    Object? isInWatchlist = null,
    Object? hasAlert = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? imageUrl = freezed,
    Object? riskMeter = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as double,
      percentChange: null == percentChange
          ? _value.percentChange
          : percentChange // ignore: cast_nullable_to_non_nullable
              as double,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as StockRange,
      chartPoints: null == chartPoints
          ? _value.chartPoints
          : chartPoints // ignore: cast_nullable_to_non_nullable
              as List<ChartPoint>,
      fundamentals: null == fundamentals
          ? _value.fundamentals
          : fundamentals // ignore: cast_nullable_to_non_nullable
              as Fundamentals,
      tradingInfo: null == tradingInfo
          ? _value.tradingInfo
          : tradingInfo // ignore: cast_nullable_to_non_nullable
              as TradingInfo,
      news: null == news
          ? _value.news
          : news // ignore: cast_nullable_to_non_nullable
              as List<StockNews>,
      isInWatchlist: null == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAlert: null == hasAlert
          ? _value.hasAlert
          : hasAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      riskMeter: freezed == riskMeter
          ? _value.riskMeter
          : riskMeter // ignore: cast_nullable_to_non_nullable
              as RiskMeter?,
    ) as $Val);
  }

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FundamentalsCopyWith<$Res> get fundamentals {
    return $FundamentalsCopyWith<$Res>(_value.fundamentals, (value) {
      return _then(_value.copyWith(fundamentals: value) as $Val);
    });
  }

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TradingInfoCopyWith<$Res> get tradingInfo {
    return $TradingInfoCopyWith<$Res>(_value.tradingInfo, (value) {
      return _then(_value.copyWith(tradingInfo: value) as $Val);
    });
  }

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RiskMeterCopyWith<$Res>? get riskMeter {
    if (_value.riskMeter == null) {
      return null;
    }

    return $RiskMeterCopyWith<$Res>(_value.riskMeter!, (value) {
      return _then(_value.copyWith(riskMeter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StockDetailStateImplCopyWith<$Res>
    implements $StockDetailStateCopyWith<$Res> {
  factory _$$StockDetailStateImplCopyWith(_$StockDetailStateImpl value,
          $Res Function(_$StockDetailStateImpl) then) =
      __$$StockDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String companyName,
      double price,
      double priceChange,
      double percentChange,
      bool isPositive,
      StockRange range,
      List<ChartPoint> chartPoints,
      Fundamentals fundamentals,
      TradingInfo tradingInfo,
      List<StockNews> news,
      bool isInWatchlist,
      bool hasAlert,
      String? errorMessage,
      bool isLoading,
      String? imageUrl,
      RiskMeter? riskMeter});

  @override
  $FundamentalsCopyWith<$Res> get fundamentals;
  @override
  $TradingInfoCopyWith<$Res> get tradingInfo;
  @override
  $RiskMeterCopyWith<$Res>? get riskMeter;
}

/// @nodoc
class __$$StockDetailStateImplCopyWithImpl<$Res>
    extends _$StockDetailStateCopyWithImpl<$Res, _$StockDetailStateImpl>
    implements _$$StockDetailStateImplCopyWith<$Res> {
  __$$StockDetailStateImplCopyWithImpl(_$StockDetailStateImpl _value,
      $Res Function(_$StockDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? price = null,
    Object? priceChange = null,
    Object? percentChange = null,
    Object? isPositive = null,
    Object? range = null,
    Object? chartPoints = null,
    Object? fundamentals = null,
    Object? tradingInfo = null,
    Object? news = null,
    Object? isInWatchlist = null,
    Object? hasAlert = null,
    Object? errorMessage = freezed,
    Object? isLoading = null,
    Object? imageUrl = freezed,
    Object? riskMeter = freezed,
  }) {
    return _then(_$StockDetailStateImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as double,
      percentChange: null == percentChange
          ? _value.percentChange
          : percentChange // ignore: cast_nullable_to_non_nullable
              as double,
      isPositive: null == isPositive
          ? _value.isPositive
          : isPositive // ignore: cast_nullable_to_non_nullable
              as bool,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as StockRange,
      chartPoints: null == chartPoints
          ? _value._chartPoints
          : chartPoints // ignore: cast_nullable_to_non_nullable
              as List<ChartPoint>,
      fundamentals: null == fundamentals
          ? _value.fundamentals
          : fundamentals // ignore: cast_nullable_to_non_nullable
              as Fundamentals,
      tradingInfo: null == tradingInfo
          ? _value.tradingInfo
          : tradingInfo // ignore: cast_nullable_to_non_nullable
              as TradingInfo,
      news: null == news
          ? _value._news
          : news // ignore: cast_nullable_to_non_nullable
              as List<StockNews>,
      isInWatchlist: null == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAlert: null == hasAlert
          ? _value.hasAlert
          : hasAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      riskMeter: freezed == riskMeter
          ? _value.riskMeter
          : riskMeter // ignore: cast_nullable_to_non_nullable
              as RiskMeter?,
    ));
  }
}

/// @nodoc

class _$StockDetailStateImpl implements _StockDetailState {
  const _$StockDetailStateImpl(
      {required this.symbol,
      required this.companyName,
      required this.price,
      required this.priceChange,
      required this.percentChange,
      required this.isPositive,
      required this.range,
      required final List<ChartPoint> chartPoints,
      required this.fundamentals,
      required this.tradingInfo,
      required final List<StockNews> news,
      required this.isInWatchlist,
      required this.hasAlert,
      this.errorMessage,
      this.isLoading = false,
      this.imageUrl,
      this.riskMeter})
      : _chartPoints = chartPoints,
        _news = news;

  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final double price;
  @override
  final double priceChange;
  @override
  final double percentChange;
  @override
  final bool isPositive;
  @override
  final StockRange range;
  final List<ChartPoint> _chartPoints;
  @override
  List<ChartPoint> get chartPoints {
    if (_chartPoints is EqualUnmodifiableListView) return _chartPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chartPoints);
  }

  @override
  final Fundamentals fundamentals;
  @override
  final TradingInfo tradingInfo;
  final List<StockNews> _news;
  @override
  List<StockNews> get news {
    if (_news is EqualUnmodifiableListView) return _news;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_news);
  }

  @override
  final bool isInWatchlist;
  @override
  final bool hasAlert;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? imageUrl;
  @override
  final RiskMeter? riskMeter;

  @override
  String toString() {
    return 'StockDetailState(symbol: $symbol, companyName: $companyName, price: $price, priceChange: $priceChange, percentChange: $percentChange, isPositive: $isPositive, range: $range, chartPoints: $chartPoints, fundamentals: $fundamentals, tradingInfo: $tradingInfo, news: $news, isInWatchlist: $isInWatchlist, hasAlert: $hasAlert, errorMessage: $errorMessage, isLoading: $isLoading, imageUrl: $imageUrl, riskMeter: $riskMeter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockDetailStateImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceChange, priceChange) ||
                other.priceChange == priceChange) &&
            (identical(other.percentChange, percentChange) ||
                other.percentChange == percentChange) &&
            (identical(other.isPositive, isPositive) ||
                other.isPositive == isPositive) &&
            (identical(other.range, range) || other.range == range) &&
            const DeepCollectionEquality()
                .equals(other._chartPoints, _chartPoints) &&
            (identical(other.fundamentals, fundamentals) ||
                other.fundamentals == fundamentals) &&
            (identical(other.tradingInfo, tradingInfo) ||
                other.tradingInfo == tradingInfo) &&
            const DeepCollectionEquality().equals(other._news, _news) &&
            (identical(other.isInWatchlist, isInWatchlist) ||
                other.isInWatchlist == isInWatchlist) &&
            (identical(other.hasAlert, hasAlert) ||
                other.hasAlert == hasAlert) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.riskMeter, riskMeter) ||
                other.riskMeter == riskMeter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      symbol,
      companyName,
      price,
      priceChange,
      percentChange,
      isPositive,
      range,
      const DeepCollectionEquality().hash(_chartPoints),
      fundamentals,
      tradingInfo,
      const DeepCollectionEquality().hash(_news),
      isInWatchlist,
      hasAlert,
      errorMessage,
      isLoading,
      imageUrl,
      riskMeter);

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockDetailStateImplCopyWith<_$StockDetailStateImpl> get copyWith =>
      __$$StockDetailStateImplCopyWithImpl<_$StockDetailStateImpl>(
          this, _$identity);
}

abstract class _StockDetailState implements StockDetailState {
  const factory _StockDetailState(
      {required final String symbol,
      required final String companyName,
      required final double price,
      required final double priceChange,
      required final double percentChange,
      required final bool isPositive,
      required final StockRange range,
      required final List<ChartPoint> chartPoints,
      required final Fundamentals fundamentals,
      required final TradingInfo tradingInfo,
      required final List<StockNews> news,
      required final bool isInWatchlist,
      required final bool hasAlert,
      final String? errorMessage,
      final bool isLoading,
      final String? imageUrl,
      final RiskMeter? riskMeter}) = _$StockDetailStateImpl;

  @override
  String get symbol;
  @override
  String get companyName;
  @override
  double get price;
  @override
  double get priceChange;
  @override
  double get percentChange;
  @override
  bool get isPositive;
  @override
  StockRange get range;
  @override
  List<ChartPoint> get chartPoints;
  @override
  Fundamentals get fundamentals;
  @override
  TradingInfo get tradingInfo;
  @override
  List<StockNews> get news;
  @override
  bool get isInWatchlist;
  @override
  bool get hasAlert;
  @override
  String? get errorMessage;
  @override
  bool get isLoading;
  @override
  String? get imageUrl;
  @override
  RiskMeter? get riskMeter;

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockDetailStateImplCopyWith<_$StockDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RiskMeter {
  String get categoryName => throw _privateConstructorUsedError;
  double get stdDev => throw _privateConstructorUsedError;

  /// Create a copy of RiskMeter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskMeterCopyWith<RiskMeter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskMeterCopyWith<$Res> {
  factory $RiskMeterCopyWith(RiskMeter value, $Res Function(RiskMeter) then) =
      _$RiskMeterCopyWithImpl<$Res, RiskMeter>;
  @useResult
  $Res call({String categoryName, double stdDev});
}

/// @nodoc
class _$RiskMeterCopyWithImpl<$Res, $Val extends RiskMeter>
    implements $RiskMeterCopyWith<$Res> {
  _$RiskMeterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskMeter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? stdDev = null,
  }) {
    return _then(_value.copyWith(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      stdDev: null == stdDev
          ? _value.stdDev
          : stdDev // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskMeterImplCopyWith<$Res>
    implements $RiskMeterCopyWith<$Res> {
  factory _$$RiskMeterImplCopyWith(
          _$RiskMeterImpl value, $Res Function(_$RiskMeterImpl) then) =
      __$$RiskMeterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categoryName, double stdDev});
}

/// @nodoc
class __$$RiskMeterImplCopyWithImpl<$Res>
    extends _$RiskMeterCopyWithImpl<$Res, _$RiskMeterImpl>
    implements _$$RiskMeterImplCopyWith<$Res> {
  __$$RiskMeterImplCopyWithImpl(
      _$RiskMeterImpl _value, $Res Function(_$RiskMeterImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskMeter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? stdDev = null,
  }) {
    return _then(_$RiskMeterImpl(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      stdDev: null == stdDev
          ? _value.stdDev
          : stdDev // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$RiskMeterImpl implements _RiskMeter {
  const _$RiskMeterImpl({required this.categoryName, required this.stdDev});

  @override
  final String categoryName;
  @override
  final double stdDev;

  @override
  String toString() {
    return 'RiskMeter(categoryName: $categoryName, stdDev: $stdDev)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskMeterImpl &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.stdDev, stdDev) || other.stdDev == stdDev));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryName, stdDev);

  /// Create a copy of RiskMeter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskMeterImplCopyWith<_$RiskMeterImpl> get copyWith =>
      __$$RiskMeterImplCopyWithImpl<_$RiskMeterImpl>(this, _$identity);
}

abstract class _RiskMeter implements RiskMeter {
  const factory _RiskMeter(
      {required final String categoryName,
      required final double stdDev}) = _$RiskMeterImpl;

  @override
  String get categoryName;
  @override
  double get stdDev;

  /// Create a copy of RiskMeter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskMeterImplCopyWith<_$RiskMeterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
