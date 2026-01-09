import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';

class EditWatchlistContentPage extends ConsumerStatefulWidget {
  final String watchlistId;
  final String watchlistName;

  const EditWatchlistContentPage({
    super.key,
    required this.watchlistId,
    required this.watchlistName,
  });

  @override
  ConsumerState<EditWatchlistContentPage> createState() =>
      _EditWatchlistContentPageState();
}

class _EditWatchlistContentPageState
    extends ConsumerState<EditWatchlistContentPage> {
  late List<Stock> _currentStocks;
  final TextEditingController _searchController = TextEditingController();
  late TextEditingController _nameController;
  bool _hasChanges = false;
  List<Stock> _searchResults = [];

  @override
  void initState() {
    super.initState();
    // Initialize with current stocks from the provider
    final watchlists = ref.read(watchlistProvider);
    final group = watchlists.firstWhere((g) => g.id == widget.watchlistId,
        orElse: () => watchlists.first);
    _currentStocks = List.from(group.stocks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final masterList = ref.read(masterStocksProvider);
    final lowerQuery = query.toLowerCase();

    setState(() {
      _searchResults = masterList.where((stock) {
        // Don't show stocks already in the list
        final alreadyAdded =
            _currentStocks.any((s) => s.symbol == stock.symbol);
        if (alreadyAdded) return false;

        return stock.symbol.toLowerCase().contains(lowerQuery) ||
            stock.name.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  void _addStock(Stock stock) {
    setState(() {
      _currentStocks.add(stock);
      _hasChanges = true;
      _searchController.clear();
      _searchResults = [];
    });
  }

  void _removeStock(int index) {
    setState(() {
      _currentStocks.removeAt(index);
      _hasChanges = true;
    });
  }

  void _showCreateStockDialog() {
    final symbolController = TextEditingController();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final changeController = TextEditingController();
    final percentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.premiumCardBackground,
        title: const Text('Add Custom Stock', style: TextStyle(color: AppColors.darkTextPrimary)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogInput(symbolController, 'Symbol (e.g., RELIANCE)'),
              const SizedBox(height: 12),
              _buildDialogInput(nameController, 'Company Name'),
              const SizedBox(height: 12),
              _buildDialogInput(priceController, 'Current Price', isNumeric: true),
              const SizedBox(height: 12),
              _buildDialogInput(changeController, 'Change', isNumeric: true),
              const SizedBox(height: 12),
              _buildDialogInput(percentController, 'Change %', isNumeric: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.darkTextSecondary)),
          ),
          TextButton(
            onPressed: () {
              if (symbolController.text.isEmpty || nameController.text.isEmpty) {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Symbol and Name are required')),
                );
                return;
              }
              
              final newStock = Stock.create(
                symbol: symbolController.text.toUpperCase(),
                name: nameController.text,
                price: double.tryParse(priceController.text) ?? 0.0,
                change: double.tryParse(changeController.text) ?? 0.0,
                changePercent: double.tryParse(percentController.text) ?? 0.0,
              );
              
              _addStock(newStock);
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: AppColors.premiumAccentBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogInput(TextEditingController controller, String hint, {bool isNumeric = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumeric ? const TextInputType.numberWithOptions(decimal: true, signed: true) : TextInputType.text,
      style: const TextStyle(color: AppColors.darkTextPrimary),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: AppColors.darkTextSecondary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.premiumCardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.premiumAccentBlue),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _saveChanges() {
    ref
        .read(watchlistProvider.notifier)
        .updateWatchlistStocks(widget.watchlistId, _currentStocks);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'Edit ${widget.watchlistName}',
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: _hasChanges ? _saveChanges : null,
              child: Text(
                'Save',
                style: TextStyle(
                  color: _hasChanges
                      ? AppColors.premiumAccentBlue
                      : AppColors.darkTextSecondary.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Column(
          children: [
            // Sticky Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    style: const TextStyle(color: AppColors.darkTextPrimary),
                    decoration: InputDecoration(
                      hintText: 'Add stocks (e.g., WIPRO, HCLTECH)',
                      hintStyle: const TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.darkTextSecondary),
                      filled: true,
                      fillColor: AppColors.premiumSurface,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.premiumCardBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.premiumCardBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.premiumAccentBlue, width: 2),
                      ),
                    ),
                  ),
                  
                  // Search Results Dropdown
                  if (_searchResults.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      constraints: const BoxConstraints(maxHeight: 200),
                      decoration: BoxDecoration(
                        color: AppColors.premiumCardBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                        border: Border.all(color: AppColors.premiumCardBorder),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1, 
                          color: AppColors.premiumCardBorder.withOpacity(0.5),
                        ),
                        itemBuilder: (context, index) {
                          final stock = _searchResults[index];
                          return ListTile(
                            title: Text(stock.symbol, 
                              style: const TextStyle(
                                color: AppColors.darkTextPrimary, 
                                fontWeight: FontWeight.bold
                              )
                            ),
                            subtitle: Text(stock.name,
                              style: const TextStyle(
                                color: AppColors.darkTextSecondary, 
                                fontSize: 12
                              )
                            ),
                            trailing: const Icon(Icons.add_circle_outline, 
                              color: AppColors.premiumAccentGreen
                            ),
                            onTap: () => _addStock(stock),
                          );
                        },
                      ),
                    ),
                    
                  if (_searchResults.isEmpty)
                     Padding(
                       padding: const EdgeInsets.only(top: 12.0),
                       child: TextButton.icon(
                        onPressed: _showCreateStockDialog,
                        icon: const Icon(Icons.add, color: AppColors.premiumAccentBlue),
                        label: const Text('Create Custom Stock', style: TextStyle(color: AppColors.premiumAccentBlue)),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          backgroundColor: AppColors.premiumAccentBlue.withOpacity(0.1),
                        ),
                       ),
                     ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Stocks List
            Expanded(
              child: _currentStocks.isEmpty
                  ? Center(
                      child: Text(
                        'No stocks in this watchlist',
                        style: TextStyle(
                            color: AppColors.darkTextSecondary.withOpacity(0.7)),
                      ),
                    )
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                      itemCount: _currentStocks.length,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item = _currentStocks.removeAt(oldIndex);
                          _currentStocks.insert(newIndex, item);
                          _hasChanges = true;
                        });
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
                                color: AppColors.premiumAccentBlue
                                    .withOpacity(0.5),
                              ),
                            ),
                            child: child,
                          ),
                        );
                      },
                      itemBuilder: (context, index) {
                        final stock = _currentStocks[index];
                        return Container(
                          key: ValueKey('${stock.symbol}_$index'), // Unique key
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.drag_indicator,
                                  color: AppColors.darkTextSecondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.premiumSurface,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    stock.symbol[0],
                                    style: const TextStyle(
                                      color: AppColors.premiumAccentBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Row(
                              children: [
                                Text(
                                  stock.symbol,
                                  style: const TextStyle(
                                    color: AppColors.darkTextPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.premiumSurface,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: AppColors.premiumCardBorder),
                                  ),
                                  child: const Text(
                                    'NSE',
                                    style: TextStyle(
                                      color: AppColors.darkTextSecondary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              stock.name,
                              style: const TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: InkWell(
                              onTap: () => _removeStock(index),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.premiumAccentRed.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColors.premiumAccentRed,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            
            // Reordering Hint
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
              child: Text(
                'Drag handles on the left to reorder stocks',
                style: TextStyle(
                  color: AppColors.darkTextSecondary.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
