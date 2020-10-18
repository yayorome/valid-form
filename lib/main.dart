import 'package:flutter/material.dart';
import 'package:formbloc/src/providers/provider.dart';
import 'package:formbloc/src/routes/routes.dart';
import 'package:formbloc/src/utils/user_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPrefs();
  await prefs.initPrefs();
  runApp(MyApp());
}

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
