import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/trasfer_type_widget.dart';

import 'bank_transfer_screen.dart';
import 'cash_transfer_screen.dart';

enum selectedValue { manualBankTransfer, cashPayment }

class TransferMoneyScreen extends StatefulWidget {
  static const routeName = 'Transfer_money_screen';
  @override
  _TransferMoneyScreenState createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends State<TransferMoneyScreen> {
  bool manualBankTransfer = true;
  bool cashPayment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: InkWell(
        //     onTap: () => Navigator.of(context).pop(),
        //     child: Icon(
        //       Icons.clear,
        //       color: Color(0xff1BAECB),
        //     )),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  manualBankTransfer = true;
                  cashPayment = !manualBankTransfer;
                  print(
                      'manual bank transfer =$manualBankTransfer , cash payment =$cashPayment');
                  // Navigator.of(context).pushNamed(TransferSendScreen.routeName);
                });
              },
              child: TransferTypeWidget(
                label: 'Manual bank transfer',
                icon: 'assets/svg_icons/bank.svg',
                checked: manualBankTransfer,
                bordered: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  cashPayment = true;
                  manualBankTransfer = !cashPayment;
                  print(
                      'cash payment = $cashPayment , manualBankTransfer = $manualBankTransfer');
                  // Navigator.of(context).pushNamed(PayByCashScreen.routeName);
                });
              },
              child: TransferTypeWidget(
                label: 'Cash payment',
                icon: 'assets/svg_icons/cash.svg',
                checked: cashPayment,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Button(
              borderRadius: 10,
              title: 'Continue',
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => cashPayment ?? false ? CashTransferScreen(): BankTransferScreen())
                );

                /*  Navigator.of(context).pushNamed(cashPayment ?? false
                    ? PayByCashScreen.routeName
                    : TransferSendScreen.routeName);*/
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => SettingsScreen()),
// );