import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
// import 'package:formvalidation/src/bloc/provider.dart';

class HomePage extends StatelessWidget {

  final productoProvider = new ProductoProvider();

  @override
  Widget build(BuildContext context) {

    // final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _index(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _index(){
    return FutureBuilder(
      future: productoProvider.index(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItems(productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  Widget _crearItems (ProductoModel producto){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      color: Colors.redAccent,
      child: Icon(Icons.delete, color: Colors.white),
    ),
    secondaryBackground: Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.orangeAccent,
      child: Icon(Icons.edit, color: Colors.white),
    ),
      onDismissed: (direccion){
        productoProvider.destroy(producto.id);
      },
      child: ListTile(
        title: Text("${producto.titulo} - ${producto.valor}"),
        subtitle: Text("${producto.id}"),
      ),
    );
  }
  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child:Icon(Icons.add),
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      backgroundColor: Colors.deepPurple,
    );
  }
}