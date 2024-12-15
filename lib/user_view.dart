import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_create_flutter/field_form.dart';
import 'package:teste_create_flutter/userprovider.dart';
import 'package:teste_create_flutter/user.dart';

import 'container_all.dart';

class UserView extends StatelessWidget {
  UserView({super.key});

  String? title1 = "Contato";

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    int? index = userProvider.indexUser;

    if (index != null && userProvider.userSelected != null) {
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPhone.text = userProvider.userSelected!.phonenumber;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title1!),
        actions: [
          Container(
            child: TextButton(
              child: Text('Lista de Contatos'),
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: WidgetStateProperty.all(Colors.white)),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            margin: EdgeInsets.all(8),
          )
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Column(
            children: [
              FieldForm(
                  label: "Name",
                  controller: controllerName,
                  isForm: false,
                  isEmail: false,
                  isPhone: false),
              FieldForm(
                  label: "Email",
                  controller: controllerEmail,
                  isForm: false,
                  isEmail: false,
                  isPhone: false),
              FieldForm(
                  label: "Phone",
                  controller: controllerPhone,
                  isForm: false,
                  isEmail: false,
                  isPhone: false),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    if (index != null && userProvider.userSelected != null) {
                      // Editando um contato existente
                      User updatedContact = User(
                        contatoID: userProvider
                            .userSelected!.contatoID, // Garantir o contatoID
                        name: controllerName.text,
                        email: controllerEmail.text,
                        phonenumber: controllerPhone.text,
                      );
                      // Atualizando no banco de dados e no provider
                      await userProvider.updateContact(updatedContact);
                    }
                    Navigator.popAndPushNamed(context, "/list");
                  },
                  child: Text('Editar'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Theme.of(context).primaryColor),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    if (index != null && userProvider.contacts.isNotEmpty) {
                      // Deletando o contato
                      await userProvider.deleteContact(index);
                      Navigator.popAndPushNamed(context, "/list");
                    }
                  },
                  child: Text('Deletar'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
