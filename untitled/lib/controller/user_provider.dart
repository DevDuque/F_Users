import 'package:flutter/material.dart';
import '../model/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  // Carrega todos os usuários (pode ser substituído por uma lista fixa ou carregamento estático)
  void fetchUsers() {
    // Simulação de carregamento (substitua com uma lista estática ou outra fonte se necessário)
    _users = [];
    notifyListeners();
  }

  // Adiciona um novo usuário à lista (sem interagir com o banco de dados)
  // Modificado para verificar se o e-mail já existe
  void addUser(UserModel user) {
    // Verifica se já existe um usuário com o mesmo email
    if (findUserByEmail(user.email) != null) {
      throw Exception('Este email já está cadastrado!');
    }

    final userWithId = UserModel(
      id: UserModel.generateUUID(), // Gerar ID para o usuário
      nome: user.nome,
      email: user.email,
      telefone: user.telefone,
      senha: user.senha,
    );

    _users.add(userWithId); // Adiciona à lista
    notifyListeners();
  }


  // Encontra um usuário pelo email (opera diretamente na lista)
  UserModel? findUserByEmail(String email) {
    try {
      return _users.firstWhere(
        (user) => user.email == email,
      );
    } catch (e) {
      return null; // Retorna null se não encontrar
    }
  }

  // Atualiza um usuário (modifica a lista diretamente)
  void updateUser(UserModel updatedUser) {
    int index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser; // Atualiza o usuário na lista
      notifyListeners();
    }
  }

  // Deleta um usuário da lista (sem interagir com o banco de dados)
  void deleteUser(UserModel user) {
    _users.removeWhere((u) => u.id == user.id); // Remove o usuário da lista
    notifyListeners();
  }
}
