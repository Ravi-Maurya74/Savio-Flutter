import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:savio/business_logic/blocs/transaction/transaction_bloc.dart';
import 'package:savio/constants/decorations.dart';

class TransactionTileBuilder extends StatelessWidget {
  const TransactionTileBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is LoadingAllTransactionsState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AllTransactionsLoadedState) {
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return ListTile(
                  title: Text(transaction.title,style: bodyStyle,),
                  subtitle: Text(transaction.category.name,style: bodyStyle.copyWith(fontSize: 14),),
                  leading: Text(transaction.amount.toString()),
                  trailing: Text(DateFormat("d MMM y").format(DateTime.parse(transaction.date))),
                );
              },
            );
          } else if (state is ErrorAllTransactionsState) {
            return Center(
              child: Text(state.error ?? 'Error'),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
        buildWhen: (previous, current) {
          if ((previous is TransactionInitialState) || (current is AllTransactionsLoadedState || current is ErrorAllTransactionsState)) {
            return true;
          }
          return false;
        },
      ),
    );
  }
}
