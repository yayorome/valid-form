import 'package:flutter/material.dart';
import 'package:formbloc/src/providers/auth_provider.dart';
import 'package:formbloc/src/providers/provider.dart';
import 'package:formbloc/src/utils/utils.dart';

class RegisterPage extends StatelessWidget {
  final authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _createBg(context),
        _createForm(context),
      ],
    ));
  }

  Widget _createBg(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bgColor = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ])),
    );

    final circle = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    final icon = Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 100,
          ),
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Text('Yayo App', style: TextStyle(color: Colors.white, fontSize: 25))
        ],
      ),
    );

    return Stack(
      children: [
        bgColor,
        Positioned(top: 90, left: 30, child: circle),
        Positioned(top: -40, left: -30, child: circle),
        Positioned(bottom: -50, right: -10, child: circle),
        Positioned(bottom: 120, right: 20, child: circle),
        Positioned(bottom: -50, left: -20, child: circle),
        icon
      ],
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50),
            margin: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0.0, 5),
                      spreadRadius: 3),
                ]),
            child: Column(
              children: [
                Text(
                  'Crear Cuenta',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 60),
                _createEmailField(bloc),
                SizedBox(height: 30),
                _createPassField(bloc),
                SizedBox(height: 30),
                _createButton(bloc)
              ],
            ),
          ),
          FlatButton(
              child: Text('Si ya tienes cuenta, ve a Login'),
              onPressed: () => Navigator.pushReplacementNamed(context, '/')),
          SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget _createEmailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePass,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text('Crear Cuenta'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed:
                  snapshot.hasData ? () => _register(bloc, context) : null);
        });
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final response = await authProvider.createUser(bloc.email, bloc.pass);
    if (response['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, response['info']);
    }
  }
}
