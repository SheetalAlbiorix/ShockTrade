import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:intl/intl.dart';

class HighlightCard extends StatelessWidget {
  final Holding holding;

  const HighlightCard({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131A2D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumCardBorder, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0C2B21),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome, color: AppColors.bullishGreen, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BEST PERFORMER TODAY',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  holding.name,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+₹${NumberFormat('#,##,##0.00').format(holding.pnlAmount)}',
                style: const TextStyle(
                  color: AppColors.bullishGreen,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '+${holding.pnlPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  color: AppColors.bullishGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PortfolioHoldingCard extends StatelessWidget {
  final Holding holding;
  final VoidCallback onTap;
  final VoidCallback onEditTap;

  const PortfolioHoldingCard({
    super.key,
    required this.holding,
    required this.onTap,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final compactFormat = NumberFormat.compactCurrency(locale: 'en_IN', symbol: '₹');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF131A2D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.premiumCardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    holding.logoUrl,
                    errorBuilder: (context, error, stackTrace) => 
                      const Center(child: Icon(Icons.business, color: Colors.blueGrey, size: 24)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holding.name,
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        holding.symbol,
                        style: const TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${holding.pnlAmount >= 0 ? "+" : ""}${currencyFormat.format(holding.pnlAmount)}',
                      style: TextStyle(
                        color: holding.isPositive ? AppColors.bullishGreen : AppColors.bearishRed,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${holding.isPositive ? "+" : ""}${holding.pnlPercentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: holding.isPositive ? AppColors.bullishGreen : AppColors.bearishRed,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.darkTextSecondary, size: 20),
                  onPressed: onEditTap,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF1E243A), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem('QTY', holding.quantity.toInt().toString()),
                _buildInfoItem('AVG', currencyFormat.format(holding.avgPrice)),
                _buildInfoItem('VALUE', compactFormat.format(holding.currentValue)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
