import 'package:flutter/material.dart';
import 'package:formbloc/src/pages/home_page.dart';
import 'package:formbloc/src/pages/login_page.dart';
import 'package:formbloc/src/pages/producto_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginPage(),
    'home': (BuildContext context) => HomePage(),
    'product': (BuildContext context) => ProductPage(),
  };
}
