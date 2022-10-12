import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalmoneymanager/models/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this.transactions);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text("No transactions added yet!!",
                    style: TextStyle(
                      fontSize: 25,
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return  Card(
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: FittedBox(
                           child: Text(
                                'Rs:${transactions[index].amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                              ),
                         ),
                       ), 
                    ),
                    title:  Text(transactions[index].title,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                
                                    subtitle:  Text(
                              DateFormat.yMMMd().format(
                                transactions[index].date,
                              ),
                              style: TextStyle(color: Colors.black54,fontSize: 15),
                            )
                  ),
                );

                //Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         padding: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Theme.of(context).primaryColor,
                //                 width: 2)),
                //         margin:
                //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //         child: Text(
                //           'Rs:${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold,
                //               color: Theme.of(context).primaryColor),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(transactions[index].title,
                //               style: TextStyle(
                //                   fontSize: 16, fontWeight: FontWeight.bold)),
                //           Text(
                //             DateFormat().format(
                //               transactions[index].date,
                //             ),
                //             style: TextStyle(color: Colors.grey),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
