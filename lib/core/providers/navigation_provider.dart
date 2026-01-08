import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for managing the current tab index
final currentTabIndexProvider = StateProvider<int>((ref) => 0);
