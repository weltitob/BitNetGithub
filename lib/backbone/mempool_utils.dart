class AppUtils {
  static final Map<String, dynamic> featureActivation = {
    "mainnet": {
      "rbf": 399701,
      "segwit": 477120,
      "taproot": 709632,
    },
    "testnet": {
      "rbf": 720255,
      "segwit": 872730,
      "taproot": 2032291,
    },
    "signet": {
      "rbf": 0,
      "segwit": 0,
      "taproot": 0,
    },
  };

  static bool isFeatureActive(String network, int height, String feature) {
    final activationHeight = featureActivation[network ?? 'mainnet']?[feature];
    if (activationHeight != null) {
      return height >= activationHeight;
    } else {
      return false;
    }
  }

  // Private constructor
  AppUtils._private();

  // Private instance of the Singleton class
  static final AppUtils _instance = AppUtils._private();

  // Public method to access the Singleton instance
  static AppUtils get instance => _instance;

  // Other methods and properties of the Singleton class
  void doSomething() {
    print("Singleton instance is doing something.");
  }
}
