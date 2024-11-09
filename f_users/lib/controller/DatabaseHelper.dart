import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import '../model/UserModel.dart';

class DatabaseHelper {
  static Database? _database;

  // Cria ou abre o banco de dados
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa o banco de dados
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id TEXT PRIMARY KEY, nome TEXT, email TEXT, telefone TEXT, senha TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insere um novo usuário no banco de dados
  static Future<void> insertUser(UserModel user) async {
    final db = await database;

    // Verifica se o id já foi gerado no modelo, senão, cria um novo UUID
    final userWithId = UserModel(
      id: user.id.isEmpty
          ? UserModel.generateUUID()
          : user.id, // Garante que o ID é gerado
      nome: user.nome,
      email: user.email,
      telefone: user.telefone,
      senha: user.senha,
    );

    await db.insert(
      'users',
      userWithId.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Substitui no caso de conflito
    );
  }

  // Recupera todos os usuários
  static Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

  // Recupera um usuário pelo email
  static Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  // Atualiza um usuário
  static Future<void> updateUser(UserModel user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Deleta um usuário (opcional, caso queira implementar exclusão)
  static Future<void> deleteUser(String userId) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
