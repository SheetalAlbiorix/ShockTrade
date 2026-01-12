import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/search/presentation/widgets/search_header.dart';
import 'package:shock_app/features/search/presentation/widgets/sticky_search_bar.dart';
import 'package:shock_app/features/search/presentation/widgets/filter_chips_selector.dart';

import 'package:shock_app/features/search/presentation/widgets/recent_searches_section.dart';
import 'package:shock_app/features/search/presentation/widgets/trending_stocks_section.dart';
import 'package:shock_app/features/search/presentation/widgets/most_active_section.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_stock_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  String _searchQuery = '';
  String _currentFilter = 'All';
  
  // Local state for recent searches (could be moved to provider for persistence)
  List<Stock> _recentSearches = [];
  
  void _addToRecent(Stock stock) {
     if (!_recentSearches.any((s) => s.symbol == stock.symbol)) {
       setState(() {
         _recentSearches.insert(0, stock);
         if (_recentSearches.length > 5) _recentSearches.removeLast();
       });
     }
  }

  void _clearRecent() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final masterList = ref.read(masterStocksProvider);
    
    // Filter Logic
    List<Stock> searchResults = [];
    if (_searchQuery.isNotEmpty) {
       final lowerQuery = _searchQuery.toLowerCase();
       searchResults = masterList.where((stock) {
         final matchesQuery = stock.symbol.toLowerCase().contains(lowerQuery) || 
                              stock.name.toLowerCase().contains(lowerQuery);
         // Add type filtering if we had 'type' in Stock model (assuming all are stocks for now)
         return matchesQuery;
       }).toList();
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
              const SearchHeader(),

              // 2. Search Bar
              StickySearchBar(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),

              // 3. Filter Chips
              FilterChipsSelector(
                onFilterChanged: (filter) {
                  setState(() {
                    _currentFilter = filter;
                  });
                },
              ),
              
              const SizedBox(height: 8),

              // 4. Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      if (_searchQuery.isEmpty) ...[
                         // Sections
                         if (_recentSearches.isNotEmpty)
                           RecentSearchesSection(
                             items: _recentSearches, 
                             onClear: _clearRecent
                           ),
                         
                         const SizedBox(height: 24),
                         const TrendingStocksSection(),
                         const MostActiveSection(),
                      ] else ...[
                        // Search Results List
                        if (searchResults.isEmpty)
                           Container(
                             height: 200, 
                             alignment: Alignment.center,
                             child: Text(
                               'No results found', 
                               style: TextStyle(color: AppColors.darkTextSecondary.withOpacity(0.5))
                             )
                           )
                        else
                           ListView.builder(
                             shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                             padding: const EdgeInsets.symmetric(horizontal: 16),
                             itemCount: searchResults.length,
                             itemBuilder: (context, index) {
                               final stock = searchResults[index];
                               return Padding(
                                 padding: const EdgeInsets.only(bottom: 12),
                                 child: WatchlistStockCard(
                                   stock: stock,
                                   onTap: () {
                                     _addToRecent(stock);
                                     context.push('/stock-detail?symbol=${stock.symbol}&name=${stock.name}');
                                   },
                                 ),
                               );
                             },
                           ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
