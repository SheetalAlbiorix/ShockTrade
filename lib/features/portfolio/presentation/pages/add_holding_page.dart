import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:intl/intl.dart';

class AddHoldingPage extends ConsumerStatefulWidget {
  const AddHoldingPage({super.key});

  @override
  ConsumerState<AddHoldingPage> createState() => _AddHoldingPageState();
}

class _AddHoldingPageState extends ConsumerState<AddHoldingPage> {
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController(text: '0.00');
  DateTime _selectedDate = DateTime.now();
  String _selectedExchange = 'NSE';
  
  // Mock selected stock
  final String _stockName = 'HDFC Bank Limited';
  final String _stockSymbol = 'HDFCBANK';
  final double _currentPrice = 1650.45;
  final double _priceChange = 0.45;

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
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildSelectedStockCard(currencyFormat),
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: const TextField(
        style: TextStyle(color: AppColors.darkTextPrimary),
        decoration: InputDecoration(
          hintText: 'e.g. HDFC Bank, RELIANCE',
          hintStyle: TextStyle(color: AppColors.darkTextSecondary, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: AppColors.darkTextSecondary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSelectedStockCard(NumberFormat currencyFormat) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navActiveColor.withOpacity(0.5), width: 1),
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
            child: const Icon(Icons.business, color: AppColors.darkBackground),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _stockName,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$_stockSymbol • $_selectedExchange',
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
                currencyFormat.format(_currentPrice),
                style: const TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '+$_priceChange%',
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
              Icon(Icons.info_outline, color: AppColors.darkTextSecondary.withOpacity(0.5), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Charges and taxes will be extra as per broker.',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary.withOpacity(0.5),
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
    final isValid = _totalInvestment > 0;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isValid ? () => context.pop() : null,
        icon: const Icon(Icons.add_circle),
        label: const Text(
          'Add to Portfolio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navActiveColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.navActiveColor.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
