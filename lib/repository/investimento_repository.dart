import 'package:financas_pessoais/database/database_manager.dart';
import 'package:financas_pessoais/models/investimento.dart';
import 'package:financas_pessoais/models/tipo_investimento.dart';

class InvestimentoRepository {
  Future<List<Investimento>> listarInvestimento() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT id, tipoInvestimento, valor, data
          FROM investimentos
          ''');
    return rows
        .map(
          (row) => Investimento(
            id: row['id'],
            tipoInvestimento: TipoInvestimento.values[row['tipoInvestimento']],
            valorInvestimento: row['valor'],
            data: DateTime.fromMillisecondsSinceEpoch(row['data'])
          ),
        )
        .toList();
  }

  // Future<void> cadastrarTransacao(Transacao transacao) async {
  //   final db = await DatabaseManager().getDatabase();

  //   db.insert("transacoes", {
  //     "id": transacao.id,
  //     "descricao": transacao.descricao,
  //     "tipoTransacao": transacao.tipoTransacao.index,
  //     "valor": transacao.valor,
  //     "data": transacao.data.millisecondsSinceEpoch,
  //     "observacao": transacao.observacao,
  //     "categoriaId": transacao.categoria.id,
  //   });
  // }

  // Future<void> removerLancamento(int id) async {
  //   final db = await DatabaseManager().getDatabase();
  //   await db.delete('transacoes', where: 'id = ?', whereArgs: [id]);
  // }

  // Future<int> editarTransacao(Transacao transacao) async {
  //   final db = await DatabaseManager().getDatabase();
  //   return db.update(
  //       'transacoes',
  //       {
  //         "id": transacao.id,
  //         "descricao": transacao.descricao,
  //         "tipoTransacao": transacao.tipoTransacao.index,
  //         "valor": transacao.valor,
  //         "data": transacao.data.millisecondsSinceEpoch,
  //         "observacao": transacao.observacao,
  //         "categoriaId": transacao.categoria.id,
  //       },
  //       where: 'id = ?',
  //       whereArgs: [transacao.id]);
  // }
}
