import 'package:flutter/material.dart';
import 'package:guialeitura/models/livro.dart';

class StatusLivro extends StatelessWidget {
  final Livro livro;
  const StatusLivro({required this.livro, super.key});

  double percent(int qtdPagLida, int qtdPagTotal) {
    return qtdPagLida / qtdPagTotal;
  }

  Widget get statusDoLivro {
    if (livro.status == 'lendo') {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.5),
          alignment: Alignment.center,
          width: 60,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${(percent(livro.pagLidas, livro.qtdPaginas) * 100).toStringAsFixed(0)}%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Concluído',
                style: TextStyle(fontSize: 12),
              )
            ],
          ));
    } else if(livro.status == 'finalizado') {
      return Icon(Icons.verified_outlined, color: Colors.green[400], size: 50,);
    }else{
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: statusDoLivro,
    );
  }
}
