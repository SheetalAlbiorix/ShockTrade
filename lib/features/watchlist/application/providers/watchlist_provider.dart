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

  /// Toggle expand/collapse for a group
  void toggleGroup(String groupId) {
    state = state.map((group) {
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
    name: 'My Core Holdings',
    isExpanded: true,
    stocks: [
      Stock.create(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        price: 170.25,
        change: 1.20,
        changePercent: 0.71,
      ),
      Stock.create(
        symbol: 'MSFT',
        name: 'Microsoft Corp.',
        price: 420.10,
        change: -0.85,
        changePercent: -0.20,
      ),
      Stock.create(
        symbol: 'GOOGL',
        name: 'Alphabet Inc.',
        price: 155.60,
        change: 2.15,
        changePercent: 1.40,
      ),
    ],
  ),
  WatchlistGroup(
    id: '2',
    name: 'Tech Innovators',
    isExpanded: true,
    stocks: [
      Stock.create(
        symbol: 'NVDA',
        name: 'NVIDIA Corp.',
        price: 900.50,
        change: 15.75,
        changePercent: 1.78,
      ),
      Stock.create(
        symbol: 'TSLA',
        name: 'Tesla Inc.',
        price: 175.80,
        change: -3.20,
        changePercent: -1.79,
      ),
      Stock.create(
        symbol: 'AMZN',
        name: 'Amazon.com Inc.',
        price: 180.30,
        change: 0.90,
        changePercent: 0.50,
      ),
      Stock.create(
        symbol: 'SMCI',
        name: 'Super Micro Comp.',
        price: 920.80,
        change: 25.10,
        changePercent: 2.80,
      ),
    ],
  ),
  WatchlistGroup(
    id: '3',
    name: 'Emerging Markets',
    isExpanded: false,
    stocks: [
      Stock.create(
        symbol: 'BABA',
        name: 'Alibaba Group',
        price: 85.60,
        change: 1.25,
        changePercent: 1.48,
      ),
      Stock.create(
        symbol: 'JD',
        name: 'JD.com Inc.',
        price: 28.45,
        change: -0.35,
        changePercent: -1.22,
      ),
    ],
  ),
];
