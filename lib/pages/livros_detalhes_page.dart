import 'package:flutter/material.dart';


import 'package:guialeitura/dados/auth.dart';
import 'package:guialeitura/dados/bd_livros.dart';

import 'package:guialeitura/models/livro.dart';

import 'package:provider/provider.dart';

class LivroDetalhePage extends StatefulWidget {
  const LivroDetalhePage({super.key});

  @override
  State<LivroDetalhePage> createState() => _LivroDetalhepageState();
}

  

final formKey = GlobalKey<FormState>();

class _LivroDetalhepageState extends State<LivroDetalhePage> {
  bool isLoad = false;
  bool isDeleting = false;
  String status = '';
  salvar() async {
   
    isLoad=true;
    formKey.currentState!.validate();
    formKey.currentState!.save();

    await Provider.of<BdLivros>(context, listen: false).salvar(
      Livro(
        codigo: codigoL,
        uid: Provider.of<Auth>(context, listen: false).uid ?? '',
        titulo: tituloText.text,
        autor: autorText.text.isEmpty ? '-' : autorText.text,
        genero: generoText.text.isEmpty ? '-' : generoText.text,
        qtdPaginas: int.parse(paginasText.text),
        metaDia: metaText.text.isEmpty ? 0 : int.parse(metaText.text),
        status: livro!.qtdPaginas == livro!.pagLidas ? 'finalizado' : 'lendo',
        pagLidas: int.parse(pagLidasText.text),
        dataInicio: DateTime.now().subtract(const Duration(days: 2)), 
        dataPrevFim: DateTime.now().add(const Duration(days: 2)),
      ) ,
    ).then((value) =>setState(() {
      isLoad =false;
      status = livro!.qtdPaginas == livro!.pagLidas? 'finalizado':'lendo';
    }));
  }

  delete(){
    isDeleting = true;
    Provider.of<BdLivros>(context, listen: false).delete(codigoL!).then((value) {
    setState(() {
      isDeleting = false;
    });
    Navigator.of(context).pop();
    });
  }

  String? codigoL;
  Livro? livro;

  var tituloText = TextEditingController();
  var autorText = TextEditingController();
  var generoText = TextEditingController();
  var paginasText = TextEditingController();
  var metaText = TextEditingController();
  var statusText = TextEditingController();
  var pagLidasText = TextEditingController();



  @override
  void didChangeDependencies() {
    var provider = Provider.of<BdLivros>(context, listen: false).bdLivros;
    codigoL = ModalRoute.of(context)!.settings.arguments as String;
     livro = provider.where((element) => element.codigo == codigoL).reduce((value, element) => element);


    tituloText.text = livro!.titulo;
    autorText.text = livro!.autor;
    generoText.text = livro!.genero;
    paginasText.text = livro!.qtdPaginas.toString();
    metaText.text = livro!.metaDia.toString();
    statusText.text = livro!.status;
    pagLidasText.text = livro!.pagLidas.toString();

    status = livro!.qtdPaginas == livro!.pagLidas ? 'finalizado' : 'lendo';
    
    super.didChangeDependencies();

  }

  double percentSizeWidthForm(context, deviceSize) {
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

  double percent(int qtdPagLida, int qtdPagTotal) {
    
    return qtdPagLida / qtdPagTotal;

  }
  
  

  @override
  Widget build(BuildContext context) {
  
    AppBar appBarTeste = AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(livro!.titulo, style:const  TextStyle(fontFamily: 'HedvigLetter'),),
        actions: [
          IconButton(onPressed: delete, icon: const Icon(Icons.delete))
        ],
      );

 
    var espaco = MediaQuery.of(context);
  
    return Scaffold(
    
      appBar: appBarTeste,
      body: 
      isDeleting?
      const Center(
        child: CircularProgressIndicator(),
      ):

         Padding(
          padding: const EdgeInsets.all(10),
           child: Container(
            
          padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
            ),
            
             child: SingleChildScrollView(
                
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: espaco.size.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '*Título:',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                initialValue: tituloText.text,
                                onSaved: (value) =>
                                    tituloText.text = value.toString(),
                                validator: (value) {
                                  if (value!.length < 3) {
                                    return 'Digite pelo menos 3 caracteres';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    label:
                                        const Text('Ex: O Código da Vinci'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: espaco.size.width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Autor(a):',
                                style: TextStyle(fontSize: 18),
                              ),
                              TextFormField(
                                
                                
                                initialValue: autorText.text,
                                onSaved: (value) =>
                                    autorText.text = value.toString(),
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.all(10),
                                    label: const Text('Ex: Dan Brown'),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    )),
                              ),
                            ],
                          ),
                        ),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: (MediaQuery.of(context).size.width *
                                      percentSizeWidthForm(
                                          context, espaco)) *
                                  0.50,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gênero:',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextFormField(
                                    initialValue: generoText.text,
                                    onSaved: (value) =>
                                        generoText.text = value.toString(),
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        label: const Text('Ex: Romance'),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '*Páginas:',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width *
                                                percentSizeWidthForm(
                                                    context, espaco)) *
                                            0.30,
                                    child: TextFormField(
                                      initialValue: paginasText.text,
                                      onSaved: (value) => paginasText.text =
                                          value.toString(),
                                      validator: (value) {
                                        if (value!.trim().isEmpty) {
                                          return 'Digite um valor!';
                                        } else if (int.parse(value) < 1) {
                                          return 'Digite um número válido';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          label: const Text('Ex: 432'),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Meta/Dia',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width *
                                                percentSizeWidthForm(
                                                    context, espaco)) *
                                            0.30,
                                    child: TextFormField(
                                      initialValue: metaText.text,
                                      onSaved: (value) =>
                                          metaText.text = value.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        label: const Text('Ex: 10'),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Pag Lidas',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width:
                                        (MediaQuery.of(context).size.width *
                                                percentSizeWidthForm(
                                                    context, espaco)) *
                                            0.30,
                                    child: TextFormField(
                                      initialValue: pagLidasText.text,
                                      onSaved: (value) => pagLidasText
                                          .text = value.toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        label: const Text('Ex: 10'),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Radio(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize
                                                  .values.last,
                                          activeColor: Colors.amber,
                                          value: 'lendo',
                                          groupValue: status,
                                          onChanged: (value) =>
                                              setState(() {
                                            status = 'lendo';
                                          }),
                                        ),
                                        const Text('Lendo'),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Radio(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize
                                                  .values.last,
                                          activeColor: Colors.amber,
                                          value: 'finalizado',
                                          groupValue: status,
                                          onChanged: (value) =>
                                              setState(() {
                                            status = 'finalizado';
                                          }),
                                        ),
                                        const Text('Finalizado'),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        Radio(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize
                                                  .values.last,
                                          activeColor: Colors.amber,
                                          value: 'lista',
                                          groupValue: status,
                                          onChanged: (value) =>
                                              setState(() {
                                            status = 'lista';
                                          }),
                                        ),
                                        const Text('Lista'),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              const Text('0'),
                              Container(
                                height: 15,
                                width: (MediaQuery.of(context).size.width *
                                        percentSizeWidthForm(
                                            context, espaco)) *
                                    0.70,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.circular(20)),
                                child: FractionallySizedBox(
                                  widthFactor: livro?.pagLidas == 0
                                      ? 0
                                      : percent(livro?.pagLidas??1, livro?.qtdPaginas??1),
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 15,
                                    width:
                                        (MediaQuery.of(context).size.width *
                                                percentSizeWidthForm(
                                                    context, espaco)) *
                                            0.70,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              Text('${livro!.qtdPaginas}'),
                            ],
                          ),
                        ),
                        const Divider(),
                        const Text(
                          'Os campos marcados com (*) são de preenchimento obrigatório.',
                          style: TextStyle(fontSize: 10),
                        ),
                        
                        !isLoad? ElevatedButton(
                            onPressed: () {
                              setState(() {
                                salvar();
                              });
                            },
                            child: Text('salvar',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor))):const Padding(
                        
                                  padding:  EdgeInsets.symmetric(vertical: 10),
                                  child:  Center(
                                      
                                      child:  CircularProgressIndicator()),
                                )
                      ],
                    ),
                  ),
                ),
           ),
         ),
          );
  
  }
}
