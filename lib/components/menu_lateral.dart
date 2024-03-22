import 'package:flutter/material.dart';
import 'package:guialeitura/dados/auth.dart';
import 'package:guialeitura/pages/auth_or_home_page.dart';
import 'package:guialeitura/pages/estatistica_page.dart';
import 'package:guialeitura/pages/home_page.dart';
import 'package:guialeitura/pages/leitura_futura.dart';
import 'package:guialeitura/pages/livros_lidos.dart';
import 'package:provider/provider.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.amber,
            height: 80,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Guia Leitura',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'HedvigLetter',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => const MyHomePage(),
              ));
            },
            icon: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: const Text(
              'Início',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const Divider(),
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => const ListagemLivrosLidos(),
              ));
            },
            icon: const Icon(
              Icons.verified_outlined,
              color: Colors.black,
            ),
            label: const Text(
              'Livros Lidos',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const Divider(),
          TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const ListagemLeituraFutura(),
                ));
              },
              icon: const Icon(Icons.list_alt, color: Colors.black),
              label: const Text('lista de livros',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const Estatistica(),
                  ),
                );
              },
              icon: const Icon(Icons.bar_chart_outlined, color: Colors.black),
              label: const Text('Estatística',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.emoji_events_rounded, color: Colors.black),
              label: const Text('Desafio',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.timer_sharp, color: Colors.black),
              label: const Text('Recorde',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.ad_units_sharp, color: Colors.black),
              label: const Text('Geral',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.info_outline, color: Colors.black),
              label: const Text('Sobre',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
          const Divider(),
          const Spacer(),
          const Divider(),
          TextButton.icon(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthOrHomePage(),));
              },
              icon: const Icon(Icons.logout_rounded, color: Colors.black),
              label: const Text('Sair',
                  style: TextStyle(color: Colors.black, fontSize: 20))),
        ],
      ),
    );
  }
}
