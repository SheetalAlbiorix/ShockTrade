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
  $Res call({DateTime timestamp, double price});
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
  $Res call({DateTime timestamp, double price});
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
    ));
  }
}

/// @nodoc

class _$ChartPointImpl implements _ChartPoint {
  const _$ChartPointImpl({required this.timestamp, required this.price});

  @override
  final DateTime timestamp;
  @override
  final double price;

  @override
  String toString() {
    return 'ChartPoint(timestamp: $timestamp, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartPointImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timestamp, price);

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
      required final double price}) = _$ChartPointImpl;

  @override
  DateTime get timestamp;
  @override
  double get price;

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
  String get bid => throw _privateConstructorUsedError;
  String get ask => throw _privateConstructorUsedError;

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
      String bid,
      String ask});
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
    Object? bid = null,
    Object? ask = null,
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
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
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
      String bid,
      String ask});
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
    Object? bid = null,
    Object? ask = null,
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
      bid: null == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String,
      ask: null == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
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
      required this.bid,
      required this.ask});

  @override
  final String open;
  @override
  final String high;
  @override
  final String low;
  @override
  final String prevClose;
  @override
  final String bid;
  @override
  final String ask;

  @override
  String toString() {
    return 'TradingInfo(open: $open, high: $high, low: $low, prevClose: $prevClose, bid: $bid, ask: $ask)';
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
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.ask, ask) || other.ask == ask));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, open, high, low, prevClose, bid, ask);

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
      required final String bid,
      required final String ask}) = _$TradingInfoImpl;

  @override
  String get open;
  @override
  String get high;
  @override
  String get low;
  @override
  String get prevClose;
  @override
  String get bid;
  @override
  String get ask;

  /// Create a copy of TradingInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradingInfoImplCopyWith<_$TradingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StockDetailState {
  String get symbol => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get priceChange => throw _privateConstructorUsedError;
  double get percentChange => throw _privateConstructorUsedError;
  StockRange get range => throw _privateConstructorUsedError;
  List<ChartPoint> get chartPoints => throw _privateConstructorUsedError;
  Fundamentals get fundamentals => throw _privateConstructorUsedError;
  TradingInfo get tradingInfo => throw _privateConstructorUsedError;
  bool get isInWatchlist => throw _privateConstructorUsedError;
  bool get hasAlert => throw _privateConstructorUsedError;

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
      double price,
      double priceChange,
      double percentChange,
      StockRange range,
      List<ChartPoint> chartPoints,
      Fundamentals fundamentals,
      TradingInfo tradingInfo,
      bool isInWatchlist,
      bool hasAlert});

  $FundamentalsCopyWith<$Res> get fundamentals;
  $TradingInfoCopyWith<$Res> get tradingInfo;
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
    Object? price = null,
    Object? priceChange = null,
    Object? percentChange = null,
    Object? range = null,
    Object? chartPoints = null,
    Object? fundamentals = null,
    Object? tradingInfo = null,
    Object? isInWatchlist = null,
    Object? hasAlert = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
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
      isInWatchlist: null == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAlert: null == hasAlert
          ? _value.hasAlert
          : hasAlert // ignore: cast_nullable_to_non_nullable
              as bool,
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
      double price,
      double priceChange,
      double percentChange,
      StockRange range,
      List<ChartPoint> chartPoints,
      Fundamentals fundamentals,
      TradingInfo tradingInfo,
      bool isInWatchlist,
      bool hasAlert});

  @override
  $FundamentalsCopyWith<$Res> get fundamentals;
  @override
  $TradingInfoCopyWith<$Res> get tradingInfo;
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
    Object? price = null,
    Object? priceChange = null,
    Object? percentChange = null,
    Object? range = null,
    Object? chartPoints = null,
    Object? fundamentals = null,
    Object? tradingInfo = null,
    Object? isInWatchlist = null,
    Object? hasAlert = null,
  }) {
    return _then(_$StockDetailStateImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
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
      isInWatchlist: null == isInWatchlist
          ? _value.isInWatchlist
          : isInWatchlist // ignore: cast_nullable_to_non_nullable
              as bool,
      hasAlert: null == hasAlert
          ? _value.hasAlert
          : hasAlert // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$StockDetailStateImpl implements _StockDetailState {
  const _$StockDetailStateImpl(
      {required this.symbol,
      required this.price,
      required this.priceChange,
      required this.percentChange,
      required this.range,
      required final List<ChartPoint> chartPoints,
      required this.fundamentals,
      required this.tradingInfo,
      required this.isInWatchlist,
      required this.hasAlert})
      : _chartPoints = chartPoints;

  @override
  final String symbol;
  @override
  final double price;
  @override
  final double priceChange;
  @override
  final double percentChange;
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
  @override
  final bool isInWatchlist;
  @override
  final bool hasAlert;

  @override
  String toString() {
    return 'StockDetailState(symbol: $symbol, price: $price, priceChange: $priceChange, percentChange: $percentChange, range: $range, chartPoints: $chartPoints, fundamentals: $fundamentals, tradingInfo: $tradingInfo, isInWatchlist: $isInWatchlist, hasAlert: $hasAlert)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockDetailStateImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceChange, priceChange) ||
                other.priceChange == priceChange) &&
            (identical(other.percentChange, percentChange) ||
                other.percentChange == percentChange) &&
            (identical(other.range, range) || other.range == range) &&
            const DeepCollectionEquality()
                .equals(other._chartPoints, _chartPoints) &&
            (identical(other.fundamentals, fundamentals) ||
                other.fundamentals == fundamentals) &&
            (identical(other.tradingInfo, tradingInfo) ||
                other.tradingInfo == tradingInfo) &&
            (identical(other.isInWatchlist, isInWatchlist) ||
                other.isInWatchlist == isInWatchlist) &&
            (identical(other.hasAlert, hasAlert) ||
                other.hasAlert == hasAlert));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      symbol,
      price,
      priceChange,
      percentChange,
      range,
      const DeepCollectionEquality().hash(_chartPoints),
      fundamentals,
      tradingInfo,
      isInWatchlist,
      hasAlert);

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
      required final double price,
      required final double priceChange,
      required final double percentChange,
      required final StockRange range,
      required final List<ChartPoint> chartPoints,
      required final Fundamentals fundamentals,
      required final TradingInfo tradingInfo,
      required final bool isInWatchlist,
      required final bool hasAlert}) = _$StockDetailStateImpl;

  @override
  String get symbol;
  @override
  double get price;
  @override
  double get priceChange;
  @override
  double get percentChange;
  @override
  StockRange get range;
  @override
  List<ChartPoint> get chartPoints;
  @override
  Fundamentals get fundamentals;
  @override
  TradingInfo get tradingInfo;
  @override
  bool get isInWatchlist;
  @override
  bool get hasAlert;

  /// Create a copy of StockDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockDetailStateImplCopyWith<_$StockDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
