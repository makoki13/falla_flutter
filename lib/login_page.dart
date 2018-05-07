import 'package:flutter/material.dart';
import 'root_page.dart';
import 'persistencia.dart';

class LoginPage extends StatefulWidget {

  bool hayUsuario;

  LoginPage(this.hayUsuario);

  @override
  State<StatefulWidget> createState() => new _LoginPageState(hayUsuario);
}

class _LoginPageState extends State<LoginPage> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String _usuario;
  bool hayUsuario;

  _LoginPageState(this.hayUsuario);

  void validateAndSave() {
    final form = formKey.currentState;


    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin();
    }
  }

  void _performLogin() async {
    // This is just a demo, so no actual login here.
    final form = formKey.currentState;
    DBlocal _db = new DBlocal();

    print ('Valor antes de enviar $_usuario');
    await _db.putRegistro('usuario', this._usuario);

    Scaffold.of(form.context).showSnackBar(
        new SnackBar(content: new Text('Bienvenido a la aplicación, $_usuario'))
    );

    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new RootPage()),
    );

  }

  @override
  Widget build(BuildContext context) {
    String textoBoton = 'Entrar'; if (this.hayUsuario==true) textoBoton = 'Canviar';
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('Falla Rep. Argentina')
        ),
        body: new Container (
            padding: EdgeInsets.all(16.0),
            child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new TextFormField(                      
                      decoration: new InputDecoration(labelText: 'Usuario (min 3 caracteres)'),
                      autofocus: true,
                      style: new TextStyle(fontSize: 24.0, color: Colors.black),
                      validator: (value) { if (value.length < 3) return 'Por favor, al menos tres caracteres'; else this._usuario = value; }
                    ),                
                    new Container(
                      padding: EdgeInsets.only(bottom: 40.0),
                    ),    
                    new RaisedButton(
                      child: new Text(textoBoton, style: new TextStyle(fontSize: 20.0,color: Colors.white)),                      
                      onPressed: validateAndSave,
                      color: Colors.redAccent,
                    )
                  ],
            ))
        )
    );
  }
}