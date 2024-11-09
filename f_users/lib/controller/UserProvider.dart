import 'package:flutter/material.dart';
import '../controller/DatabaseHelper.dart';
import '../model/UserModel.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  // Carrega todos os usuários do banco de dados
  Future<void> fetchUsers() async {
    _users = await DatabaseHelper.getUsers();
    notifyListeners();
  }

  // Adiciona um novo usuário ao banco de dados e atualiza a lista
  Future<void> addUser(UserModel user) async {
    final userWithId = UserModel(
      id: UserModel.generateUUID(),
      nome: user.nome,
      email: user.email,
      telefone: user.telefone,
      senha: user.senha,
    );

    await DatabaseHelper.insertUser(userWithId);
    await fetchUsers();
  }

  // Função para encontrar um usuário pelo email
  UserModel findUserByEmail(String email) {
    try {
      return _users.firstWhere(
        (user) => user.email == email,
      );
    } catch (e) {
      throw Exception("Usuário não encontrado");
    }
  }

  // Função para atualizar um usuário
  Future<void> updateUser(UserModel updatedUser) async {
    await DatabaseHelper.updateUser(updatedUser);
    await fetchUsers(); // Atualiza a lista de usuários após a edição
  }

  // Função para deletar um usuário
  Future<void> deleteUser(UserModel user) async {
    await DatabaseHelper.deleteUser(user.id); // Remover do banco de dados
    await fetchUsers(); // Atualiza a lista de usuários após a exclusão
  }
}
