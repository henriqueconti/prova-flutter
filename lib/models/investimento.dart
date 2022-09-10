import 'package:financas_pessoais/models/tipo_investimento.dart';

class Investimento {
  int id;
  double valorInvestimento;
  TipoInvestimento tipoInvestimento;
  DateTime data;

  Investimento({
    required this.id,
    required this.valorInvestimento,
    required this.tipoInvestimento,
    required this.data
  });
}
