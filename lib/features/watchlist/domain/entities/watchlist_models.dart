/// Stock model representing a single stock in the watchlist
class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final bool isPositive;

  const Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.isPositive,
  });

  /// Creates a Stock with calculated isPositive based on change
  factory Stock.create({
    required String symbol,
    required String name,
    required double price,
    required double change,
    required double changePercent,
  }) {
    return Stock(
      symbol: symbol,
      name: name,
      price: price,
      change: change,
      changePercent: changePercent,
      isPositive: change >= 0,
    );
  }
}

/// Watchlist group containing multiple stocks
class WatchlistGroup {
  final String id;
  final String name;
  final List<Stock> stocks;
  final bool isExpanded;

  const WatchlistGroup({
    required this.id,
    required this.name,
    required this.stocks,
    this.isExpanded = true,
  });

  /// Returns the count of stocks in this group
  int get stockCount => stocks.length;

  /// Creates a copy with updated expanded state
  WatchlistGroup copyWith({bool? isExpanded}) {
    return WatchlistGroup(
      id: id,
      name: name,
      stocks: stocks,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
