import 'package:flutter/material.dart';
import 'package:teste_create_flutter/user.dart';
import 'package:teste_create_flutter/userprovider.dart';
import 'package:provider/provider.dart';
import 'container_all.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Usando Provider para acessar o UserProvider
    final userProvider = Provider.of<UserProvider>(context);
    List<User> contacts = userProvider.contacts;

    int contactsLength = contacts.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        leading: BackButton(onPressed: () {
          userProvider.indexUser = null;
          Navigator.popAndPushNamed(context, "/create");
        }),
      ),
      body: ContainerAll(
        child: ListView.builder(
          itemCount: contactsLength,
          itemBuilder: (BuildContext contextBuilder, indexBuilder) => Container(
            child: ListTile(
              title: Text(contacts[indexBuilder].name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Editar Contato
                  IconButton(
                    onPressed: () {
                      userProvider.userSelected = contacts[indexBuilder];
                      userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, "/create");
                    },
                    icon: Icon(Icons.edit),
                  ),
                  // Visualizar Contato
                  IconButton(
                    onPressed: () {
                      userProvider.userSelected = contacts[indexBuilder];
                      userProvider.indexUser = indexBuilder;
                      Navigator.popAndPushNamed(context, "/view");
                    },
                    icon: Icon(Icons.visibility),
                  ),
                  // Excluir Contato
                  IconButton(
                    onPressed: () async {
                      // Excluir o contato do banco de dados
                      await userProvider
                          .deleteContact(contacts[indexBuilder].contatoID!);
                      // Atualizar a lista de contatos
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.4)),
            ),
          ),
        ),
      ),
    );
  }
}
