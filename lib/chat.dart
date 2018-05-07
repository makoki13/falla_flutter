import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './modelos/mensaje.dart';
import './mensajeChat.dart';

class Chat extends StatefulWidget {
  String _usuario;

  Chat(this._usuario);

  @override
  _ChatListState createState() => new _ChatListState(_usuario);
}

class _ChatListState extends State<Chat> {
  List<Mensaje> _mensajes = [];

  final formKey = new GlobalKey<FormState>();

  String _usuario;

  final CollectionReference chatCollection = Firestore.instance.collection('chat');  //FIREBASE

  _ChatListState(this._usuario);
  
  @override
  void initState () {
    super.initState();  
    print("PASO 1");  
    _cargaDesdeFirebase();
    print("PASO 2");
  }
  
  _cargaDesdeFirebase() async {
    final mensajes = await getAllMensajes();    
    setState(() {
       _mensajes = mensajes;   
    });
  }

  Future<Null> refresh(){
    _cargaDesdeFirebase();
    return new Future<Null>.value();
  }

  Widget _construyeMensajeItem(BuildContext context, int index) {
    Mensaje mensaje = _mensajes[index];

    return new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Card(
        child: new Wrap(
          direction: Axis.horizontal, // main axis (rows or columns)
          children: <Widget>[
            new ListTile(
              onTap: () => null,
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: null,
                ),
              ),
              title: new Text(
                mensaje.usuario,
                style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: new Text(mensaje.texto),
              isThreeLine: true, // Less Cramped Tile
              dense: false, // Less Cramped Tile
            ),
          ],
        ),
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return new Text(
      'Chat fallero',
      style: new TextStyle(
        color: Colors.pink,
        wordSpacing: 15.0,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,        

      ),
    );
  }

  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _mensajes.length,
          itemBuilder: _construyeMensajeItem
        )
      )
    );
  }

  Widget _buildBody() {    
    return new Container(
      margin: const EdgeInsets.fromLTRB(
        0.0,  // A left margin of 8.0
        6.0, // A top margin of 56.0
        8.0,  // A right margin of 8.0
        0.0   // A bottom margin of 0.0
      ),
      child: new Column(
        // A column widget can have several
        // widgets that are placed in a top down fashion
        children: <Widget>[          
          _getAppTitleWidget(),
          _getListViewWidget(),                    
        ],
      ),
    );
  }

  Future<dynamic> _addMensaje(Mensaje m) {
    final Map<String, dynamic> data = m.toMap();
    return chatCollection.document().setData(data);    
  }

  Future _openAddEntryDialog() async {
    print("Entrando...");
    Mensaje save = await Navigator.of(context).push(new MaterialPageRoute<Mensaje>(
      builder: (BuildContext context) {
        return new MensajeChat(this._usuario);
      },
      fullscreenDialog: true
    ));
    if (save != null) {      
      _addMensaje(save);
      //getAllMensajes();
      _cargaDesdeFirebase();
    }
  }
    
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),      
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _openAddEntryDialog(),
        tooltip: 'Nuevo mensaje',
        backgroundColor: Colors.purpleAccent,
        child: new CircleAvatar(
          backgroundImage: null,
          radius: 50.0,
        ),
      ),
    );
  }
  
  Future<List<Mensaje>> getAllMensajes() async {    
    //FIRESTORE
    List<Mensaje> data = (await chatCollection.getDocuments()).documents.map((snapshot) => _fromDocumentSnapShot(snapshot)).toList();    
    return data;
  }

  //RUTINAS PARA ACTUALIZAR???
  StreamSubscription watch(Mensaje mensaje, void onChange(Mensaje mensaje)) {
    return Firestore.instance
      .collection('chat')
      .document(mensaje.documentId)
      .snapshots
      .listen ((snapshot) => onChange(_fromDocumentSnapShot(snapshot)));
  }

  Mensaje _fromDocumentSnapShot(DocumentSnapshot snapshot) {
    
    final data = snapshot.data;

    return new Mensaje(
      documentId: snapshot.documentID,
      momento: data['momento'],
      usuario: data['usuario'],
      texto:   data['texto']
    );

  }
  
}