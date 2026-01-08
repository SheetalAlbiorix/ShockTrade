import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';

/// Provider for portfolio summary
final portfolioSummaryProvider = Provider<PortfolioSummary>((ref) {
  return const PortfolioSummary(
    totalValue: 123456.78,
    invested: 100000.00,
    current: 123456.00,
    gain: 23456.00,
    dailyChangePercent: 8.9,
    isPositive: true,
  );
});

/// Provider for asset distribution
final assetDistributionProvider = Provider<List<AssetCategory>>((ref) {
  return [
    AssetCategory(
      name: 'Tech',
      value: 55000,
      percentage: 45,
      color: AppColors.navActiveColor,
    ),
    AssetCategory(
      name: 'Healthcare',
      value: 30000,
      percentage: 25,
      color: AppColors.chartPurple,
    ),
    AssetCategory(
      name: 'Finance',
      value: 24000,
      percentage: 20,
      color: AppColors.chartOrange,
    ),
    AssetCategory(
      name: 'Energy',
      value: 12000,
      percentage: 10,
      color: AppColors.bullishGreen,
    ),
  ];
});

/// Provider for holdings list
final holdingsProvider = Provider<List<Holding>>((ref) {
  return [
    Holding.create(
      symbol: 'AAPL',
      name: 'Apple Inc.',
      investedValue: 15000.00,
      shares: 75,
      changePercent: 2.50,
    ),
    Holding.create(
      symbol: 'GOOGL',
      name: 'Alphabet Inc.',
      investedValue: 25000.00,
      shares: 20,
      changePercent: -1.20,
    ),
    Holding.create(
      symbol: 'MSFT',
      name: 'Microsoft Corp.',
      investedValue: 10000.00,
      shares: 30,
      changePercent: 0.80,
    ),
    Holding.create(
      symbol: 'AMZN',
      name: 'Amazon.com Inc.',
      investedValue: 30000.00,
      shares: 25,
      changePercent: 4.10,
    ),
    Holding.create(
      symbol: 'TSLA',
      name: 'Tesla Inc.',
      investedValue: 12000.00,
      shares: 5,
      changePercent: -3.50,
    ),
    Holding.create(
      symbol: 'NVDA',
      name: 'NVIDIA Corp.',
      investedValue: 8000.00,
      shares: 10,
      changePercent: 1.90,
    ),
  ];
});

/// Provider for loading state
final portfolioLoadingProvider = StateProvider<bool>((ref) => false);
