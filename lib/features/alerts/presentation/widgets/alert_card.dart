import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

enum AlertStatus { active, triggered, expired }

class AlertCard extends StatelessWidget {
  final String symbol;
  final String exchange;
  final String sector; // e.g., Metal, IT
  final String currentPrice;
  final String priceChange;
  final bool isPriceUp;
  final String conditionText; // e.g., "Above ₹125.00", "Crossing Above ..."
  final bool isActiveTab; // To determine layout (Switch vs Reactivate)
  
  // Active Tab specific
  final bool isSwitchOn;
  final ValueChanged<bool>? onSwitchChanged;

  // History Tab specific
  final AlertStatus status; // triggered, expired
  final String? triggeredAt; // "Triggered on..."
  final VoidCallback? onReactivate;

  // Logo placeholder
  final String? logoUrl; 

  const AlertCard.active({
    super.key,
    required this.symbol,
    required this.exchange,
    required this.sector,
    required this.currentPrice,
    required this.priceChange,
    required this.isPriceUp,
    required this.conditionText,
    required this.isSwitchOn,
    this.onSwitchChanged,
    this.logoUrl,
  })  : isActiveTab = true,
        status = AlertStatus.active,
        triggeredAt = null,
        onReactivate = null;

  const AlertCard.history({
    super.key,
    required this.symbol,
    required this.exchange,
    required this.status, 
    required this.conditionText,
    this.triggeredAt,
    this.onReactivate,
    this.logoUrl,
  })  : isActiveTab = false,
        sector = '', // Not shown in history card effectively in 2nd screen but let's see
        currentPrice = '',
        priceChange = '',
        isPriceUp = false,
        isSwitchOn = false,
        onSwitchChanged = null;

  @override
  Widget build(BuildContext context) {
    // Glass styling
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E232D).withOpacity(0.45),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            children: [
              // Top Row: Stock Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Logo
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                             BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
                          ]
                        ),
                        alignment: Alignment.center,
                        child: logoUrl != null
                            ? Image.network(logoUrl!, fit: BoxFit.contain)
                            : Text(symbol[0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                      ),
                      const SizedBox(width: 12),

                      // Name & Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbol,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isActiveTab
                                ? '$exchange • $sector'
                                : '$exchange • ${status.name.toUpperCase()}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Right Side: Price (Active) or Reactivate (History)
                  if (isActiveTab)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          currentPrice,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              isPriceUp ? Icons.trending_up : Icons.trending_down,
                              color: isPriceUp
                                  ? AppColors.accentGreen
                                  : AppColors.bearishRed,
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              priceChange,
                              style: TextStyle(
                                color: isPriceUp
                                    ? AppColors.accentGreen
                                    : AppColors.bearishRed,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    InkWell(
                      onTap: onReactivate,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.primaryBlue.withOpacity(0.2)),
                        ),
                        child: const Text(
                          'Reactivate',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Bottom Section: Trigger Condition
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Label and Value
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                           children: [
                              Icon(
                                isActiveTab ? Icons.notifications_active : (status == AlertStatus.triggered ? Icons.check_circle : Icons.notifications_off),
                                color: isActiveTab ? AppColors.primaryBlue : (status == AlertStatus.triggered ? AppColors.accentGreen : Colors.grey),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'TRIGGER CONDITION',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                           ],
                         ),
                         const SizedBox(height: 4),
                         // Construct Condition Text creatively
                         // E.g. "Crossing Above ₹2,500.00"
                         // We can assume conditionText has the full string.
                         // To recreate the specific "bold value" styling would require splitting the string, 
                         // but for now plain text is safe.
                         Text(
                           conditionText,
                           style: const TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         if (!isActiveTab && triggeredAt != null) ...[
                           const SizedBox(height: 2),
                           Text(
                             triggeredAt!,
                             style: TextStyle(
                                 color: Colors.grey[500], fontSize: 11),
                           ),
                         ]
                      ],
                    ),

                    // Switch
                    if (isActiveTab)
                      SizedBox(
                        height: 24,
                        child: Switch(
                          value: isSwitchOn,
                          onChanged: onSwitchChanged,
                          activeColor: AppColors.primaryBlue,
                          activeTrackColor: AppColors.primaryBlue.withOpacity(0.5),
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.white.withOpacity(0.1),
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
}

// Add successGreen if not in AppColors, or use bullishGreen
extension AppColorsExt on AppColors {
  static const Color successGreen = Color(0xFF22C55E);
}
