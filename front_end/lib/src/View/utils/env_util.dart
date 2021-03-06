import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<Map<String, String>> loadEnvFile(String path) async {
  DotEnv instance = DotEnv();
  await instance.load(fileName: path);
  return instance.env;
}
