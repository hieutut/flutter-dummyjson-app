enum Environment {
  DEV,
  STAGING,
  PROD;
}

extension EnvironmentExt on Environment {
  String get baseUrl => switch (this) {
        Environment.DEV => 'https://dummyjson.com',
        Environment.STAGING => 'https://dummyjson.com',
        Environment.PROD => 'https://dummyjson.com',
      };

  String get clientKey => switch (this) {
        Environment.DEV => '',
        Environment.STAGING => '',
        Environment.PROD => '',
      };
  
  String get secretKey => '';
}
