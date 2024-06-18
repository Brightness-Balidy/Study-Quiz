import 'package:app_quiz/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/LoginPage.dart';
import 'package:app_quiz/model/Conta.dart';
import 'package:app_quiz/helper/CriarContaHelper.dart';

class NovaConta extends StatefulWidget {
  const NovaConta({Key? key}) : super(key: key);

  @override
  _NovaContaState createState() => _NovaContaState();
}

class _NovaContaState extends State<NovaConta> {
  //Controladores usados nos Textfield
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  var _db = CriarContaHelper(); //variavel para acessar a bd
  List<Conta> _contas = <Conta>[]; //lista com o array de dados

  _showScreenAdd({Conta? conta}) {
    String textSaveUpdate = "";
    if (conta == null) {
      _nameController.text = "";
      _emailController.text = "";
      _passwordController.text = "";
      //_passConfirmController.text="";
      textSaveUpdate = "Salvar";
    } else {
      _nameController.text = conta.nome!;
      _emailController.text = conta.email!;
      _passwordController.text = conta.password!;
      textSaveUpdate = "Actualizar";
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("$textSaveUpdate Nova Conta"),
            content: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ajusta o dinamicamente em funcao do Conteudo
              children: [
                TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Nome", hintText: "digite o seu nome..."),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: "email", hintText: "digite o seu email..."),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: "password", hintText: "digite o password..."),
                ),

                TextField(
                  controller: _passConfirmController,
                  decoration:
                      InputDecoration(labelText: "confirme o password..."),
                )
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    _salvarNovaConta(contaInserida: conta);
                    Navigator.pop(context);
                  },
                  child: Text(textSaveUpdate)),
            ],
          );
        });
  }

  //recuperar as contas
  _recoverContas() async {
    List contasRecuperar = await _db.recuperarConta();
    List<Conta>? listTemp = <Conta>[];
    for (var item in contasRecuperar) {
      Conta conta = Conta.fromMap(item);
      listTemp.add(conta);
    }
    setState(() {
      _contas = listTemp!;
    });
    listTemp = null;
  }

//Metodo para Salvar
  _salvarNovaConta({Conta? contaInserida}) async {
    String nome = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (contaInserida == null) {
      Conta conta = Conta(nome, email, password);
      int result = await _db.salvarConta(conta);
    } else {
      contaInserida.nome = nome;
      contaInserida.email = email;
      contaInserida.password = password;
      int result = await _db.actualizarConta(contaInserida);
    }
    _nameController.clear();
    _emailController.clear();

    _recoverContas();
  }

  //metodo para Remover
  _removerConta(int id) async {
    await _db.removerConta(id);

    _recoverContas();
  }

  @override
  //Recuperacao dos dados usando o initState
  void initState() {
    super.initState();
    _recoverContas();
  }

  //layout da tela criar conta
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas Cadatradas"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(

        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _contas.length,
                  itemBuilder: (context, index) {
                    final conta = _contas[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),),
                        title: Text(conta.nome!),
                        subtitle: Text("lista conta"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showScreenAdd(conta: conta);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(Icons.edit,
                                color: Colors.green,
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                _removerConta(conta.id!);

                              },
                              child: Padding(padding: EdgeInsets.only(right: 0),
                                child: Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                            ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          _showScreenAdd();
        },
      ),
    );
  }
}
