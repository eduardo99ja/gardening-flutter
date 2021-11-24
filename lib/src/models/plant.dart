import 'dart:convert';

Plant plantFromJson(String str) => Plant.fromJson(json.decode(str));

String plantToJson(Plant data) => json.encode(data.toJson());

class Plant {
  String? id;
  String? img;
  String? img1;
  String? img2;
  String? img3;
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
    this.img1,
    this.img2,
    this.img3,
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
        img1: json["img1"],
        img2: json["img2"],
        img3: json["img3"],
        nomComm: json["nomComm"],
        nomBot: json["nomBot"],
        genero: json["genero"],
        riego: json["riego"],
        sol: json["sol"],
        humedad: json["humedad"],
        temperatura: json["temperatura"],
      );

  Plant.fromElement(elemento) {
    id = elemento.id;
    img = elemento["img"];
    img1 = elemento["img1"];
    img2 = elemento["img2"];
    img3 = elemento["img3"];
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
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "nomComm": nomComm,
        "nomBot": nomBot,
        "genero": genero,
        "riego": riego,
        "sol": sol,
        "humedad": humedad,
        "temperatura": temperatura,
      };
}
