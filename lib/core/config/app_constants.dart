/// App-wide numeric and configuration constants
class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.example.com';
  static const int apiTimeoutSeconds = 30;
  static const int maxRetryAttempts = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Duration
  static const int cacheExpiryMinutes = 5;
  static const int stockPriceCacheSeconds = 10;

  // Animation Durations (milliseconds)
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardElevation = 2.0;

  // Stock Market
  static const int maxWatchlistItems = 50;
  static const int maxPortfolioItems = 100;
  static const int maxAlerts = 20;

  // Chart
  static const int defaultChartDataPoints = 100;
  static const int maxChartDataPoints = 500;

  // Refresh Intervals (seconds)
  static const int stockPriceRefreshInterval = 5;
  static const int portfolioRefreshInterval = 30;
  static const int newsRefreshInterval = 300;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Number Formatting
  static const int priceDecimalPlaces = 2;
  static const int percentageDecimalPlaces = 2;
  static const int volumeDecimalPlaces = 0;

  // WebSocket
  static const int websocketReconnectDelay = 5;
  static const int websocketPingInterval = 30;

  // Local Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyCurrency = 'currency';
  static const String keyWatchlists = 'watchlists';
  static const String keyPortfolio = 'portfolio';

  // Feature Flags
  static const bool enableAIChat = true;
  static const bool enablePushNotifications = true;
  static const bool enableBiometricAuth = true;
  static const bool enableDarkMode = true;

  // Currency Symbols
  static const String currencyUSD = '\$';
  static const String currencyINR = '₹';
  static const String currencyEUR = '€';
  static const String currencyGBP = '£';

  // Date Formats
  static const String dateFormatShort = 'MMM dd, yyyy';
  static const String dateFormatLong = 'MMMM dd, yyyy';
  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const String timeFormat = 'hh:mm a';
}
