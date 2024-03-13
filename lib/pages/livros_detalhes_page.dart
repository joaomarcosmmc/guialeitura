
import 'package:flutter/material.dart';

import 'package:guialeitura/dados/auth.dart';
import 'package:guialeitura/dados/bd_livros.dart';

import 'package:guialeitura/models/livro.dart';


import 'package:provider/provider.dart';

class LivroDetalhePage extends StatefulWidget {

  const LivroDetalhePage(
      {
 
      super.key});

  @override
  State<LivroDetalhePage> createState() =>
      _LivroDetalhepageState();
}

String status = 'lendo';

final formKey = GlobalKey<FormState>();


class _LivroDetalhepageState extends State<LivroDetalhePage> {
  salvar() {
    formKey.currentState!.validate();
    formKey.currentState!.save();
  Provider.of<BdLivros>(context, listen: false).salvar(
    Livro(
      codigo: codigo,
        uid: Provider.of<Auth>(context, listen: false).uid ?? '',
        titulo: tituloText.text,
        autor: autorText.text.isEmpty ? '-' : autorText.text,
        genero: generoText.text.isEmpty ? '-' : generoText.text,
        qtdPaginas: int.parse(paginasText.text),
        metaDia:
            metaText.text.isEmpty ? 0 : int.parse(metaText.text),
        status: status,
        pagLidas: 0,
      
    ),
  );
    
  }

   
  Livro? _livro;
    var codigo;
    var tituloText = TextEditingController();
    var autorText = TextEditingController();
    var generoText = TextEditingController();
    var paginasText = TextEditingController();
    var metaText= TextEditingController();
    var statusText= TextEditingController();
  @override
  void initState() {
     super.initState();

  }

  @override
  void didChangeDependencies() {
   _livro = ModalRoute.of(context)!.settings.arguments as Livro;
      codigo = _livro!.codigo;
      tituloText.text = _livro!.titulo;
      autorText.text = _livro!.autor;
      generoText.text = _livro!.genero;
      paginasText.text = _livro!.qtdPaginas.toString();
      metaText.text = _livro!.metaDia.toString();
      statusText.text = _livro!.status;
      
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

   
     

    var espaco = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
    body: 
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
             
              children: [
             
                Form(
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
                                  style: TextStyle(fontSize: 15),
                                ),
                                TextFormField(
                                  initialValue: tituloText.text,
                                  onSaved: (value) =>  tituloText.text= value.toString(),
                                  validator: (value) {
                                    if (value!.length < 3) {
                                      return 'Digite pelo menos 3 caracteres';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      label: const Text('Ex: O Código da Vinci'),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                  style: TextStyle(fontSize: 15),
                                ),
                                TextFormField(
                                  initialValue: autorText.text,
                                  onSaved: (value) =>
                                autorText.text = value.toString(),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      label: const Text('Ex: Dan Brown'),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              ],
                            ),
                          ),
                      
                      
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gênero:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                TextFormField(
                                  initialValue: generoText.text,
                                  onSaved: (value) =>
                                    generoText.text = value.toString(),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      label: const Text('Ex: Romance'),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '*Páginas:',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  child: TextFormField(
                                    initialValue: paginasText.text,
                                    onSaved: (value) =>
                                      paginasText.text = value.toString(),
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
                                        contentPadding: const EdgeInsets.all(10),
                                        label: const Text('Ex: 432'),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Meta/Dia',
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  child: TextFormField(
                                    initialValue: metaText.text,
                                    onSaved: (value) =>
                                      metaText.text = value.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(10),
                                        label: const Text('Ex: 10'),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  child: Row(
                                    children: [
                                      Radio(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.values.last,
                                        activeColor: Colors.amber,
                                        value: 'lendo',
                                        groupValue: status,
                                        onChanged: (value) => setState(() {
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
                                            MaterialTapTargetSize.values.last,
                                        activeColor: Colors.amber,
                                        value: 'finalizado',
                                        groupValue: status,
                                        onChanged: (value) => setState(() {
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
                                            MaterialTapTargetSize.values.last,
                                        activeColor: Colors.amber,
                                        value: 'lista',
                                        groupValue: status,
                                        onChanged: (value) => setState(() {
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
                      const Divider(),
                      const Text(
                        'Os campos marcados com (*) são de preenchimento obrigatório.',
                        style: TextStyle(fontSize: 10),
                      ),
                      ElevatedButton(
                          onPressed: salvar, child: const Text('Salvar'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
     
    );
  }
}
