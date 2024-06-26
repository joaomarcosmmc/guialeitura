import 'package:flutter/material.dart';
import 'package:guialeitura/pages/livros_lidos.dart';
import 'package:guialeitura/dados/bd_livros.dart';
import 'package:guialeitura/dados/auth.dart';
import 'package:guialeitura/pages/auth_or_home_page.dart';
import 'package:guialeitura/pages/livros_detalhes_page.dart';
import 'package:guialeitura/utils/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,BdLivros>(
          create: (_) => BdLivros('','',[]),
          update: (ctx, auth, previous) {
            return BdLivros(auth.token??'',auth.uid??'', previous?.bdLivros ?? [] );
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
         colorScheme: ColorScheme.fromSeed(
          primary: Colors.amber,
                  seedColor: Colors.amber,
        
         ),
           primaryColor: Colors.black,
           secondaryHeaderColor: Colors.red
           

          
          
        
          
            
      
        ),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          RoutesPage().AUTH_OR_HOMEPAGE: (context) => const AuthOrHomePage(),
          RoutesPage().LIVRODETALHE: (context) => const LivroDetalhePage(),
          RoutesPage().LIVROSLIDOS: (context) => const ListagemLivrosLidos(),
        },
      ),
    );
  }
}
