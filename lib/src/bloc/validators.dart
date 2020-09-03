import 'dart:async';

class Validators {
  final validatePass = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 6) {
        sink.add(data);
      } else {
        sink.addError('La longitud del password es incorrecta');
      }
    },
  );

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data);
      } else {
        sink.addError('Email incorrecto');
      }
    },
  );
}
