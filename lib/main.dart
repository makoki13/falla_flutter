import 'dart:async';
import 'package:flutter/material.dart';

import 'persistencia.dart';

import 'root_page.dart';
import 'login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {    
    super.initState();
    
    
    
    Widget myWidget;
    DBlocal _db = new DBlocal();
    String valor;
    
    _db.getRegistro('usuario').then( (v) {
        valor = _db.getValor();
        if (valor.trim()=='') {
          print('Entrando en login...');
          myWidget = new LoginPage(false);
        }
        else {
          print('Entrando en principal...$valor');
          myWidget = new RootPage();
        }   
        
        Timer(Duration(seconds: 5), () { 
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => myWidget),
          );
          print("Spash Done, tete!"); 
        });
        
      });      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:AssetImage('assets/falla.jpg'),
                        radius: 100.0,                        
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      Text('Falla La Rep. Argentina',style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
                      Text('Gandia',style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                      Text(' Por Nayara Bolo',style: TextStyle(color: Colors.white70, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ],                    
                  )
                )
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(padding: EdgeInsets.only(top: 20.0),),
                    Text("La app más audaz \npara el/la faller@ más inteligente",style: TextStyle(color: Colors.orangeAccent, fontSize: 14.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              )
          ],) 
        ],
      ) 
    );
  } 
}
