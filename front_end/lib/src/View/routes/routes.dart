import 'package:flutter/cupertino.dart';
import 'package:front_end/src/View/pages/Login/login_app_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
  };
}
