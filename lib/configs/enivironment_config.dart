Map<String, dynamic> envConfig = {
  "dev": {
    "ENVIRONMENT_NAME": "dev",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-dev"
  },
  "qa": {
    "ENVIRONMENT_NAME": "qa",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-qa"
  },
  "int": {
    "ENVIRONMENT_NAME": "int",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-int"
  },
  "uat": {
    "ENVIRONMENT_NAME": "uat",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-uat"
  },
  "prod": {
    "ENVIRONMENT_NAME": "prod",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-prod"
  },
};

class Environment {
  Environment._internal();
  static final Environment _instance = Environment._internal();
  factory Environment() => _instance;

  final Map<String, dynamic> config = {};

  Map<String, dynamic> getEnv() {
    const setEnv = String.fromEnvironment('SET_ENV', defaultValue: 'dev');
    String env = setEnv;
    config.addAll(envConfig[env]);
    return config;
  }

  String getValue(String key) {
    try {
      if (config.isEmpty || config == {}) {
        print('config is empty');
        var jsonEnv = getEnv();
        print('return k,v ($key, ${jsonEnv[key]})');
        return jsonEnv[key];
      } else {
        print('return k,v ($key, ${config[key]})');
        return config[key];
      }
    } catch (e) {
      print('exception getValue: $key , e: $e');
      return '';
    }
  }
}
