
import 'package:flutter/material.dart';

import 'package:guialeitura/models/auth.dart';

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

   TextEditingController? tituloText;
   TextEditingController? autorText;
   TextEditingController? generoText;
   TextEditingController? paginasText;
   TextEditingController? metaText;
   TextEditingController? statusText;

String status = 'lendo';

final formKey = GlobalKey<FormState>();

class _LivroDetalhepageState extends State<LivroDetalhePage> {
  salvar() {
    formKey.currentState!.validate();

    
      Livro(
        uid: Provider.of<Auth>(context, listen: false).uid ?? '',
        titulo: tituloText!.text,
        autor: autorText!.text.isEmpty ? '-' : autorText!.text,
        genero: generoText!.text.isEmpty ? '-' : generoText!.text,
        qtdPaginas: int.parse(paginasText!.text),
        metaDia:
            metaText!.text.isEmpty ? 0 : int.parse(metaText!.text),
        status: status,
        pagLidas: 0,
      
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var espaco = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
    body: //Padding(
        // padding: EdgeInsets.only(
        //      top: espaco.size.height * 0.05),
        //child:
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
                                  controller: tituloText,
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
                                  controller: autorText,
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
                                  controller: generoText,
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
                                    controller: paginasText,
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
                                    controller: metaText,
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
      // ),
    );
  }
}
