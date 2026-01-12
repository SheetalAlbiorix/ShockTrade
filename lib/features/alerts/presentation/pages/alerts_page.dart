import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/alerts/presentation/widgets/alert_card.dart';
import 'package:shock_app/features/alerts/presentation/widgets/alert_segmented_control.dart';
import 'package:shock_app/features/alerts/presentation/widgets/create_alert_sheet.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // background-dark from HTML
      body: Stack(
        children: [
          // Ambient Background Gradients
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue.withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E3A8A).withOpacity(0.15), // blue-900 like
              ),
            ),
          ),
          // Blur Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(color: Colors.transparent),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header (ShockTrade / Price Alerts)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'SHOCKTRADE',
                                style: TextStyle(
                                  color: AppColors.primaryBlue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0, // tracking-widest
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Price Alerts',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Plus Button
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const CreateAlertSheet(),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryBlue.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: Colors.grey[500], size: 20),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Search alerts...',
                            style: TextStyle(
                              color: Colors.grey, // placeholder color
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Active/History Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: AlertSegmentedControl(
                    selectedIndex: _selectedTabIndex,
                    onValueChanged: (index) {
                      setState(() => _selectedTabIndex = index);
                    },
                  ),
                ),
                
                // Section Title (Active Alerts (4))
                if (_selectedTabIndex == 0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: Row(
                      children: const [
                        Text(
                          'ACTIVE ALERTS (4)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                // List
                Expanded(
                  child: _selectedTabIndex == 0
                      ? _buildActiveList()
                      : _buildHistoryList(),
                ),
              ],
            ),
          ),
          

        ],
      ),
    );
  }

  // Extensions for blur usually need a real widget wrapping or dart:ui.
  // Implementing a simple helper inline or assuming user has one.
  // Actually, standard ImageFilter.blur requires BackdropFilter or similar.
  // The '..applyBlur' syntax above implies a user-extension or is pseudo-code I need to fix.
  // I will use standard Flutter BackdropFilter for "glass" and simple box decoration for the ambient blobs.
  // Wait, I can't simple use ..applyBlur on a Container.
  // I will correct the code below to use correct standard widgets.


  Widget _buildActiveList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      children: [
        const AlertCard.active(
          symbol: 'TATASTEEL',
          exchange: 'NSE',
          sector: 'Metal',
          currentPrice: '₹118.50',
          priceChange: '+1.2%',
          isPriceUp: true,
          conditionText: 'Above ₹125.00',
          isSwitchOn: true,
          logoUrl: 'https://logo.clearbit.com/tatasteel.com', 
        ),
        const SizedBox(height: 12),
        const AlertCard.active(
          symbol: 'INFY',
          exchange: 'NSE',
          sector: 'IT',
          currentPrice: '₹1,438.00',
          priceChange: '+0.45%',
          isPriceUp: true,
          conditionText: 'Below ₹1,400.00',
          isSwitchOn: true,
          logoUrl: 'https://logo.clearbit.com/infosys.com',
        ),
        const SizedBox(height: 12),
        const AlertCard.active(
          symbol: 'HDFCBANK',
          exchange: 'NSE',
          sector: 'Bank',
          currentPrice: '₹1,650.00',
          priceChange: '-0.2%',
          isPriceUp: false,
          conditionText: 'Crossing Above ₹1,700.00',
          isSwitchOn: false,
          logoUrl: 'https://logo.clearbit.com/hdfcbank.com',
        ),
        const SizedBox(height: 12),
        const AlertCard.active(
          symbol: 'RELIANCE',
          exchange: 'NSE',
          sector: 'Energy',
          currentPrice: '₹2,450.00',
          priceChange: '+1.20%',
          isPriceUp: true,
          conditionText: 'Crossing Above ₹2,500.00',
          isSwitchOn: true,
          logoUrl: 'https://logo.clearbit.com/ril.com',
        ),
        const SizedBox(height: 12),
         const AlertCard.active(
          symbol: 'TCS',
          exchange: 'NSE',
          sector: 'IT',
          currentPrice: '₹3,400.00',
          priceChange: '-0.54%',
          isPriceUp: false,
          conditionText: 'Crossing Below ₹3,350.00',
          isSwitchOn: true,
          logoUrl: 'https://logo.clearbit.com/tcs.com',
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: const [
        // From Screenshot 2
        AlertCard.history(
          symbol: 'RELIANCE',
          exchange: 'NSE',
          status: AlertStatus.triggered,
          conditionText: 'Price crossed above ₹2,500.00',
          triggeredAt: 'Triggered at ₹2,504.20 on 24 Oct, 10:15 AM',
        ),
        SizedBox(height: 12),
        AlertCard.history(
          symbol: 'TCS',
          exchange: 'NSE',
          status: AlertStatus.expired,
          conditionText: 'Price below ₹3,350.00',
          triggeredAt: 'Alert expired on 22 Oct, 03:30 PM',
        ),
        SizedBox(height: 12),
        AlertCard.history(
          symbol: 'HDFCBANK',
          exchange: 'NSE',
          status: AlertStatus.triggered,
          conditionText: 'Price crossed below ₹1,520.00',
          triggeredAt: 'Triggered at ₹1,518.75 on 20 Oct, 01:42 PM',
        ),
        SizedBox(height: 12),
        AlertCard.history(
          symbol: 'TATAMOTORS',
          exchange: 'BSE',
          status: AlertStatus.triggered,
          conditionText: 'Daily move > 5%',
          triggeredAt: 'Triggered at ₹652.40 on 18 Oct, 11:05 AM',
        ),
        SizedBox(height: 24),
        Center(
          child: Text(
            'Showing last 30 days of history',
            style: TextStyle(color: AppColors.darkTextSecondary, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
