import 'package:uuid/uuid.dart';

class UserModel {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String senha;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.senha,
  });

  // Converte o objeto UserModel em um Map para armazenar no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'senha': senha,
    };
  }

  // Converte um Map de volta em um objeto UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      senha: map['senha'],
    );
  }

  // Função para gerar um UUID
  static String generateUUID() {
    var uuid = Uuid();
    return uuid.v4(); // Gera um UUID v4
  }

  // Método copyWith para criar uma cópia do usuário com algumas mudanças
  UserModel copyWith({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    String? senha,
  }) {
    return UserModel(
      id: id ?? this.id, // Se não for passado, mantém o valor atual
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      senha: senha ?? this.senha,
    );
  }
}
