import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kickstat.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Tabela Times
    await db.execute('''
      CREATE TABLE Times (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        estado TEXT,
        liga TEXT,
        ano_fundacao INTEGER
      )
    ''');

    // Tabela Jogadores
    await db.execute('''
      CREATE TABLE Jogadores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER,
        posicao TEXT,
        altura REAL,
        peso REAL,
        time_id INTEGER,
        FOREIGN KEY (time_id) REFERENCES Times (id) ON DELETE CASCADE
      )
    ''');

    // Tabela Partidas
    await db.execute('''
      CREATE TABLE Partidas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT NOT NULL,
        time_casa_id INTEGER,
        time_fora_id INTEGER,
        placar_casa INTEGER,
        placar_fora INTEGER,
        local TEXT,
        FOREIGN KEY (time_casa_id) REFERENCES Times (id) ON DELETE SET NULL,
        FOREIGN KEY (time_fora_id) REFERENCES Times (id) ON DELETE SET NULL
      )
    ''');

    // Tabela Estatísticas
    await db.execute('''
      CREATE TABLE Estatisticas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        jogador_id INTEGER NOT NULL,
        temporada TEXT,
        gols INTEGER DEFAULT 0,
        assistencias INTEGER DEFAULT 0,
        minutos_jogados INTEGER DEFAULT 0,
        cartoes_amarelos INTEGER DEFAULT 0,
        cartoes_vermelhos INTEGER DEFAULT 0,
        partida_id INTEGER NOT NULL,
        FOREIGN KEY (jogador_id) REFERENCES Jogadores (id) ON DELETE CASCADE,
        FOREIGN KEY (partida_id) REFERENCES Partidas (id) ON DELETE CASCADE
      )
    ''');
  }

  // Métodos CRUD genéricos
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  Future<int> update(String table, Map<String, dynamic> data, {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, {String? where, List<Object?>? whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
