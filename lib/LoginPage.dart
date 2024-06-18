import 'package:app_quiz/CriarConta.dart';
import 'package:app_quiz/app_colors.dart';
import 'package:app_quiz/helper/CriarContaHelper.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/tela_principal.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String email = '';
  String password ='';
  var bdCall;
  @override
  void initState(){
    super.initState();
    bdCall = CriarContaHelper();
  }

  //metodo autenticacao de login
  login()async{
      String username = _nomeController.text;
      String password = _passwordController.text;

      if(username.isEmpty){
        print("por favor insira o nome do usuario");
      }else if(password.isEmpty){
        print("por favor insira o password");
      }else{
        await bdCall.loginInfo(username, password).then((userData){
          if(userData != null){
            print("Bem vindo ao programa");
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => PrincipalTela()),
                    (Route<dynamic> route) => false);
          }else{
            print(" Erro: usuario nao encontrado");
          }
        }).catchError((error){
          print(error);
          print("Erro: falha no login");
        });
      }

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          //botoes de accao
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NovaConta()));
              },
              icon: Icon(Icons.person_add)
          )
        ],
      ),
           body: Container(
             color: AppColors.alternateColor ,

      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
         // padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.account_circle_outlined,
                size: 100.0,
              ),
              TextField(
                controller: _nomeController,
                onChanged: (text) {
                  email = text;
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Username',

                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                  focusColor: Colors.white,

                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                onChanged: (text) {
                  password = text;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: size.width * 0.5,
                height: 60,

              child: ElevatedButton(
                onPressed: login,
                child: Text('Entrar'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.buttonColor,
                  textStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
           ),
    );
  }
}
