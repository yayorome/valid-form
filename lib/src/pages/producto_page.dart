import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formbloc/src/model/product_model.dart';
import 'package:formbloc/src/model/storage_result_model.dart';
import 'package:formbloc/src/providers/product_provider.dart';
import 'package:formbloc/src/providers/storage_provider.dart';
import 'package:formbloc/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProductModel productModel = new ProductModel();
  ProductProvider productProvider = new ProductProvider();
  StorageProvider storageProvider = new StorageProvider();
  bool _saving = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    final ProductModel data = ModalRoute.of(context).settings.arguments;

    if (data != null) {
      productModel = data;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePhoto,
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
                _showPhoto(),
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
        onPressed: (_saving) ? null : _submit,
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

  void _showSnackBar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    setState(() {
      _saving = true;
    });

    if (photo != null) {
      try {
        StorageResult result = await storageProvider.uploadImage(
            image: photo, title: productModel.title);

        if (result != null) {
          productModel.photoUrl = result.imageUrl;
        }
      } catch (exception) {
        _showSnackBar('Ocurrio un error favor de intentar de nuevo');
      }
    }

    if (productModel.id == null) {
      productProvider.createProduct(productModel);
    } else {
      productProvider.editProduct(productModel);
    }

    _showSnackBar('Registro Guardado');
    setState(() {
      _saving = false;
    });

    Navigator.pop(context);
  }

  Widget _showPhoto() {
    if (productModel.photoUrl != null) {
      return FadeInImage(
          image: NetworkImage(productModel.photoUrl),
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          height: 300,
          fit: BoxFit.contain);
    } else {
      if (photo != null) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/img/no-image.png');
    }
  }

  void _selectPhoto() {
    _processPhoto(ImageSource.gallery);
  }

  void _takePhoto() {
    _processPhoto(ImageSource.camera);
  }

  void _processPhoto(ImageSource source) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: source,
    );

    photo = File(pickedFile.path);

    if (photo != null) {
      productModel.photoUrl = null;
    }

    setState(() {});
  }
}
