// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../model/user_model.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   static Database? _database;
//
//   DatabaseHelper._internal();
//
//   // Criação do banco de dados
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDb();
//     return _database!;
//   }
//
//   // Inicialização do banco de dados
//   Future<Database> _initDb() async {
//     String path = join(await getDatabasesPath(), 'users.db');
//     return openDatabase(
//       path,
//       onCreate: (db, version) {
//         return db.execute(
//           '''
//           CREATE TABLE users(
//             id TEXT PRIMARY KEY,
//             nome TEXT,
//             email TEXT,
//             telefone TEXT,
//             senha TEXT
//           )
//           ''',
//         );
//       },
//       version: 1,
//     );
//   }
//
//   // Função para inserir um novo usuário
//   Future<void> insertUser(UserModel user) async {
//     final db = await database;
//     await db.insert(
//       'users',
//       user.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   // Função para recuperar todos os usuários
//   Future<List<UserModel>> getUsers() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('users');
//     return List.generate(maps.length, (i) {
//       return UserModel.fromMap(maps[i]);
//     });
//   }
//
//   // Função para atualizar um usuário
//   Future<void> updateUser(UserModel user) async {
//     final db = await database;
//     await db.update(
//       'users',
//       user.toMap(),
//       where: 'id = ?',
//       whereArgs: [user.id],
//     );
//   }
//
//   // Função para deletar um usuário
//   Future<void> deleteUser(String id) async {
//     final db = await database;
//     await db.delete(
//       'users',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
