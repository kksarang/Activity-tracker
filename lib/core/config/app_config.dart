enum AppEnvironment { dev, staging, prod }

class AppConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final String appName;
  final bool enableLogs;

  const AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.appName,
    required this.enableLogs,
  });

  static late AppConfig _instance;

  static AppConfig get instance => _instance;

  static void initialize({
    required AppEnvironment environment,
    required String apiBaseUrl,
    required String appName,
    bool enableLogs = false,
  }) {
    _instance = AppConfig._(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      appName: appName,
      enableLogs: enableLogs,
    );
  }

  // Example factory for Dev
  factory AppConfig.dev() {
    return AppConfig._(
      environment: AppEnvironment.dev,
      apiBaseUrl: 'https://dev-api.activitytracker.com',
      appName: 'Activity (Dev)',
      enableLogs: true,
    );
  }

  // Example factory for Prod
  factory AppConfig.prod() {
    return AppConfig._(
      environment: AppEnvironment.prod,
      apiBaseUrl: 'https://api.activitytracker.com',
      appName: 'Activity Tracker',
      enableLogs: false,
    );
  }
}
