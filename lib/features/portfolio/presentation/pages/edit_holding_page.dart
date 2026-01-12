import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/application/providers/portfolio_provider.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:intl/intl.dart';

class EditHoldingPage extends ConsumerStatefulWidget {
  final String holdingId;
  const EditHoldingPage({super.key, required this.holdingId});

  @override
  ConsumerState<EditHoldingPage> createState() => _EditHoldingPageState();
}

class _EditHoldingPageState extends ConsumerState<EditHoldingPage> {
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late Holding _holding;
  late DateTime _selectedDate;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final holdings = ref.watch(holdingsProvider);
      _holding = holdings.firstWhere((h) => h.id == widget.holdingId);
      _quantityController = TextEditingController(text: _holding.quantity.toInt().toString());
      _priceController = TextEditingController(text: _holding.avgPrice.toStringAsFixed(2));
      _selectedDate = _holding.purchaseDate;
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  double get _totalInvestment {
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    return qty * price;
  }

  void _handleSave() {
    final qty = double.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    
    if (qty <= 0 || price <= 0) return;

    ref.read(holdingsProvider.notifier).updateHolding(_holding.id, qty, price, _selectedDate);
    context.pop();
  }

  void _handleDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        title: const Text('Delete Holding', style: TextStyle(color: AppColors.darkTextPrimary)),
        content: Text('Are you sure you want to delete ${_holding.name} from your portfolio?', 
          style: const TextStyle(color: AppColors.darkTextSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.darkTextSecondary)),
          ),
          TextButton(
            onPressed: () {
              ref.read(holdingsProvider.notifier).deleteHolding(_holding.id);
              Navigator.pop(context); // Close dialog
              context.pop(); // Go back to portfolio
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.bearishRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

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
          'Edit Holding',
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.bearishRed),
            onPressed: _handleDelete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStockHero(currencyFormat),
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
            const SizedBox(height: 40),
            _buildSummaryCard(currencyFormat),
            const SizedBox(height: 40),
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStockHero(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.network(
              _holding.logoUrl,
              errorBuilder: (_, __, ___) => const Icon(Icons.business, color: Colors.blueGrey, size: 32),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _holding.name,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _holding.symbol,
                  style: const TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormat.format(_holding.currentPrice),
                style: const TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Current Price',
                style: TextStyle(
                  color: AppColors.darkTextSecondary.withValues(alpha: 0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
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
      },
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

  Widget _buildSummaryCard(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'New Investment Value',
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
    );
  }

  Widget _buildSaveButton() {
    final isValid = _totalInvestment > 0;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid ? _handleSave : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navActiveColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.navActiveColor.withValues(alpha: 0.3),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
