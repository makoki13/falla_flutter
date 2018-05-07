import 'package:meta/meta.dart';

class Mensaje {
  final String documentId;
  final num momento;
  final String usuario;
  final String texto;

  Mensaje({
    @required this.documentId,
    @required this.momento,
    @required this.usuario,
    @required this.texto,
  });

  Map<String, dynamic> toMap() => {        
        'momento': this.momento,
        'texto': this.texto,
        'usuario': this.usuario
      };



}