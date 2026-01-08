import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';

/// News page - displays market news and company updates
class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        title: const Text(
          AppStrings.news,
          style: TextStyle(color: AppColors.darkTextPrimary),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.filter_list, color: AppColors.darkTextSecondary),
            onPressed: () {
              // TODO: Show filter options
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // News category tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip(context, 'All', isSelected: true),
                _buildCategoryChip(context, 'Market'),
                _buildCategoryChip(context, 'Stocks'),
                _buildCategoryChip(context, 'Economy'),
                _buildCategoryChip(context, 'IPO'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // News placeholder cards
          _buildNewsCard(
            context,
            title: 'Markets Close Higher on Strong Earnings',
            source: 'Economic Times',
            time: '2 hours ago',
            imageColor: AppColors.chartBlue,
          ),
          _buildNewsCard(
            context,
            title: 'RBI Keeps Repo Rate Unchanged at 6.5%',
            source: 'Mint',
            time: '4 hours ago',
            imageColor: AppColors.chartGreen,
          ),
          _buildNewsCard(
            context,
            title: 'Tech Stocks Rally Amid AI Optimism',
            source: 'Business Standard',
            time: '6 hours ago',
            imageColor: AppColors.chartPurple,
          ),
          _buildNewsCard(
            context,
            title: 'Sensex, Nifty End Week on a Positive Note',
            source: 'Moneycontrol',
            time: '1 day ago',
            imageColor: AppColors.chartOrange,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label,
      {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : AppColors.darkTextSecondary,
            fontSize: 13,
          ),
        ),
        selected: isSelected,
        onSelected: (value) {
          // TODO: Handle category selection
        },
        backgroundColor: AppColors.darkCardBackground,
        selectedColor: AppColors.navActiveColor,
        checkmarkColor: Colors.white,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildNewsCard(
    BuildContext context, {
    required String title,
    required String source,
    required String time,
    required Color imageColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkDivider, width: 1),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to news detail
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: imageColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.article,
                  color: imageColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              // News content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.darkTextPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          source,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.navActiveColor,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.darkTextSecondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: AppColors.darkTextSecondary,
                                  ),
                        ),
                      ],
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
}
