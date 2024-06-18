//model contendo os dados a serem manipulados
class Conta {
  int? id;
  String? nome;
  String? email;
  String? password;

  Conta(this.nome, this.email, this.password);

  //metodo que retorna um MAP com array contendo os registros que e usado para listar(R)

  Conta.fromMap(Map map) {
    this.id = map["id"];
    this.nome = map["nome"];
    this.email = map["email"];
    this.password = map["password"];
  }

  //metodo que retorna um MAP (registro)
  Map toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "password ": this.password,
    };
    if (this.id != null) {
      map["id"] = this.id;
    }
    return map;
  }
}
