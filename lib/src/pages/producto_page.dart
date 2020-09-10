import 'package:flutter/material.dart';
import 'package:formbloc/src/utils/utils.dart';

class ProductPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _createName(),
                _createPrice(),
                SizedBox(
                  height: 10,
                ),
                _createButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      validator: (value) {
        return value.length > 3 ? 'Ingrese nombre de producto' : null;
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      validator: (value) {
        return isNumeric(value) ? null : 'Solo numeros';
      },
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.deepPurple,
        textColor: Colors.white,
        onPressed: _submit,
        icon: Icon(Icons.save),
        label: Text('Guardar'));
  }

  void _submit() {
    formKey.currentState.validate();
  }
}
