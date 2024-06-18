import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_quiz/model/Conta.dart';


//Classe Singleton para Conexao e manipulacao da BD (a classe e instanciada uma unica vez)
class CriarContaHelper {
  static final String nameTable = "conta"; //variavel que armazena o nome da BD

//Criacao do construtor que instancia a BD

  static final CriarContaHelper _criarContaHelper =
      CriarContaHelper._internal();
  Database? _db;

  factory CriarContaHelper() {
    return _criarContaHelper;
  }

  CriarContaHelper._internal() {
  }

//metodo para criar a Tabela na BD
  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE $nameTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nome VARCHAR, "
        "email VARCHAR, "
        "password VARCHAR)";
    await db.execute(sql);
  }

//metodo para inicializar a BD
  launcherDB() async {
    final pathDatabase = await getDatabasesPath();
    final placeDatabase = join(pathDatabase, "app_quiz.db");

    var db = await openDatabase(placeDatabase, version: 1, onCreate: _onCreate);
    return db;
  }

//metodo para aceder a BD
  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await launcherDB(); //chamamos o metodo criado acima
      return _db;
    }
  }

  //Metodo para Salvar (C)
Future<int> salvarConta(Conta conta) async{

    var dataBase = await db;
    int result = await dataBase.insert(nameTable, conta.toMap());
    return result;
}

//metodo para actualizar(U)
Future<int> actualizarConta(Conta conta) async {
    var dataBase = await db;
    return await dataBase.update(
      nameTable,
      conta.toMap(),
      where: "id = ?",
      whereArgs: [conta.id]
    );
}
//metodo para Eliminar (D)
  Future<int> removerConta(int id) async{
     var dataBase = await db;
     return await dataBase.delete(
       nameTable,
       where: "id = ?",
       whereArgs: [id]
     );
  }
//metodo para Listar (R)
recuperarConta() async{
    var dataBase = await db;
    String sql = "SELECT * FROM $nameTable ORDER BY nome DESC";
    List contas = await dataBase.rawQuery(sql);
    return contas;
}
//metodo autenticacao login
Future<Conta?> loginInfo(String nome, String password) async{

    var baseDados = await db;
    var res = await baseDados.rawQuery(
        "SELECT * FROM $nameTable WHERE "
        "nome = '$nome' AND "
        "password = '$password'");
    if(res.length >0) {
      return Conta.fromMap(res.first);
    }
    return null;
}

}
