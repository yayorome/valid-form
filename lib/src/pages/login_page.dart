import 'package:flutter/material.dart';
import 'package:formbloc/src/providers/provider.dart';

class LoginPage extends StatelessWidget {
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
                  'Ingreso',
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
          Text('Olvidaste tu contrseña?'),
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
            onChanged: bloc.email,
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
            onChanged: bloc.pass,
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
                child: Text('Ingresar'),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              elevation: 0,
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: snapshot.hasData ? () {} : null);
        });
  }
}
