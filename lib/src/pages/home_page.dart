import 'package:flutter/material.dart';
import 'package:formbloc/src/providers/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        children: [
          Text('email: ${bloc.email}'),
          Text('Pass: ${bloc.pass}'),
        ],
      ),
    );
  }
}
