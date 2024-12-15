//classe para o inheritedwidget e compartilhamento de informações entre widget
import 'package:flutter/material.dart';
import 'package:teste_create_flutter/user.dart';
import 'data/contatos_sqlite_datasource.dart';

class UserProvider with ChangeNotifier {
  List<User> contacts = [];
  User? userSelected;
  int? indexUser;
 
  // Método para adicionar um novo contato (que já pode existir)
  Future<void> addContact(User contact) async {
    await ContatosSQLiteDatasource().create(contact);
    loadContacts();
  }

  // Método para deletar um contato (que já pode existir)
  Future<void> deleteContact(int contatoID) async {
    await ContatosSQLiteDatasource().delete(contatoID);
    loadContacts();
  }

  // Método para editar um contato (será adicionado)
  Future<void> updateContact(User contact) async {
    await ContatosSQLiteDatasource().update(contact);
    loadContacts();
  }

  // Método para carregar os contatos do banco de dados (será adicionado)
  Future<void> loadContacts() async {
    final List<User> loadedContacts =
        await ContatosSQLiteDatasource().readAll();
    contacts = loadedContacts;
    notifyListeners();
  }

  // Método para buscar um contato específico (exemplo)
  User getContactById(int contactId) {
    return contacts.firstWhere((contact) => contact.contatoID == contactId,
        orElse: () =>
            User(contatoID: -1, name: '', email: '', phonenumber: ''));
  }
}
