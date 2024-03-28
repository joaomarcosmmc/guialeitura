class Livro{
  String? codigo;
  String uid;
  String titulo;
  String autor;
  String genero;
  int pagLidas;
  int qtdPaginas;
  int metaDia;
  String status;
  DateTime dataInicio;
  DateTime dataPrevFim;

  Livro({
    this.codigo,
    required this.titulo,
    required this.uid,
    required this.autor,
    required this.genero,
    required this.pagLidas,
    required this.qtdPaginas,
    required this.metaDia,
    required this.status,
    required this.dataInicio,
    required this.dataPrevFim,
  });


}