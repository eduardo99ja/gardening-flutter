import 'package:gardening/src/models/plantaSemana.dart';
import 'package:sqflite/sqflite.dart';

/// `todo` table name
const String tablePlanta = 'planta';

/// id column name
const String columnId = '_id';

/// title column name
const String columnIdPlanta = 'idPlanta';

/// done column name
const String columnLunes = 'lunes';
const String columnMartes = 'martes';
const String columnMiercoles = 'miercoles';
const String columnJueves = 'jueves';
const String columnViernes = 'viernes';
const String columnSabado = 'sabado';
const String columnDomingo = 'domingo';

class SqliteProvider {
  /// The database when opened.
  late Database db;

  /// Open the database.
  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $tablePlanta ( 
  $columnId integer primary key autoincrement, 
  $columnIdPlanta text not null,
  $columnLunes text not null,
  $columnMartes text not null,
  $columnMiercoles text not null,
  $columnJueves text not null,
  $columnViernes text not null,
  $columnSabado text not null,
  $columnDomingo text not null)
''');
    });
  }

  /// Insert a todo.
  Future<PlantaSemanal> insert(PlantaSemanal planta) async {
    planta.id = await db.insert(tablePlanta, planta.toMap());
    print('insertado');
    return planta;
  }

  /// Get a todo.
  Future<PlantaSemanal?> getPlantaSemanal(int id) async {
    final List<Map> maps = await db.query(tablePlanta,
        columns: [
          columnId,
          columnIdPlanta,
          columnLunes,
          columnMartes,
          columnMiercoles,
          columnJueves,
          columnViernes,
          columnSabado,
          columnDomingo
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return PlantaSemanal.fromMap(maps.first);
    }
    return null;
  }

  /// Get a Plant with idPlant
  Future<PlantaSemanal?> getPlantaSemanalById(String id) async {
    final List<Map> maps = await db.query(tablePlanta,
        columns: [
          columnId,
          columnIdPlanta,
          columnLunes,
          columnMartes,
          columnMiercoles,
          columnJueves,
          columnViernes,
          columnSabado,
          columnDomingo
        ],
        where: '$columnIdPlanta = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return PlantaSemanal.fromMap(maps.first);
    }
    return null;
  }

  /// Delete a todo.
  Future<int> delete(int id) async {
    return await db.delete(tablePlanta, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Delete all regiestries
  Future<int> deleteDB(int id) async {
    return await db.delete(tablePlanta);
  }

  /// Update a todo.
  Future<int> update(PlantaSemanal planta) async {
    return await db
        .update(tablePlanta, planta.toMap(), where: '$columnId = ?', whereArgs: [planta.id!]);
  }

  /// Close database.
  Future close() async => db.close();
}
