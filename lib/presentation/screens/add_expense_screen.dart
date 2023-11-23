import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:intl/intl.dart';
import 'package:savio/business_logic/blocs/category/category_cubit.dart';
import 'package:savio/business_logic/blocs/single_transaction/single_transaction_cubit.dart';
import 'package:savio/business_logic/blocs/transaction/transaction_bloc.dart';
import 'package:savio/presentation/widgets/custom_appbar.dart';
import 'package:savio/data/models/transaction.dart';

// enum Category { food, travel, work, leisure }

final formatter =
    DateFormat("yyyy-MM-dd"); //DateFormat("yyyy-MM-dd").format(DateTime.now())

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key, required this.buildContext});
  final BuildContext buildContext;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  int _selectedCategory = 1;
  DateTime? _selectedDate;
  bool loading = false;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories =
        (widget.buildContext.watch<CategoryCubit>().state as CategoryLoaded)
            .categories;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return BlocListener<SingleTransactionCubit, SingleTransactionState>(
      // bloc: widget.buildContext.read<SingleTransactionCubit>(),
      listener: (context, state) {
        if (state is SingleTransactionUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transaction Added'),
              duration: Duration(seconds: 5),
            ),
          );
        } else if (state is SingleTransactionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: SizedBox(
        height: double.infinity,
        child: ModalProgressHUD(
          inAsyncCall: loading,
          dismissible: false,
          opacity: 0.1,
          color: const Color(0xFF50559a),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomAppbar(
                  title: 'Add Expense',
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 50,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    // focusColor: Color(0xFF50559a),   not working
                    label: Text('Title'),
                  ),
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.id,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                    const Spacer(),
                    Expanded(
                      child: TextField(
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefix: Text('\$'),
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        _selectedDate == null
                            ? "No Date Selected"
                            : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.w400)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Color.fromARGB(255, 114, 122, 226),
                      ),
                      splashRadius: 20,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 77, 83, 163),
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        bool status = await context
                            .read<SingleTransactionCubit>()
                            .addNewTransaction({
                          "title": _titleController.text,
                          "amount": double.parse(_amountController.text),
                          "category": _selectedCategory,
                          "date": _selectedDate!=null?formatter.format(_selectedDate!):formatter.format(DateTime.now()),
                        });
                        setState(() {
                          loading = false;
                        });
                        if (status) {
                          if (!context.mounted) return;
                          widget.buildContext
                              .read<TransactionBloc>()
                              .add(FetchAllTransactionsEvent());
                        }
                        if (!mounted) return;
                        Navigator.pop(context);
                      },
                      child: const Text('Save Expenses'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
