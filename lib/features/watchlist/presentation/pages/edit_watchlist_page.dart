import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';

class EditWatchlistPage extends ConsumerStatefulWidget {
  const EditWatchlistPage({super.key});

  @override
  ConsumerState<EditWatchlistPage> createState() => _EditWatchlistPageState();
}

class _EditWatchlistPageState extends ConsumerState<EditWatchlistPage> {
  final TextEditingController _createController = TextEditingController();

  @override
  void dispose() {
    _createController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchlists = ref.watch(watchlistProvider);
    final count = watchlists.length;
    final maxCount = 10;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.darkTextPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: const Text(
            'Manage Watchlists',
            style: TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Done',
                style: TextStyle(
                  color: AppColors.premiumAccentBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              color: AppColors.premiumCardBorder,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Create New Watchlist Section
                _buildSectionTitle('CREATE NEW WATCHLIST'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.premiumCardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _createController,
                              style: const TextStyle(color: AppColors.darkTextPrimary),
                              decoration: InputDecoration(
                                hintText: 'Watchlist Name (e.g. Blue Chips)',
                                hintStyle: const TextStyle(
                                  color: AppColors.darkTextSecondary,
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: AppColors.premiumSurface,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.premiumCardBorder),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.premiumCardBorder),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: AppColors.premiumAccentBlue, width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: count >= maxCount
                                ? null
                                : () {
                                    final name = _createController.text.trim();
                                    if (name.isNotEmpty) {
                                      ref.read(watchlistProvider.notifier).addWatchlist(name);
                                      _createController.clear();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.premiumAccentBlue,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: AppColors.premiumAccentBlue.withOpacity(0.3),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                            ),
                            child: const Text('Create'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You can create up to $maxCount watchlists with 50 stocks each.',
                        style: TextStyle(
                          color: AppColors.darkTextSecondary.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // 3. My Watchlists Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle('MY WATCHLISTS ($count/$maxCount)'),
                    const Text(
                      'Hold & drag to reorder',
                      style: TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // 4. Watchlist List
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: watchlists.length,
                  onReorder: (oldIndex, newIndex) {
                    ref.read(watchlistProvider.notifier).reorderWatchlists(oldIndex, newIndex);
                  },
                  proxyDecorator: (child, index, animation) {
                     return Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.premiumCardBackground,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.premiumAccentBlue.withOpacity(0.5),
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    final group = watchlists[index];
                    return Container(
                      key: ValueKey(group.id),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                          color: AppColors.premiumCardBackground,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.premiumCardBorder,
                            width: 0.5,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: const Icon(
                            Icons.drag_indicator,
                            color: AppColors.darkTextSecondary,
                            size: 20,
                          ),
                          title: Text(
                            group.name,
                            style: const TextStyle(
                              color: AppColors.darkTextPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${group.stocks.length} stocks',
                            style: const TextStyle(
                              color: AppColors.darkTextSecondary,
                              fontSize: 12,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.darkTextSecondary,
                                  size: 20,
                                ),
                                onPressed: () => _showEditDialog(context, ref, group.id, group.name),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: AppColors.premiumAccentRed,
                                  size: 20,
                                ),
                                onPressed: () => _showDeleteDialog(context, ref, group.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                ),

                const SizedBox(height: 24),

                // 5. Reorder Info Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.premiumAccentBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.premiumAccentBlue.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.premiumAccentBlue,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Reordering watchlists will update the sequence of tabs on your main screen. You can also quickly switch watchlists by swiping horizontally on the main view.',
                          style: TextStyle(
                            color: AppColors.darkTextSecondary.withOpacity(0.9),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, WidgetRef ref, String id, String currentName) {
    // ... use existing dialog logic but maybe style it slightly better if needed
    // Keeping logic similar to previous implementation for reuse
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (context) => _buildDialog(
        context: context,
        title: 'Rename Watchlist',
        controller: controller,
        onConfirm: () {
          if (controller.text.trim().isNotEmpty) {
            ref.read(watchlistProvider.notifier).renameWatchlist(id, controller.text.trim());
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String id) {
    // Logic to prevent deleting if it's the last one? Request said "Disable delete when minimum watchlists reached"
    // Let's implement that check.
    if (ref.read(watchlistProvider).length <= 1) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must have at least one watchlist.')),
        );
        return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.premiumCardBackground,
        title: const Text(
          'Delete Watchlist',
          style: TextStyle(color: AppColors.darkTextPrimary),
        ),
        content: const Text(
          'Are you sure you want to delete this watchlist? This action cannot be undone.',
          style: TextStyle(color: AppColors.darkTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.darkTextSecondary)),
          ),
          TextButton(
            onPressed: () {
              ref.read(watchlistProvider.notifier).removeWatchlist(id);
              Navigator.pop(context);
            },
            child: const Text('Delete',
                style: TextStyle(color: AppColors.premiumAccentRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialog({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required VoidCallback onConfirm,
  }) {
    return AlertDialog(
      backgroundColor: AppColors.premiumCardBackground,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.darkTextPrimary),
      ),
      content: TextField(
        controller: controller,
        style: const TextStyle(color: AppColors.darkTextPrimary),
        decoration: const InputDecoration(
          hintText: 'Enter name',
          hintStyle: TextStyle(color: AppColors.darkTextSecondary),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.premiumCardBorder),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.premiumAccentBlue),
          ),
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel',
              style: TextStyle(color: AppColors.darkTextSecondary)),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: const Text('Save',
              style: TextStyle(color: AppColors.premiumAccentBlue)),
        ),
      ],
    );
  }
}
