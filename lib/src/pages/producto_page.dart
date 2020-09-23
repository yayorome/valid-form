import 'package:flutter/material.dart';
import 'package:formbloc/src/model/product_model.dart';
import 'package:formbloc/src/providers/product_provider.dart';
import 'package:formbloc/src/utils/utils.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  ProductModel productModel = new ProductModel();
  ProductProvider productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    final ProductModel data = ModalRoute.of(context).settings.arguments;

    if (data != null) {
      productModel = data;
    }

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
                _isAvailable(),
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
      initialValue: productModel.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (newValue) => productModel.title = newValue,
      validator: (value) {
        return value.length < 3 ? 'Ingrese nombre de producto' : null;
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: productModel.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (newValue) => productModel.value = double.parse(newValue),
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

  Widget _isAvailable() {
    return SwitchListTile(
      value: productModel.availability,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        productModel.availability = value;
      }),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    productProvider.createProduct(productModel);
  }
}
