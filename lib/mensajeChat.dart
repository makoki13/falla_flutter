import 'package:flutter/material.dart';

import './modelos/mensaje.dart';
import './utiles.dart';

class MensajeChat extends StatefulWidget {
  String _usuario;

  MensajeChat(this._usuario);

  @override
  MensajeChatState createState() => new MensajeChatState(this._usuario);
}

class MensajeChatState extends State<MensajeChat> {
  String _note;
  String _usuario;
  TextEditingController _textController;

  MensajeChatState(this._usuario);

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: _note);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(new Mensaje(
                    documentId: generatePushId(),
                    momento: new DateTime.now().millisecondsSinceEpoch,
                    usuario: this._usuario,
                    texto: _note));
              },
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: new ListTile(
        leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
        title: new TextField(
          decoration: new InputDecoration(
            hintText: 'Optional note',
          ),
          controller: _textController,
          onChanged: (value) => _note = value,
        ),
      ),
    );
  }
}
