import 'package:flutter/material.dart';
import 'package:guialeitura/components/menu_lateral.dart';


class Estatistica extends StatelessWidget {
  const Estatistica({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.60,
        child: const MenuLateral(),),
      appBar: AppBar(),
      body: const Center(
        child: Text('página de estatística!'),
      ),
    );
  }
}