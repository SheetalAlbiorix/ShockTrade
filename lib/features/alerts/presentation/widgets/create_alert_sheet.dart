import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class CreateAlertSheet extends StatefulWidget {
  const CreateAlertSheet({super.key});

  @override
  State<CreateAlertSheet> createState() => _CreateAlertSheetState();
}

class _CreateAlertSheetState extends State<CreateAlertSheet> {
  int _selectedConditionIndex = 0; // 0: Price Above, 1: Price Below
  final String _priceValue = "1550";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF161B24), // Background from HTML
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
           BoxShadow(color: Colors.black45, blurRadius: 30, offset: Offset(0, -8))
        ],
        border: Border(
           top: BorderSide(color: Color(0x1AFFFFFF)), // white/10
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           // Drag Handle
           Padding(
             padding: const EdgeInsets.only(top: 12, bottom: 8),
             child: Container(
               height: 6,
               width: 48,
               decoration: BoxDecoration(
                 color: Colors.grey[600],
                 borderRadius: BorderRadius.circular(3),
               ),
             ),
           ),

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
             child: Column(
               children: [
                 // Header
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text(
                       'New Alert',
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     IconButton(
                       icon: const Icon(Icons.close, color: Colors.grey),
                       onPressed: () => Navigator.pop(context),
                     ),
                   ],
                 ),
                 const SizedBox(height: 16),

                 // Stock Info Card
                 Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     color: const Color(0xFF1E2430), // bg-[#1e2430]
                     borderRadius: BorderRadius.circular(12),
                     border: Border.all(color: Colors.white.withOpacity(0.05)),
                   ),
                   child: Row(
                     children: [
                       Container(
                         width: 32,
                         height: 32,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(4),
                         ),
                         padding: const EdgeInsets.all(2),
                         child: Image.network(
                           'https://lh3.googleusercontent.com/aida-public/AB6AXuA7XpATwIgvarL9izY_zF565dIU_cmL8r09GsoycPzMQKGOat3g1JmH2QrQ4raqbgKd8fI_WQT7z_ubzt9ABeAJWILmM8VA6un2mC5R6aakZAsEkj5hHZKNRjfqOA7mJR4G94lddN95t3953W8r3O6cWP-7w5WHo2LIirz5iCnEvuuisE6QBzrLKW6WSH8jREdCAAJu0gNvNsC1VZG3ZSwAq0fKw84Ewo_WAz1uW8KNPWFRpCa0mcTDK870ppGC-SAYjG_l-sMsSNw',
                           fit: BoxFit.contain,
                           errorBuilder: (_, __, ___) => const Icon(Icons.business, size: 16, color: Colors.black),
                         ),
                       ),
                       const SizedBox(width: 12),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text(
                               'HDFCBANK',
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 14,
                               ),
                             ),
                             Text(
                               '₹1,530.00 (+0.4%)',
                               style: TextStyle(
                                 color: Colors.grey[400],
                                 fontSize: 12,
                               ),
                             ),
                           ],
                         ),
                       ),
                       Icon(Icons.expand_more, color: Colors.grey[400]),
                     ],
                   ),
                 ),
                 const SizedBox(height: 24),

                 // Condition Grid
                 Row(
                   children: [
                     Expanded(
                       child: _buildConditionCard(
                         label: 'Price Above',
                         icon: Icons.trending_up,
                         isSelected: _selectedConditionIndex == 0,
                         onTap: () => setState(() => _selectedConditionIndex = 0),
                       ),
                     ),
                     const SizedBox(width: 12),
                     Expanded(
                       child: _buildConditionCard(
                         label: 'Price Below',
                         icon: Icons.trending_down,
                         isSelected: _selectedConditionIndex == 1,
                         onTap: () => setState(() => _selectedConditionIndex = 1),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 32),

                 // Target Price Input
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text(
                       'TARGET PRICE',
                       style: TextStyle(
                         color: AppColors.darkTextSecondary,
                         fontSize: 12,
                         fontWeight: FontWeight.w600,
                         letterSpacing: 1.0,
                       ),
                     ),
                     const SizedBox(height: 12),
               Container(
                 height: 72,
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(color: Colors.white.withOpacity(0.1)),
                 ),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     const Text(
                       '₹',
                       style: TextStyle(
                         color: AppColors.primaryBlue,
                         fontSize: 32,
                         fontWeight: FontWeight.w600,
                       ),
                     ),

                     const SizedBox(width: 8),

                     Expanded(
                       child: TextFormField(
                         initialValue: _priceValue,
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 32,
                           fontWeight: FontWeight.bold,
                         ),
                         cursorColor: AppColors.primaryBlue,
                         keyboardType: TextInputType.number,
                         textAlignVertical: TextAlignVertical.center,
                         decoration: const InputDecoration(
                           border: InputBorder.none,
                           isDense: true,
                           contentPadding: EdgeInsets.zero,
                           hintText: '1550',
                           hintStyle: TextStyle(
                             color: Colors.white38,
                             fontSize: 32,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               ),

               const SizedBox(height: 12),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text(
                           'LTP: ₹1,530.00',
                           style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11, fontWeight: FontWeight.w500), // gray-400
                         ),
                         const Text(
                           '+1.31% from current',
                           style: TextStyle(color: AppColors.bullishGreen, fontSize: 11, fontWeight: FontWeight.w500),
                         ),
                       ],
                     ),
                   ],
                 ),
                 const SizedBox(height: 32),

                 // Create Button
                 SizedBox(
                   width: double.infinity,
                   height: 60, // Taller button from HTML design
                   child: ElevatedButton(
                     onPressed: () => Navigator.pop(context),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.primaryBlue,
                       foregroundColor: Colors.white,
                       elevation: 8,
                       shadowColor: AppColors.primaryBlue.withOpacity(0.3),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16),
                       ),
                       textStyle: const TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     child: const Text('Create Alert'),
                   ),
                 ),
                 SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
               ],
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildConditionCard({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withOpacity(0.2) : const Color(0xFF1E2430),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
