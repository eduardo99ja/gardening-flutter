import 'dart:convert';

Plant plantFromJson(String str) => Plant.fromJson(json.decode(str));

String plantToJson(Plant data) => json.encode(data.toJson());

class Plant {
  String? id;
  String? img;
  String? nomComm;
  String? nomBot;
  String? genero;
  String? riego;
  String? sol;
  String? humedad;
  String? temperatura;

  Plant({
    this.id,
    this.img,
    this.nomComm,
    this.nomBot,
    this.genero,
    this.riego,
    this.sol,
    this.humedad,
    this.temperatura,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        img: json["img"],
        nomComm: json["nomComm"],
        nomBot: json["nomBot"],
        genero: json["genero"],
        riego: json["riego"],
        sol: json["sol"],
        humedad: json["humedad"],
        temperatura: json["temperatura"],
      );

  Plant.fromElement(elemento){
        id = elemento.id;
        img = elemento["img"];
        nomComm = elemento["nomComm"];
        nomBot = elemento["nomBot"];
        genero = elemento["genero"];
        riego = elemento["riego"];
        sol = elemento["sol"];
        humedad = elemento["humedad"];
        temperatura = elemento["temperatura"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "nomComm": nomComm,
        "nomBot": nomBot,
        "genero": genero,
        "riego": riego,
        "sol": sol,
        "humedad": humedad,
        "temperatura": temperatura,
      };
}
