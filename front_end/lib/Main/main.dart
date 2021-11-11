import 'package:flutter/material.dart';
import 'package:front_end/src/View/utils/env_load_util.dart';
import 'package:front_end/src/View/utils/env_util.dart';
import 'package:front_end/src/View/widgets/app.dart';

Future<void> main() async {
  final envLoadUtil = EnvLoadUtil();
  Map<String, String> env = await loadEnvFile("assets/env/.env_dev");
  envLoadUtil.loadEnv(env);
  runApp(MyApp(env));
}
