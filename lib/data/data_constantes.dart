const String kDATABASE_NAME = "contatos_db";

const String kCONTATOS_TABLE_NAME = "contatos";
const String kCONTATOS_COLUMN_CONTATOSID = "contatoID";
const String kCONTATOS_COLUMN_NOME = "name";
const String kCONTATOS_COLUMN_EMAIL = "email";
const String kCONTATOS_COLUMN_TELEFONE = "phonenumber";

const String kCREATE_PRODUTOS_TABLE_SCRIPT = '''
  CREATE TABLE $kCONTATOS_TABLE_NAME(
    $kCONTATOS_COLUMN_CONTATOSID INTEGER PRIMARY KEY,
    $kCONTATOS_COLUMN_NOME TEXT,
    $kCONTATOS_COLUMN_EMAIL TEXT,
    $kCONTATOS_COLUMN_TELEFONE TEXT
  )
  ''';
