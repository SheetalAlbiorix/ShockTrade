import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/index_summary_cards.dart';

import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_search_bar.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_stock_card.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_tabs.dart';
import 'package:shock_app/features/watchlist/presentation/pages/edit_watchlist_page.dart';

class WatchlistPage extends ConsumerStatefulWidget {
  const WatchlistPage({super.key});

  @override
  ConsumerState<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends ConsumerState<WatchlistPage> {
  int _selectedTabIndex = 0;
  String _searchQuery = '';

  void _addStockToCurrentWatchlist(Stock stock) {
    if (_selectedTabIndex >= ref.read(watchlistProvider).length) return;
    
    final currentGroup = ref.read(watchlistProvider)[_selectedTabIndex];
    // Check if already exists
    if (currentGroup.stocks.any((s) => s.symbol == stock.symbol)) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${stock.symbol} is already in ${currentGroup.name}')),
      );
      return;
    }

    final updatedStocks = List<Stock>.from(currentGroup.stocks)..add(stock);
    ref.read(watchlistProvider.notifier).updateWatchlistStocks(currentGroup.id, updatedStocks);
     
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ${stock.symbol} to ${currentGroup.name}')),
    );
  }

  Future<bool> _confirmDelete(Stock stock) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.premiumCardBackground,
        title: const Text('Remove Stock?', style: TextStyle(color: AppColors.darkTextPrimary)),
        content: Text('Are you sure you want to remove ${stock.symbol} from this watchlist?', style: const TextStyle(color: AppColors.darkTextSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.darkTextSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove', style: TextStyle(color: AppColors.premiumAccentRed)),
          ),
        ],
      ),
    ) ?? false;
  }

  void _removeStock(String watchlistId, Stock stock) async {
      // Logic handled by Dismissible, this is just helper if needed
      final currentGroup = ref.read(watchlistProvider).firstWhere((g) => g.id == watchlistId);
      final updatedStocks = List<Stock>.from(currentGroup.stocks)..removeWhere((s) => s.symbol == stock.symbol);
      ref.read(watchlistProvider.notifier).updateWatchlistStocks(watchlistId, updatedStocks);
  }

  void _onReorder(int oldIndex, int newIndex) {
     if (_selectedTabIndex >= ref.read(watchlistProvider).length) return;
     final currentGroup = ref.read(watchlistProvider)[_selectedTabIndex];
     
     if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final updatedStocks = List<Stock>.from(currentGroup.stocks);
    final item = updatedStocks.removeAt(oldIndex);
    updatedStocks.insert(newIndex, item);

    ref.read(watchlistProvider.notifier).updateWatchlistStocks(currentGroup.id, updatedStocks);
  }

  @override
  Widget build(BuildContext context) {
    final watchlistGroups = ref.watch(watchlistProvider);
    
    // Safety check for index
    if (_selectedTabIndex >= watchlistGroups.length) {
      _selectedTabIndex = 0;
    }

    // Get Current Data
    final currentGroup = watchlistGroups.isNotEmpty ? watchlistGroups[_selectedTabIndex] : null;
    final currentStocks = currentGroup?.stocks ?? [];
    final tabs = watchlistGroups.map((g) => g.name).toList();

    // Prepare Search Results
    List<Stock> searchResults = [];
    if (_searchQuery.isNotEmpty) {
      final masterList = ref.read(masterStocksProvider);
      final lowerQuery = _searchQuery.toLowerCase();
      
      searchResults = masterList.where((stock) {
         return stock.symbol.toLowerCase().contains(lowerQuery) ||
                stock.name.toLowerCase().contains(lowerQuery);
      }).toList();

      // Dummy Data Fallback for testing
      if (searchResults.isEmpty) {
         searchResults = [
           Stock.create(symbol: "${_searchQuery.toUpperCase()} LTD", name: "$_searchQuery Industries", price: 154.20, change: 5.5, changePercent: 3.4),
           const Stock(symbol: "DUMMY1", name: "Dummy Stock 1", price: 100, change: 10, changePercent: 10.0, isPositive: true),
           const Stock(symbol: "DUMMY2", name: "Dummy Stock 2", price: 200, change: -5, changePercent: -2.5, isPositive: false),
         ];
      }
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Watchlist',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditWatchlistPage(),
                          ),
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.premiumSurface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: AppColors.darkTextPrimary,
                          size: 20,
                        ),
                      ),
                      tooltip: 'Edit Watchlist',
                    ),
                  ],
                ),
              ),
  
              // 2. Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: WatchlistSearchBar(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: 8),

              // 3. Content Body
              Expanded(
                child: _searchQuery.isNotEmpty 
                  ? _buildSearchResults(searchResults)
                  : _buildMainContent(tabs, currentStocks, currentGroup?.id ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Stock> results) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      separatorBuilder: (context, index) => Divider(color: AppColors.premiumCardBorder.withOpacity(0.5)),
      itemBuilder: (context, index) {
        final stock = results[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40, height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.premiumCardBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(stock.symbol[0], style: const TextStyle(color: AppColors.premiumAccentBlue, fontWeight: FontWeight.bold)),
          ),
          title: Text(stock.symbol, style: const TextStyle(color: AppColors.darkTextPrimary, fontWeight: FontWeight.bold)),
          subtitle: Text(stock.name, style: const TextStyle(color: AppColors.darkTextSecondary)),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle_outline, color: AppColors.premiumAccentGreen),
            onPressed: () => _addStockToCurrentWatchlist(stock),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(List<String> tabs, List<Stock> currentStocks, String currentWatchlistId) {
    return Column(
      children: [
        // Index Cards
        const IndexSummaryCards(),

        const SizedBox(height: 24),

        // Tabs
        WatchlistTabs(
          selectedIndex: _selectedTabIndex,
          tabs: tabs,
          onTabSelected: (index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
        ),

        const SizedBox(height: 16),

        // Stock List
        Expanded(
          child: currentStocks.isEmpty
              ? const Center(
                  child: Text(
                    'No stocks in this watchlist',
                    style: TextStyle(color: AppColors.darkTextSecondary),
                  ),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: currentStocks.length,
                  onReorder: _onReorder,
                  proxyDecorator: (child, index, animation) {
                    return Material(
                      color: Colors.transparent,
                      child: Container(
                         decoration: BoxDecoration(
                           color: AppColors.premiumCardBackground,
                           borderRadius: BorderRadius.circular(12),
                           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)],
                         ),
                         child: child,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final stock = currentStocks[index];
                    return Dismissible(
                      key: ValueKey('${stock.symbol}_$index'), // Unique key
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) => _confirmDelete(stock),
                      onDismissed: (direction) {
                          _removeStock(currentWatchlistId, stock);
                      },
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: AppColors.premiumAccentRed,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                         // Wrap with container to add spacing if needed, though ReorderableListView handles it.
                         // StockListCard likely has padding.
                         margin: const EdgeInsets.only(bottom: 12),
                         child: WatchlistStockCard(
                           stock: stock,
                           onTap: () => context.push('/stock-detail?symbol=${stock.symbol}&name=${stock.name}'),
                         ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
