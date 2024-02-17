import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  ], ),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Form(child: 
                Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          label: const Text('Login'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          label: const Text('Password'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                const Text('Esqueceu a senha? '),
                TextButton(onPressed: (){}, child: const Text('Clique aqui!', style: TextStyle(color: Colors.black)))
                    ],
                  ),
                ],),
                
                ),
              ],),
            ),
          )
        ],
      )
    );
  }
}
