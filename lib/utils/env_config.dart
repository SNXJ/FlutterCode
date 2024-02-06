class EnvConfig {
  bool inProd = const bool.fromEnvironment("dart.vm.product");

  static String getBaseUrl(String env) {
    if (env == "0") env = "test";
    switch (env) {
      case "prod":
        return "https://backend.shwoody.com/";
      default:
        return "https://backend-$env.shwoody.com/";
    }
  }
}

