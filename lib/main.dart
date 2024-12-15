import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_create_flutter/contacts_list.dart';
import 'package:teste_create_flutter/user_form.dart';
import 'package:teste_create_flutter/user_view.dart';
import 'package:teste_create_flutter/userprovider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
          title: 'Lista de Contatos',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: UserForm(),
          
          routes: {
            "/create": (_) => UserForm(),
            "/list": (_) => ContactsList(),
            "/view": (_) => UserView(),
          }
          //colocarlistadecontatos
          ),
    );
  }
}
