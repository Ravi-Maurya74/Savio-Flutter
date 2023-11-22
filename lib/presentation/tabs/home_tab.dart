import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/single_transaction/single_transaction_cubit.dart';
import 'package:savio/presentation/screens/add_expense_screen.dart';
import 'package:savio/presentation/widgets/circular_icon_card.dart';
import 'package:savio/presentation/widgets/graph_generator.dart';
import 'package:savio/presentation/widgets/transaction_tile_builder.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const CircleBorder(),
        closedColor: const Color(0xFF50559a),
        openColor: Theme.of(context)
            .scaffoldBackgroundColor, //const Color(0xFF16161e),
        middleColor: const Color(0xFFd988a1),
        closedBuilder: (context, action) => Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF50559a),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
        openBuilder: (_, action) => BlocProvider(
          create: (context) => SingleTransactionCubit(
              dio: Dio(),
              authToken: context.read<AuthCubit>().state.authToken!),
          child: AddExpenseScreen(buildContext: context),
        ),
      ),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Savio',
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
          ),
          centerTitle: true,
        ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
              ),
              const GraphCarousel(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ElongatedContainer(),
                  CircularIconCard(
                    alertIcon: const Icon(
                      Icons.credit_score,
                      color: Colors.white,
                    ),
                    onPress: () {
                      showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text('Credit score'),
                              content: const Text(
                                  'Aaj tak kisi ne credit diya bhi hai!\naya bada credit score dekhne'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('okay')),
                              ],
                            )),
                      );
                    },
                  ),
                  CircularIconCard(
                    alertIcon: const Notificationtile(isCrossed: true),
                    // context.watch<Student>().savings < 0
                    //     ? const Notificationtile(isCrossed: true)
                    //     : const Notificationtile(isCrossed: false),
                    onPress: () {
                      // student.savings < 0
                      //     ? showDialog(
                      //         context: context,
                      //         builder: ((context) => AlertDialog(
                      //               title: const Text('Budget Exceeded'),
                      //               content: Text(
                      //                   'Your total monthly expenses has crossed your monthly budget by \$$expenseExceedBy'),
                      //               actions: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: const Text('okay')),
                      //               ],
                      //             )),
                      //       )
                      //     : showDialog(
                      //         context: context,
                      //         builder: ((context) => AlertDialog(
                      //               title: const Text('Within Budget'),
                      //               content: const Text(
                      //                   'Your total monthly expenses has not crossed your monthly budget'),
                      //               actions: [
                      //                 TextButton(
                      //                     onPressed: () {
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: const Text('okay')),
                      //               ],
                      //             )),
                      //       );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.9,
                        indent: 5,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      'Your Transactions',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white70, fontWeight: FontWeight.w400),
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 0.9,
                      indent: 10,
                      endIndent: 5,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const TransactionTileBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

class ElongatedContainer extends StatelessWidget {
  const ElongatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 8, top: 8),
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF50559a).withOpacity(0.7),
                  const Color(0xFFd988a1).withOpacity(0.7),

                  //50559a
                ]),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(0, 1),
                // color: Color.fromARGB(255, 194, 194, 194),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Monthly Budget:   400',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class Notificationtile extends StatelessWidget {
  final bool isCrossed;
  const Notificationtile({super.key, required this.isCrossed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        isCrossed
            ? Positioned(
                left: 15,
                bottom: 15,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 8,
                    minHeight: 8,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
