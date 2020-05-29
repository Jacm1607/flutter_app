import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/providers/productos_provider.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductoProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.photo_size_select_actual), onPressed: null),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: null),
        ],
      ),
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            )
          )
        )
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto'
      ),
      validator: (value){
        if( value.length < 3) {
          return 'Ingrese el nombre completo del producto';
        } else {
          return null;
        }
      },
      onSaved: (value) => producto.titulo=value,
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Precio'
      ),
      validator: (value){
        if ( utils.isNumeric(value) ){
          return null;
        } else {
          return 'Ingrese solo números sonso';
        }
      },
      onSaved: (value)=>producto.valor=double.parse(value),
    );
  }

  Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save ),
      onPressed: _submit,
      label: Text('Guardar'),
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible,
      activeColor: Colors.deepPurple,
      activeTrackColor: Colors.deepPurple,
      onChanged: (value)=>setState((){
        producto.disponible=value;
      }),
      title: Text("Disponible"),
    );
  }

  void _submit(){
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    print("ok");
    print(producto.titulo);
    print(producto.valor);
    print(producto.disponible);
    productoProvider.create(producto);
  }
}