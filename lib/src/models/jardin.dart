import 'dart:convert';

jardin jardinFromJson(String str) => jardin.fromJson(json.decode(str));

String jardinToJson(jardin data) => json.encode(data.toJson());

class jardin {
  String? id;
  String? idPlanta;
  String? idUsuario;
  String? latitud;
  String? longitud;
  String? temperatura;
  String? humedadA;
  String? humedadS;
  String? lluvia;

  jardin({this.id, this.idPlanta, this.idUsuario, this.latitud, this.longitud, this.temperatura, this.humedadA, this.humedadS, this.lluvia});

  factory jardin.fromJson(Map<String, dynamic> json) => jardin(
        id: json["id"],
        idPlanta: json["idPlanta"],
        idUsuario: json["idUsuario"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        temperatura: json["temperatura"],
        humedadA: json["humedadA"],
        humedadS: json["humedadS"],
        lluvia: json["lluvia"],
      );

  jardin.fromElement(elemento) {
    id = elemento.id;
    idPlanta = elemento["idPlanta"];
    idUsuario = elemento["idUsuario"];
    latitud = elemento["latitud"];
    longitud = elemento["longitud"];
    temperatura= elemento["temperatura"];
    humedadA= elemento["humedadA"];
    humedadS= elemento["humedadS"];
    lluvia= elemento["lluvia"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "idPlanta": idPlanta,
        "idUsuario": idUsuario,
        "latitud": latitud,
        "longitud": longitud,
        "temperatura": temperatura,
        "humedadA": humedadA,
        "humedadS": humedadS,
        "lluvia": lluvia,
      };
}
