import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payo/models/transfers.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/transaction_widget.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  static const routeName = 'transactions_history_screen';
  //TransactionHistoryScreen();
  //final DatabaseService database;
  //final Transfer transfer;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1280B1),
        body: buildContents(context));
  }
}

Widget buildContents(BuildContext context) {
  final database = Provider.of<DatabaseService>(context);
  return StreamBuilder<List<Transfer>>(
    stream: database.transferStream(),
    builder: (context, snapshot) {
       if (snapshot.hasData) {
        final transfer = snapshot.data;
        //print(transfer);
        List<TransactionWidget> testWidgets = [];
        // final dateTime =
        // transfer.map((transfer) => (transfer.date).toDate()).toString();
        final test =
        transfer.map((transfer) {
          final receiverName = transfer.receiverName;
          final status = transfer.status;
          final amountSent = transfer.amountSent;
          final dateSent = transfer.date.toDate().toString().split(' ').elementAt(0);
          final testWidget = TransactionWidget(
              name: receiverName,
              status: status,
              price: amountSent,
              dateSent: dateSent);
          testWidgets.add(testWidget);
        }).toList();
        //print(test);
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 22,
                                color: const Color(0xff1280b1),
                                fontWeight: FontWeight.w700,
                                height: 0.9090909090909091,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.search,
                                color: Color(0xff0080B1),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 0.7,
                        ),
                        Expanded(
                          child: ListView(
                            children: testWidgets,

                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
