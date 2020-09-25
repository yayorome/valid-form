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
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direction) => productProvider.deleteProduct(product.id),
        child: Card(
          child: Column(
            children: [
              (product.photoUrl == null)
                  ? Image(image: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      image: NetworkImage(product.photoUrl),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text('${product.title} - ${product.value}'),
                subtitle: Text(product.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'product', arguments: product),
              ),
            ],
          ),
        ));
  }
}
