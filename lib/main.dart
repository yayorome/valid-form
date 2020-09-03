import 'package:flutter/material.dart';
import 'package:formbloc/src/providers/provider.dart';
import 'package:formbloc/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      initialRoute: '/',
      routes: getAppRoutes(),
      theme: ThemeData(primaryColor: Colors.deepPurple),
    ));
  }
}
