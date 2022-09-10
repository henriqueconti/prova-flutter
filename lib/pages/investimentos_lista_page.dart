import 'package:financas_pessoais/models/investimento.dart';
import 'package:financas_pessoais/repository/investimento_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvestimentosListaPage extends StatefulWidget {
  const InvestimentosListaPage({Key? key}) : super(key: key);

  @override
  State<InvestimentosListaPage> createState() => _InvestimentosListaPageState();
}

class _InvestimentosListaPageState extends State<InvestimentosListaPage> {
  final _investimentoRepository = InvestimentoRepository();
  late Future<List<Investimento>> _futureInvestimentos;

  @override
  void initState() {
    carregarInvestimentos();
    super.initState();
  }

  void carregarInvestimentos() {
    _futureInvestimentos = _investimentoRepository.listarInvestimento();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Investimentos')),
      body: FutureBuilder<List<Investimento>>(
        future: _futureInvestimentos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final investimentos = snapshot.data ?? [];
            return ListView.separated(
              itemCount: investimentos.length,
              itemBuilder: (context, index) {
                final investimento = investimentos[index];
                return Dismissible(
                  key: ,
                  child: ListTile(
                    title: Text("teste"),
                    subtitle: Text(
                        DateFormat('MM/dd/yyyy').format(investimento.data)),
                    trailing: Text(
                      NumberFormat.simpleCurrency(locale: 'pt_BR')
                          .format(investimento.valorInvestimento),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.green),
                    ),
                  ),
                );
                // return Slidable(
                //   endActionPane: ActionPane(
                //     motion: const ScrollMotion(),
                //     children: [
                //       SlidableAction(
                //         onPressed: (context) async {
                //           await _transacaoRepository
                //               .removerLancamento(transacao.id!);

                //           ScaffoldMessenger.of(context).showSnackBar(
                //               const SnackBar(
                //                   content:
                //                       Text('Lançamento removido com sucesso')));

                //           setState(() {
                //             transacoes.removeAt(index);
                //           });
                //         },
                //         backgroundColor: Colors.red,
                //         foregroundColor: Colors.white,
                //         icon: Icons.delete,
                //         label: 'Remover',
                //       ),
                //       SlidableAction(
                //         onPressed: (context) async {
                //           var success = await Navigator.of(context).push(
                //             MaterialPageRoute(
                //               builder: (BuildContext context) =>
                //                   TransacaoCadastroPage(
                //                 transacaoParaEdicao: transacao,
                //               ),
                //             ),
                //           ) as bool?;

                //           if (success != null && success) {
                //             setState(() {
                //               carregarTransacoes();
                //             });
                //           }
                //         },
                //         backgroundColor: Colors.blue,
                //         foregroundColor: Colors.white,
                //         icon: Icons.edit,
                //         label: 'Editar',
                //       ),
                //     ],
                //   ),
                //   child: TransacaoListItem(transacao: transacao),
                // );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return Container();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () async {
      //       bool? transacaoCadastrada = await Navigator.of(context)
      //           .pushNamed('/transacao-cadastro') as bool?;

      //       if (transacaoCadastrada != null && transacaoCadastrada) {
      //         setState(() {
      //           carregarTransacoes();
      //         });
      //       }
      //     },
      //     child: const Icon(Icons.add)),
    );
  }
}
