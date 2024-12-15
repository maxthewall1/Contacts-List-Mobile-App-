import 'package:sqflite/sqflite.dart';
import 'package:teste_create_flutter/data/data_constantes.dart';
import 'package:path/path.dart';
import 'package:teste_create_flutter/user.dart';

import '../core/data/data_general_constantes.dart';

class ContatosSQLiteDatasource {
  Future<Database> _getDatabase() async {
    //await deleteDatabase(
    //join(await getDatabasesPath(), kDATABASE_NAME),
    //);

    return openDatabase(
      join(await getDatabasesPath(), kDATABASE_NAME),
      onCreate: (db, version) async {
        await db.execute(kCREATE_PRODUTOS_TABLE_SCRIPT);

        await db.rawInsert(
            '''insert into $kCONTATOS_TABLE_NAME($kCONTATOS_COLUMN_NOME, $kCONTATOS_COLUMN_EMAIL, $kCONTATOS_COLUMN_TELEFONE)
        VALUES('Pedro', 'pedro@gmail.com', '6299815342')''');
      },
      version: kDATABASE_VERSION,
    );
  }

  
 

  Future<void> delete(int contatoID) async {
    final db = await _getDatabase();
    try {
      // Deleta o contato da tabela usando o ID
      await db.delete(
        'contatos', // Nome da tabela
        where: '$kCONTATOS_COLUMN_CONTATOSID = ?', // Condição para identificar o contato a ser deletado
        whereArgs: [contatoID], // Passa o ID do contato para a consulta
      );
    } catch (e) {
      print('Erro ao deletar o contato: $e');
      rethrow; // Re-lança o erro se ocorrer
    }
  }



  Future create(User contato) async {
    try {
      final Database db = await _getDatabase();

      contato.contatoID = await db.insert(kCONTATOS_TABLE_NAME, {
        kCONTATOS_COLUMN_NOME: contato.name,
        kCONTATOS_COLUMN_EMAIL: contato.email,
        kCONTATOS_COLUMN_TELEFONE: contato.phonenumber,
      });
    } catch (ex) {
      print("Error inserting contatc: $ex");
    }
  }

  // Método de Leitura
  Future<List<User>> readAll() async {
    final db =
        await _getDatabase(); // Método para obter a instância do banco de dados

    final List<Map<String, dynamic>> maps =
        await db.query(kCONTATOS_TABLE_NAME);

    return List.generate(maps.length, (i) {
      return User(
        contatoID: maps[i][kCONTATOS_COLUMN_CONTATOSID],
        name: maps[i][kCONTATOS_COLUMN_NOME],
        email: maps[i][kCONTATOS_COLUMN_EMAIL],
        phonenumber: maps[i][kCONTATOS_COLUMN_TELEFONE],
      );
    });
  }

  // Método de Atualização
  Future<void> update(User contato) async {
    final db = await _getDatabase();

    await db.update(
      kCONTATOS_TABLE_NAME,
      {
        kCONTATOS_COLUMN_NOME: contato.name,
        kCONTATOS_COLUMN_EMAIL: contato.email,
        kCONTATOS_COLUMN_TELEFONE: contato.phonenumber,
      },
      where: '$kCONTATOS_COLUMN_CONTATOSID = ?',
      whereArgs: [contato.contatoID],
    );
  }
}
