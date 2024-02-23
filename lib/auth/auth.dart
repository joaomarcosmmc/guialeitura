import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  _submit(){
     formKey.currentState!.validate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(243, 154, 37, 1),
                Color.fromRGBO(241, 233, 73, 0.898),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (email) {
                              if (email!.isEmpty || !email.contains('@')) {
                                return "Digite um E-mail válido.";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                label: const Text('E-mail'),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            validator: (senha) {
                              if(senha!.isEmpty || senha.length < 5){
                                return "Digite uma senha válido.";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                label: const Text('Password'),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Esqueceu a senha? '),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('Clique aqui!',
                                      style: TextStyle(color: Colors.black)))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Entrar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
