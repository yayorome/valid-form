import 'package:flutter/material.dart';
import 'package:formbloc/src/model/product_model.dart';
import 'package:formbloc/src/providers/product_provider.dart';
import 'package:formbloc/src/providers/provider.dart';

class HomePage extends StatelessWidget {
  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: _showList(),
      floatingActionButton: _createButton(context),
    );
  }

  _createButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, 'product'));
  }

  Widget _showList() {
    return FutureBuilder(
      future: productProvider.getProducts(),
      builder: (context, AsyncSnapshot<List<ProductModel>> snapsot) {
        if (snapsot.hasData) {
          return ListView.builder(
            itemCount: snapsot.data.length,
            itemBuilder: (context, index) =>
                _createItem(context, snapsot.data[index]),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return ListTile(
      title: Text('${product.title} - ${product.value}'),
      subtitle: Text(product.id),
      onTap: () => Navigator.pushNamed(context, 'product', arguments: product),
    );
  }
}
