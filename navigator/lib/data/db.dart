import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBManager {
  Database database;
  //Esta función inicializa la BD. Si no existe, crea la bd y regresa
  //una conexión. Si existe, regresa una conexión a la BD.
  Future<Database> _initBD() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'miapp.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE usuario ( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL," +
                " nombre TEXT NOT NULL, email TEXT NOT NULL, clave TEXT NOT NULL, sesion INT NOT NULL )");
      },
      version: 1,
    );
    return database;
  }

  //Esta función nos da la conexión a la BD.
  Future<Database> getConnection() async {
    if (database != null) {
      return database;
    } else {
      return _initBD();
    }
  }
}
