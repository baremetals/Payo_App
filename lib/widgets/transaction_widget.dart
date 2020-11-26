import 'package:flutter/material.dart';
import 'package:payo/models/transfers.dart';
import 'package:payo/services/database.dart';
import 'package:provider/provider.dart';

class TransactionWidget extends StatelessWidget {
  final String name;
  final String status;
  final int price;

  TransactionWidget({this.status, this.price, this.name});
  @override
  Widget build(BuildContext context) {
        return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),

                            //TODO : overflow
                            child: Text(
                              name == 'payment type'
                                  ? 'Cash payment'
                                  : 'Bank transfer to $name',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontWeight: name == 'Cash payment'
                                    ? FontWeight.normal
                                    : FontWeight.w600,
                                color: const Color(0xff0b6182),
                                height: 1.4285714285714286,
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 14,
                              color: status == 'Pending'
                                  ? Color(0xffff5800)
                                  : Color(0xff0b6182),
                              fontWeight: FontWeight.w600,
                              height: 1.4285714285714286,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Text(
                        '${price.ceil()} GBP',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 14,
                          color: const Color(0xff0b6182),
                          fontWeight: FontWeight.w700,
                          height: 1.4285714285714286,
                        ),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 0.7,
                  ),
                ],
              );
        }
      }
    //);
  //}

//}

class TransferWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return StreamBuilder<List<Transfer>>(
      stream: database.transferStream(),
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      final transfer = snapshot.data;
      //print(transfer);
      List<TransactionWidget> testWidgets = [];
      final made =
      transfer.map((transfer) {
        final receiverName = transfer.receiverName;
        final status = transfer.status;
        final amountSent = transfer.amountSent;
        final testWidget = TransactionWidget(name: receiverName,
            status: status,
            price: amountSent);
        testWidgets.add(testWidget);
        print(receiverName);
      }).toList();
      //print(receiverName);
    }
    return Center(child: CircularProgressIndicator());
    },

    );
  }
}
