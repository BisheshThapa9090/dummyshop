class AppConstants {
  static const String appName = 'PixelMart';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String onboardingSeenKey = 'onboardingSeen';
  static const String themeKey = 'themeMode';

  // Pagination
  static const int defaultLimit = 20;
  static const int defaultSkip = 0;

  // Form Validation
  static const int minPasswordLength = 6;
  static const int minTitleLength = 3;
  static const int maxTitleLength = 100;
  static const int minBodyLength = 10;
  static const int maxBodyLength = 500;
  static const int maxCommentLength = 200;
}