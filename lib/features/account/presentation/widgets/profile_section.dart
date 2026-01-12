import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface, // Using darkSurface as per AppColors
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDBBAnWS59jUq6K0aHWcx6o0E9fBtWrJgKcH8ev2pUQiZtldm9WqFkLKIDcmfrIXnsnGtS1hnA2MGDa5nEPM-lBVoV5qIBsveCNT-caZSc3e5vHNPXOJESP6Osj6GkObFY405_7Uevh00kAlREqoTqYNS_IOQF0wO_0spho5Nkgpp2wgm4SAyuASIU4xhfJd3vwI4QIkZj0oqABUPTu-vhSY9yYH59L6hIAMoxvYWWs-fttdcpK-Jiv_2HmyrneVemzbG2XJsSjQlA',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.darkSurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Flexible(
                      child: Text(
                        'Aditya Sharma',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
                      ),
                      child: const Text(
                        'KYC Verified',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'aditya.sharma@example.com',
                  style: TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit_square, color: AppColors.darkTextSecondary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
