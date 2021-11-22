import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:front_end/src/Logic/bloc/ProviderBloc.dart';
import 'package:front_end/src/View/routes/routes.dart';

class MyApp extends StatefulWidget {
  final Map<String, String> env;
  MyApp(this.env);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      key: UniqueKey(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: 'register',
        routes: getAppRoutes(),
      ),
    );
  }
}
