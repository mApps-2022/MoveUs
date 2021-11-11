class EnvLoadUtil {
  static final EnvLoadUtil _singleton = EnvLoadUtil._internal();
  Map<String, String> envEndPoints = {};
  factory EnvLoadUtil() {
    return _singleton;
  }
  get env {
    return envEndPoints;
  }

  loadEnv(Map<String, String> value) {
    envEndPoints = value;
  }

  EnvLoadUtil._internal();
}
