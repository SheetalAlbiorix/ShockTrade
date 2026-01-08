import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/stock_row_widget.dart';

/// Expandable watchlist group card with stocks list
class WatchlistGroupCard extends StatelessWidget {
  final WatchlistGroup group;
  final VoidCallback onToggle;
  final Function(Stock)? onTrade;
  final Function(Stock)? onDetails;

  const WatchlistGroupCard({
    super.key,
    required this.group,
    required this.onToggle,
    this.onTrade,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.darkDivider,
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          _buildHeader(context),
          // Expandable content
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: group.isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: _buildStocksList(),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Semantics(
      label: '${group.name}, ${group.stockCount} stocks, '
          '${group.isExpanded ? "expanded" : "collapsed"}',
      button: true,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onToggle();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            border: group.isExpanded
                ? const Border(
                    bottom: BorderSide(
                      color: AppColors.darkDivider,
                      width: 0.5,
                    ),
                  )
                : null,
          ),
          child: Row(
            children: [
              // Group name
              Expanded(
                child: Text(
                  group.name,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Stock count badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.darkCardBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${group.stockCount} ${group.stockCount == 1 ? "stock" : "stocks"}',
                  style: const TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Expand/collapse chevrons
              AnimatedRotation(
                turns: group.isExpanded ? 0 : 0.5,
                duration: const Duration(milliseconds: 250),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: AppColors.darkTextSecondary,
                      size: 20,
                    ),
                    Transform.translate(
                      offset: const Offset(-8, 0),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: AppColors.darkTextSecondary,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStocksList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: group.stocks.map((stock) {
        return StockRowWidget(
          stock: stock,
          onTrade: () => onTrade?.call(stock),
          onDetails: () => onDetails?.call(stock),
        );
      }).toList(),
    );
  }
}
