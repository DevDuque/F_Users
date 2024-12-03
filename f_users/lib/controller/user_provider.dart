import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  // Função para carregar os usuários diretamente do banco de dados
  Future<void> fetchUsers() async {
    _users = await DatabaseHelper.getUsers();
    notifyListeners();
  }

  // Função para adicionar um novo usuário ao banco de dados
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
  Future<UserModel?> findUserByEmail(String email) async {
    return await DatabaseHelper.getUserByEmail(email);
  }

  // Função para atualizar um usuário
  Future<void> updateUser(UserModel updatedUser) async {
    await DatabaseHelper.updateUser(updatedUser);
    await fetchUsers();
  }

  // Função para deletar um usuário
  Future<void> deleteUser(UserModel user) async {
    await DatabaseHelper.deleteUser(user.id);
    await fetchUsers();
  }
}
