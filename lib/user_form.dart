import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_create_flutter/field_form.dart';

import 'package:teste_create_flutter/user.dart';
import 'package:teste_create_flutter/userprovider.dart';

import 'container_all.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String? title1 = "Coloque seus Contatos";

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context,
        listen: false); // Atualizando para Provider.of
    int? index;

    if (userProvider.indexUser != null) {
      index = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPhone.text = userProvider.userSelected!.phonenumber;

      setState(() {
        this.title1 = "Editar Contato";
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void save() async {
      final isValidated = _key.currentState?.validate();
      if (isValidated == false) {
        return;
      }
      _key.currentState?.save();

      User contact = User(
          name: controllerName.text,
          email: controllerEmail.text,
          phonenumber: controllerPhone.text);

      if (index != null) {
        // Editar o contato existente
        contact.contatoID = userProvider
            .contacts[index].contatoID; // Manter o id do contato existente
        await userProvider.updateContact(contact);
      } else {
        // Adicionar novo contato
        await userProvider.addContact(contact);
      }

      // Após salvar, navegar de volta para a lista de contatos
      Navigator.popAndPushNamed(context, "/list");
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
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
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
          child: Form(
            key: _key,
            child: Column(children: [
              FieldForm(
                  label: "Name",
                  controller: controllerName,
                  isEmail: false,
                  isPhone: false),
              FieldForm(
                  label: "Email",
                  controller: controllerEmail,
                  isEmail: true,
                  isPhone: false),
              FieldForm(
                  label: "Phone",
                  controller: controllerPhone,
                  isEmail: false,
                  isPhone: false),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: save,
                  child: Text('Salvar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
