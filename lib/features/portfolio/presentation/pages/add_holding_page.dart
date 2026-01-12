import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/application/providers/portfolio_provider.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:intl/intl.dart';

class AddHoldingPage extends ConsumerStatefulWidget {
  const AddHoldingPage({super.key});

  @override
  ConsumerState<AddHoldingPage> createState() => _AddHoldingPageState();
}

class _AddHoldingPageState extends ConsumerState<AddHoldingPage> {
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController(text: '0.00');
  final _searchController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedExchange = 'NSE';
  
  StockSuggestion? _selectedStock;

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  double get _totalInvestment {
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    return qty * price;
  }

  void _handleAdd() {
    if (_selectedStock == null) return;
    
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    
    if (qty <= 0 || price <= 0) return;

    final newHolding = Holding.mock(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      symbol: _selectedStock!.symbol,
      name: _selectedStock!.name,
      logoUrl: _selectedStock!.logoUrl,
      quantity: qty,
      avgPrice: price,
      currentPrice: _selectedStock!.currentPrice,
      purchaseDate: _selectedDate,
    );

    ref.read(holdingsProvider.notifier).addHolding(newHolding);
    context.pop();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.navActiveColor,
              onPrimary: Colors.white,
              surface: AppColors.darkSurface,
              onSurface: AppColors.darkTextPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    final searchResults = ref.watch(stockSearchProvider);

    return Scaffold(
      backgroundColor: AppColors.premiumBackgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Add Holding',
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SEARCH STOCK',
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _buildSearchBar(ref),
            if (searchResults.isNotEmpty && _selectedStock == null)
              _buildSearchResults(searchResults),
            const SizedBox(height: 16),
            if (_selectedStock != null)
              _buildSelectedStockCard(currencyFormat, _selectedStock!),
            const SizedBox(height: 32),
            const Text(
              'EXCHANGE',
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            _buildExchangeSelector(),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'QUANTITY',
                        style: TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInputField(_quantityController, keyboardType: TextInputType.number),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AVG. BUY PRICE',
                        style: TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInputField(_priceController, prefix: '₹ ', keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'PURCHASE DATE',
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildDatePicker(context),
            const SizedBox(height: 40),
            _buildSummaryCard(currencyFormat),
            const SizedBox(height: 40),
            _buildAddButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppColors.darkTextPrimary),
        onChanged: (value) {
          ref.read(stockSearchQueryProvider.notifier).state = value;
          setState(() {
            _selectedStock = null;
          });
        },
        decoration: InputDecoration(
          hintText: 'e.g. HDFC Bank, RELIANCE',
          hintStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.darkTextSecondary),
          suffixIcon: _searchController.text.isNotEmpty ? IconButton(
            icon: const Icon(Icons.cancel, color: AppColors.darkTextSecondary, size: 20),
            onPressed: () {
              _searchController.clear();
              ref.read(stockSearchQueryProvider.notifier).state = '';
              setState(() {
                _selectedStock = null;
              });
            },
          ) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<StockSuggestion> results) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: results.length,
        separatorBuilder: (_, __) => const Divider(color: AppColors.premiumCardBorder, height: 1),
        itemBuilder: (context, index) {
          final stock = results[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(stock.logoUrl),
              radius: 16,
            ),
            title: Text(stock.name, style: const TextStyle(color: AppColors.darkTextPrimary, fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: Text(stock.symbol, style: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 12)),
            onTap: () {
              setState(() {
                _selectedStock = stock;
                _searchController.text = stock.name;
                _priceController.text = stock.currentPrice.toString();
              });
              ref.read(stockSearchQueryProvider.notifier).state = '';
            },
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }

  Widget _buildSelectedStockCard(NumberFormat currencyFormat, StockSuggestion stock) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navActiveColor.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              stock.logoUrl,
              errorBuilder: (_, __, ___) => const Icon(Icons.business, color: Colors.blueGrey, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.name,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${stock.symbol} • $_selectedExchange',
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
                currencyFormat.format(stock.currentPrice),
                style: const TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '+0.45%',
                style: TextStyle(
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

  Widget _buildExchangeSelector() {
    return Row(
      children: ['NSE', 'BSE'].map((ex) {
        final isSelected = _selectedExchange == ex;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedExchange = ex),
            child: Container(
              margin: EdgeInsets.only(right: ex == 'NSE' ? 12 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.navActiveColor : AppColors.premiumCardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? AppColors.navActiveColor : AppColors.premiumCardBorder,
                ),
              ),
              child: Center(
                child: Text(
                  ex,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.darkTextSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInputField(TextEditingController controller, {String? prefix, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(color: AppColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          prefixText: prefix,
          prefixStyle: const TextStyle(color: AppColors.darkTextSecondary, fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.premiumCardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.premiumCardBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MM/dd/yyyy').format(_selectedDate),
              style: const TextStyle(color: AppColors.darkTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.calendar_today, color: AppColors.darkTextSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Investment',
                style: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
              ),
              Text(
                currencyFormat.format(_totalInvestment),
                style: const TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.darkTextSecondary.withValues(alpha: 0.5), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Charges and taxes will be extra as per broker.',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    final isValid = _selectedStock != null && _totalInvestment > 0;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isValid ? _handleAdd : null,
        icon: const Icon(Icons.add_circle),
        label: const Text(
          'Add to Portfolio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navActiveColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.navActiveColor.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
