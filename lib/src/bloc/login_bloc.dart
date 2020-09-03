import 'dart:async';

import 'package:formbloc/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  // Recuperar datos
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passStream =>
      _passController.stream.transform(validatePass);

  // Combinar streams
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passStream, (e, p) => true);

  // Insertar valores al stream
  Function(String) get email => _emailController.sink.add;
  Function(String) get pass => _passController.sink.add;

  dispose() {
    _emailController?.close();
    _passController?.close();
  }
}
