import 'package:flutter/material.dart';

import 'persistencia.dart';

import 'login_page.dart';

import 'principal.dart' as principal;
import 'calendario.dart' as calendario;
import 'fotos.dart' as fotos;
import 'chat.dart' as chat;

class RootPage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new _RootPageState();
    }
}

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {

  
  TabController controller;

  String _usuario;

  ListTile itemListTile;
    
  @override
  void initState() {
    super.initState();

    this.getUsuario();
    
    controller = new TabController(length: 4, vsync: this);
  }

  getUsuario() async {
    
    DBlocal _db = new DBlocal();
    await _db.getRegistro('usuario');
    this._usuario = _db.getValor();
    
    print('Principal con $_usuario');
    itemListTile = new ListTile(leading: const Icon(Icons.settings), title: Text(this._usuario),);

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {     
    return new Scaffold(      
      appBar: new AppBar(
        title: new Text("Falla Avd.Rep.Argentina"),
        backgroundColor: Colors.redAccent,        
      ),

      bottomNavigationBar: new Material(
        color: Colors.redAccent,
        child: new TabBar(
            controller: controller,
            tabs: <Tab> [
              new Tab(icon: new Icon(Icons.add_alert)),
              new Tab(icon: new Icon(Icons.announcement)),
              new Tab(icon: new Icon(Icons.add_a_photo)),
              new Tab(icon: new Icon(Icons.chat))
            ]
        )
      ),

      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new principal.Principal(),
          new calendario.Calendario(),
          new fotos.Fotos(),
          new chat.Chat(_usuario)
        ]
      ),

      drawer: new Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.

        child: new ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,          
          children: <Widget>[
            new DrawerHeader(
              //child: new Text('${this._usuario}',style: new TextStyle(fontSize: 24.0, color: Colors.white),),decoration: new BoxDecoration(color: Colors.red,),                            
              child: itemListTile,
              decoration: new BoxDecoration(color: Colors.red, shape: BoxShape.rectangle),
            ),
            
            new ListTile(
              title: new Text('Canvi Usuari'),
              onTap: () {
                // Update the state of the app
                // ...
                print("Entrando en Canvi...");
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new LoginPage(true)));
                //Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Administrador'),
              onTap: () {
                // Update the state of the app
                // ...
                Navigator.pop(context);
              },
            ),
            new ListTile(
              title: new Text('Borrar Usuario'),
              onTap: () {
                DBlocal _db = new DBlocal();
                print('Borrando usuario...');
                _db.putRegistro('usuario', '');                
              },
            ),
          ],
        ),
      )
    );
  }
}