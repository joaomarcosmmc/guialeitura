import 'package:flutter/material.dart';
import 'package:guialeitura/components/exception.dart';
import 'package:guialeitura/dados/auth.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  var confirmSenhaController = TextEditingController();

  bool isLogin = true;
  bool isLoad = false;

  showErroDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro.'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  _submit() async {
    setState(() {
      isLoad = true;
    });
    formKey.currentState!.validate();
    final auth = Provider.of<Auth>(context, listen: false);

    try {
      if (!isLogin) {
        await auth.signup(emailController.text, senhaController.text);
      } else {
        await auth.signin('teste@gmail.com', '123456');
      }
    } on ExceptionAuth catch (error) {
      showErroDialog(error.toString());
    }
    setState(() {
      isLoad = false;
    });
  }

  var obscureText = true;
  double percentSizeWidthForm(context, MediaQueryData deviceSize) {
    if (deviceSize.size.width < 450) {
      return 0.95;
    } else if (deviceSize.size.width < 600) {
      return 0.65;
    } else if (deviceSize.size.width < 941) {
      return 0.50;
    } else {
      return 0.30;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceSize = MediaQuery.of(context);
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
          ),
          Center(
            child: SizedBox(
                width: deviceSize.size.width * percentSizeWidthForm(BuildContext, deviceSize),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 6,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
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
                                controller: senhaController,
                                validator: (senha) {
                                  if (senha!.isEmpty || senha.length < 5) {
                                    return "Digite uma senha válido.";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                    suffix: isLogin
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureText = !obscureText;
                                              });
                                            },
                                            icon: Icon(obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility))
                                        : null,
                                    contentPadding: const EdgeInsets.all(10),
                                    label: const Text('Password'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              const SizedBox(height: 18),
                              !isLogin
                                  ? TextFormField(
                                      controller: confirmSenhaController,
                                      validator: (senha) {
                                        if (senha != senhaController.text ||
                                            senha!.isEmpty) {
                                          return "Senha não confere";
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: obscureText,
                                      decoration: InputDecoration(
                                          suffix: isLogin
                                              ? IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      obscureText = !obscureText;
                                                    });
                                                  },
                                                  icon: Icon(obscureText
                                                      ? Icons.visibility_off
                                                      : Icons.visibility))
                                              : null,
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          label: const Text('Password'),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    )
                                  : const SizedBox(),
                              isLogin
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text('Esqueceu a senha? '),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Clique aqui!',
                                                style: TextStyle(
                                                    color: Colors.black)))
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              !isLoad
                                  ? ElevatedButton(
                                      onPressed: _submit,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => Colors.yellow)),
                                      child: Text(
                                        isLogin ? 'Entrar' : 'Cadastrar',
                                        style:
                                            const TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color: Colors.yellow[800],
                                    ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    senhaController.clear();
                                    emailController.clear();
                                    confirmSenhaController.clear();
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(
                                  isLogin ? 'Cadastrar' : 'Já tenho cadastro!',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
