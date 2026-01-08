import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_group_card.dart';

/// Watchlist page - displays user's stock watchlists with expandable groups
class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistGroups = ref.watch(watchlistProvider);
    final isLoading = ref.watch(watchlistLoadingProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        title: const Text(
          AppStrings.watchlist,
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              _showAddDialog(context);
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.darkTextPrimary,
            ),
            tooltip: 'Add stock or watchlist',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.darkDivider,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(watchlistLoadingProvider.notifier).state = true;
          await ref.read(watchlistProvider.notifier).refresh();
          ref.read(watchlistLoadingProvider.notifier).state = false;
        },
        color: AppColors.navActiveColor,
        backgroundColor: AppColors.darkCardBackground,
        child: watchlistGroups.isEmpty
            ? _buildEmptyState(context)
            : _buildWatchlist(context, ref, watchlistGroups),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _showAddDialog(context);
        },
        backgroundColor: AppColors.navActiveColor,
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWatchlist(
    BuildContext context,
    WidgetRef ref,
    List<WatchlistGroup> groups,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return WatchlistGroupCard(
          group: group,
          onToggle: () {
            ref.read(watchlistProvider.notifier).toggleGroup(group.id);
          },
          onTrade: (stock) => _showTradeDialog(context, stock),
          onDetails: (stock) => _showDetailsDialog(context, stock),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_outline,
                size: 80,
                color: AppColors.navActiveColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'No Watchlists Yet',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.darkTextPrimary,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create a watchlist and add stocks to track their prices',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Create Watchlist'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navActiveColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add to Watchlist',
                  style: TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.navActiveColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.search,
                      color: AppColors.navActiveColor,
                    ),
                  ),
                  title: const Text(
                    'Search & Add Stock',
                    style: TextStyle(color: AppColors.darkTextPrimary),
                  ),
                  subtitle: const Text(
                    'Find stocks by name or symbol',
                    style: TextStyle(color: AppColors.darkTextSecondary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to stock search
                  },
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.navActiveColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.create_new_folder_outlined,
                      color: AppColors.navActiveColor,
                    ),
                  ),
                  title: const Text(
                    'Create New Watchlist',
                    style: TextStyle(color: AppColors.darkTextPrimary),
                  ),
                  subtitle: const Text(
                    'Organize stocks into groups',
                    style: TextStyle(color: AppColors.darkTextSecondary),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Create new watchlist
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTradeDialog(BuildContext context, Stock stock) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trade ${stock.symbol} - Coming soon!'),
        backgroundColor: AppColors.darkSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Stock stock) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${stock.symbol} details - Coming soon!'),
        backgroundColor: AppColors.darkSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
