import 'package:flutter/cupertino.dart';
import 'package:front_end/src/View/pages/Login/login_page.dart';
import 'package:front_end/src/View/pages/Login/home_test.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomeTest(), //Poner SplashScreen
    //'/': (BuildContext context) => SplashScreen(),
  };
}
