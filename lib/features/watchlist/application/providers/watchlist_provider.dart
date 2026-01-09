import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';

/// Provider for watchlist data with mock data for now
final watchlistProvider = StateNotifierProvider<WatchlistNotifier, List<WatchlistGroup>>((ref) {
  return WatchlistNotifier();
});

/// Provider for managing loading state
final watchlistLoadingProvider = StateProvider<bool>((ref) => false);

/// Notifier for managing watchlist state
class WatchlistNotifier extends StateNotifier<List<WatchlistGroup>> {
  WatchlistNotifier() : super(_mockWatchlistData);

  /// Add a new watchlist
  void addWatchlist(String name) {
    final newGroup = WatchlistGroup(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      isExpanded: true,
      stocks: [],
    );
    state = [...state, newGroup];
  }

  /// Remove a watchlist
  void removeWatchlist(String id) {
    state = state.where((group) => group.id != id).toList();
  }

  /// Rename a watchlist
  void renameWatchlist(String id, String newName) {
    state = state.map<WatchlistGroup>((group) {
      if (group.id == id) {
        return group.copyWith(name: newName);
      }
      return group;
    }).toList();
  }

  /// Reorder watchlists
  void reorderWatchlists(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final items = [...state];
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }

  /// Update stocks for a watchlist
  void updateWatchlistStocks(String id, List<Stock> newStocks) {
    state = state.map<WatchlistGroup>((group) {
      if (group.id == id) {
        return group.copyWith(stocks: newStocks);
      }
      return group;
    }).toList();
  }

  /// Toggle expand/collapse for a group
  void toggleGroup(String groupId) {
    state = state.map<WatchlistGroup>((group) {
      if (group.id == groupId) {
        return group.copyWith(isExpanded: !group.isExpanded);
      }
      return group;
    }).toList();
  }

  /// Simulate refresh (for pull-to-refresh)
  Future<void> refresh() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    // In real app, fetch from API
    state = _mockWatchlistData;
  }
}

/// Mock data for development
final List<WatchlistGroup> _mockWatchlistData = [
  WatchlistGroup(
    id: '1',
    name: 'My Watchlist',
    isExpanded: true,
    stocks: [
      Stock.create(
        symbol: 'RELIANCE',
        name: 'Reliance Industries Ltd',
        price: 2450.00,
        change: 29.10,
        changePercent: 1.20,
      ),
      Stock.create(
        symbol: 'TCS',
        name: 'Tata Consultancy Svcs',
        price: 3340.50,
        change: -13.40,
        changePercent: -0.40,
      ),
      Stock.create(
        symbol: 'INFY',
        name: 'Infosys Limited',
        price: 1420.10,
        change: 11.35,
        changePercent: 0.80,
      ),
      Stock.create(
        symbol: 'HDFCBANK',
        name: 'HDFC Bank Ltd',
        price: 1530.45,
        change: -8.20,
        changePercent: -0.53,
      ),
      Stock.create(
        symbol: 'ITC',
        name: 'ITC Limited',
        price: 445.60,
        change: 0.85,
        changePercent: 0.19,
      ),
      Stock.create(
        symbol: 'SBIN',
        name: 'State Bank of India',
        price: 578.00,
        change: 12.45,
        changePercent: 2.20,
      ),
    ],
  ),
  WatchlistGroup(
    id: '2',
    name: 'Bank Nifty',
    isExpanded: false,
    stocks: [
      Stock.create(
        symbol: 'ICICIBANK',
        name: 'ICICI Bank Ltd',
        price: 960.25,
        change: 5.60,
        changePercent: 0.59,
      ),
      Stock.create(
        symbol: 'KOTAKBANK',
        name: 'Kotak Mahindra Bank',
        price: 1820.50,
        change: -4.30,
        changePercent: -0.24,
      ),
      Stock.create(
        symbol: 'AXISBANK',
        name: 'Axis Bank Ltd',
        price: 985.10,
        change: 8.40,
        changePercent: 0.86,
      ),
    ],
  ),
  WatchlistGroup(
    id: '3',
    name: 'IT Sector',
    isExpanded: false,
    stocks: [
      Stock.create(
        symbol: 'WIPRO',
        name: 'Wipro Limited',
        price: 405.30,
        change: -2.10,
        changePercent: -0.52,
      ),
      Stock.create(
        symbol: 'HCLTECH',
        name: 'HCL Technologies',
        price: 1150.80,
        change: 15.20,
        changePercent: 1.34,
      ),
      Stock.create(
        symbol: 'TECHM',
        name: 'Tech Mahindra Ltd',
        price: 1120.45,
        change: 9.50,
        changePercent: 0.86,
      ),
    ],
  ),
];

/// Mock data for market indices
final List<MarketIndex> _mockMarketIndices = [
  MarketIndex(
    name: 'NIFTY 50',
    value: 19450.00,
    change: 85.35,
    changePercent: 0.45,
  ),
  MarketIndex(
    name: 'SENSEX',
    value: 65300.00,
    change: -78.10,
    changePercent: -0.12,
  ),
];

class MarketIndex {
  final String name;
  final double value;
  final double change;
  final double changePercent;

  MarketIndex({
    required this.name,
    required this.value,
    required this.change,
    required this.changePercent,
  });
  
  bool get isPositive => change >= 0;
}

final marketIndicesProvider = Provider<List<MarketIndex>>((ref) {
  return _mockMarketIndices;
});

/// Mock data for master stock list (searchable)
final masterStocksProvider = Provider<List<Stock>>((ref) {
  return [
    Stock.create(symbol: 'RELIANCE', name: 'Reliance Industries Ltd', price: 2450.00, change: 29.10, changePercent: 1.20),
    Stock.create(symbol: 'TCS', name: 'Tata Consultancy Svcs', price: 3340.50, change: -13.40, changePercent: -0.40),
    Stock.create(symbol: 'HDFCBANK', name: 'HDFC Bank Ltd', price: 1530.45, change: -8.20, changePercent: -0.53),
    Stock.create(symbol: 'INFY', name: 'Infosys Limited', price: 1420.10, change: 11.35, changePercent: 0.80),
    Stock.create(symbol: 'ITC', name: 'ITC Limited', price: 445.60, change: 0.85, changePercent: 0.19),
    Stock.create(symbol: 'SBIN', name: 'State Bank of India', price: 578.00, change: 12.45, changePercent: 2.20),
    Stock.create(symbol: 'ICICIBANK', name: 'ICICI Bank Ltd', price: 960.25, change: 5.60, changePercent: 0.59),
    Stock.create(symbol: 'KOTAKBANK', name: 'Kotak Mahindra Bank', price: 1820.50, change: -4.30, changePercent: -0.24),
    Stock.create(symbol: 'AXISBANK', name: 'Axis Bank Ltd', price: 985.10, change: 8.40, changePercent: 0.86),
    Stock.create(symbol: 'WIPRO', name: 'Wipro Limited', price: 405.30, change: -2.10, changePercent: -0.52),
    Stock.create(symbol: 'HCLTECH', name: 'HCL Technologies', price: 1150.80, change: 15.20, changePercent: 1.34),
    Stock.create(symbol: 'TECHM', name: 'Tech Mahindra Ltd', price: 1120.45, change: 9.50, changePercent: 0.86),
    Stock.create(symbol: 'LTIM', name: 'LTIMindtree Ltd', price: 4850.00, change: -23.50, changePercent: -0.48),
    Stock.create(symbol: 'TATAMOTORS', name: 'Tata Motors Ltd', price: 620.15, change: 14.30, changePercent: 2.36),
    Stock.create(symbol: 'SUNPHARMA', name: 'Sun Pharmaceutical', price: 1130.00, change: 5.50, changePercent: 0.49),
  ];
});
