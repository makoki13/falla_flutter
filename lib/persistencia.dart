import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class DBlocal {
  String _texto;

  Future getRegistro(String clave) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _texto = (prefs.getString(clave) ?? '');
  }

  String getValor() { return _texto; }

  putRegistro (String clave, String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Guardando valor $valor');
    prefs.setString(clave, valor);
  }
}