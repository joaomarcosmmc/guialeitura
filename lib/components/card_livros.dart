import 'package:flutter/material.dart';
import 'package:guialeitura/components/statusLivro.dart';

import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/models/livro.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CardLivros extends StatefulWidget {
  final Livro livro;
  const CardLivros({required this.livro, super.key});

  @override
  State<CardLivros> createState() => _CardLivrosState();
}

class _CardLivrosState extends State<CardLivros> {
  var meta = 1;
  var dt = DateTime.now();

  int quantidadeDePaginas = 432;
  int paginasLidas = 20;
  int metaPorDia = 10;
  DateTime dtInit = DateTime.now().subtract(const Duration(days: 2));
  DateTime dtEnd = DateTime.now().add(const Duration(days: 3));

  double metricaMeta() {
    var t = widget.livro.dataPrevFim.day - widget.livro.dataInicio.day;
    var r = widget.livro.dataPrevFim.day - DateTime.now().day;
    var metaParcial = (r * widget.livro.metaDia) / quantidadeDePaginas;
    debugPrint(t.toString());
    debugPrint(r.toString());
    debugPrint(metaParcial.toString());
    return metaParcial;
  }

  @override
  initState() {
    debugPrint('O código do livro éfdfjasdkfjak: ${widget.livro.codigo}');
    setState(() {
      meta = widget.livro.metaDia;
    });

    super.initState();
  }

  int prev = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.livro.metaDia.toString().isNotEmpty &&
        widget.livro.metaDia > 0) {
      setState(() {
        prev = ((widget.livro.qtdPaginas - widget.livro.pagLidas) /
                widget.livro.metaDia)
            .round();
      });
    }
    var dtPrev = dt.add(Duration(days: prev));
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  debugPrint(
                      'O código do livro quando chama a página de detalhes é: ${widget.livro.codigo}');
                  Navigator.of(context).pushNamed('/livroDetalhe',
                      arguments: widget.livro.codigo);
                },
                child: Column(children: [
                  ListTile(
                      title: Text(
                        widget.livro.titulo,
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HedvigLetter'),
                      ),
                      subtitle: Text(widget.livro.autor),
                      trailing: StatusLivro(
                        livro: widget.livro,
                      )),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Previsão:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'HedvigLetter'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          prev == 0
                              ? const Text('---')
                              : Text(
                                  DateFormat('dd/MM/yyy').format(dtPrev),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'HedvigLetter'),
                                ),
                        ],
                      ),
                      Text(
                        '${widget.livro.pagLidas} Pag. Lidas',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'HedvigLetter'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('0'),
                        Stack(
                          children: [
                            Container(
                              height: 15,
                              width: constraints.minWidth * 0.8,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: FractionallySizedBox(
                                widthFactor: metricaMeta(),
                                /*(widget.livro.pagLidas == 0
                                    ? 0
                                    : StatusLivro(
                                        livro: widget.livro,
                                      ).percent(widget.livro.pagLidas,
                                        widget.livro.qtdPaginas)),*/
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 15,
                                  width: constraints.minWidth * 0.8,
                                  decoration: BoxDecoration(
                                      
                                      color: Colors.green[200]!.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(1)),
                                ),
                              ),
                            ),
                            Container(
                              height: 15,
                              width: constraints.minWidth * 0.8,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  //color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20)),
                              child: FractionallySizedBox(
                                widthFactor: (widget.livro.pagLidas == 0
                                    ? 0
                                    : StatusLivro(
                                        livro: widget.livro,
                                      ).percent(widget.livro.pagLidas,
                                        widget.livro.qtdPaginas)),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 15,
                                  width: constraints.minWidth * 0.8,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(widget.livro.qtdPaginas.toString()),
                      ],
                    ),
                  ),
                ]),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber[200]),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (meta > 1) {
                                  meta--;
                                }
                              });
                            },
                            icon: const Icon(Icons.remove)),
                        Text(
                          widget.livro.metaDia.toString().isEmpty
                              ? '0'
                              : meta.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                meta++;
                              });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.livro.pagLidas < widget.livro.qtdPaginas
                        ? () {
                            setState(() {
                              Provider.of<BdLivros>(context, listen: false)
                                  .addPagLida(context, meta, widget.livro);
                              meta = widget.livro.metaDia;
                            });
                          }
                        : null,
                    child: Text(
                      'Adicionar',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
