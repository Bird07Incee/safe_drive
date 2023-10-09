Map<String, dynamic> envConfig = {
  "dev": {
    "ENVIRONMENT_NAME": "dev",
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-dev",
    "BFF_INVENTORY_BASE_URL": "/mercury-inventory-manager-dev",
    "LINE_REDIRECT_URL": "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Kn9nO7oB&state=12345abcde&scope=profile%20openid%20email&nonce=09876xyz"
  },
  "qa": {
    "ENVIRONMENT_NAME": "qa",
    "LIFF_ID": "1661164508-Wdam3RjL",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-qa",
    "BFF_INVENTORY_BASE_URL": "/mercury-inventory-manager-qa",
    "LINE_REDIRECT_URL": "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Wdam3RjL&scope=profile%20openid%20email"
  },
  "int": {
    "ENVIRONMENT_NAME": "int",
    //TODO: config redirect url int
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-int",
    "BFF_INVENTORY_BASE_URL": "/mercury-inventory-manager-int",
    //TODO: config redirect url int
    "LINE_REDIRECT_URL": "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Kn9nO7oB&state=12345abcde&scope=profile%20openid%20email&nonce=09876xyz"
  },
  "uat": {
    "ENVIRONMENT_NAME": "uat",
    //TODO: config redirect url uat
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-uat",
    "BFF_INVENTORY_BASE_URL": "/mercury-inventory-manager-uat",
    //TODO: config redirect url uat
    "LINE_REDIRECT_URL": "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Kn9nO7oB&state=12345abcde&scope=profile%20openid%20email&nonce=09876xyz"
  },
  "prod": {
    "ENVIRONMENT_NAME": "prod",
    //TODO: config redirect url prod
    "LIFF_ID": "1661164508-Kn9nO7oB",
    "BFF_BASE_URL": "https://api.marketplace.ksauto.net",
    "BFF_SOCIAL_BASE_URL": "/mercury-social-prod",
    "BFF_INVENTORY_BASE_URL": "/mercury-inventory-manager-prod",
    //TODO: config redirect url prod
    "LINE_REDIRECT_URL": "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=1661164508&redirect_uri=https%3A%2F%2Fliff.line.me%2F1661164508-Kn9nO7oB&state=12345abcde&scope=profile%20openid%20email&nonce=09876xyz"
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
        var jsonEnv = getEnv();
        return jsonEnv[key];
      } else {
        return config[key];
      }
    } catch (e) {
      return '';
    }
  }
}
