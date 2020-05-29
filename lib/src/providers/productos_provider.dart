
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:formvalidation/src/models/producto_model.dart';

class ProductoProvider {
  final String _url = 'https://app-flutter-3d220.firebaseio.com';

  //CREATE
  Future<bool> create( ProductoModel producto) async {
    final url = '$_url/produtos.json';
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;
  }

  //INDEX
  Future<List<ProductoModel>> index () async {
    final url = '$_url/produtos.json';
    final resp = await http.get(url);
    final Map<String, dynamic>decodeData = json.decode(resp.body);
    final List<ProductoModel> listaProductos = new List();
    // print(decodeData);
    if(decodeData == null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      listaProductos.add(prodTemp);
      // print(prod);
    });
    // print(listaProductos);
    return listaProductos;
  }

  //DELETE
  Future<int> destroy (String id) async {
    final url = '$_url/produtos/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;

  }
}
