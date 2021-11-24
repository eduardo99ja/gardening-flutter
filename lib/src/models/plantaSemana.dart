class PlantaSemanal {
  PlantaSemanal();

  int? id;
  String? idPlanta;
  String? lunes;
  String? martes;
  String? miercoles;
  String? jueves;
  String? viernes;
  String? sabado;
  String? domingo;

  set detId(int id) {
    this.id = id;
  }

  set plantaId(String? id) {
    this.idPlanta = id;
  }

  set plantaLunes(String? info) {
    this.lunes = info;
  }

  set plantaMartes(String? info) {
    this.martes = info;
  }

  set plantaMiercoles(String? info) {
    this.miercoles = info;
  }

  set plantaJueves(String? info) {
    this.jueves = info;
  }

  set plantaViernes(String? info) {
    this.viernes = info;
  }

  set plantaSabado(String? info) {
    this.sabado = info;
  }

  set plantaDomingo(String? info) {
    this.domingo = info;
  }

  /// Read from a record.
  PlantaSemanal.fromMap(Map map) {
    id = map["_id"] as int?;
    idPlanta = map["idPlanta"] as String?;
    lunes = map["lunes"] as String?;
    martes = map["martes"] as String?;
    miercoles = map["miercoles"] as String?;
    jueves = map["jueves"] as String?;
    viernes = map["viernes"] as String?;
    sabado = map["sabado"] as String?;
    domingo = map["domingo"] as String?;
  }

  /// Convert to a record.
  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      "idPlanta": idPlanta,
      "lunes": lunes,
      "martes": martes,
      "miercoles": miercoles,
      "jueves": jueves,
      "viernes": viernes,
      "sabado": sabado,
      "domingo": domingo,
    };
    if (id != null) {
      map["_id"] = id;
    }
    return map;
  }
}
