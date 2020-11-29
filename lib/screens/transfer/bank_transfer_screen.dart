import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payo/screens/pay_by_cash_screen.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payo/widgets/country_selection_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flushbar/flushbar.dart';


class BankTransferScreen extends StatefulWidget {
  // const BankTransferScreen({Key key, @required this.database, this.transfer})
  //     : super(key: key);
  // final DatabaseService database;
  // final Transfer transfer;

  @override
  _BankTransferScreenState createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  TextEditingController amountSentController = TextEditingController();
  TextEditingController amountReceivedController = TextEditingController();
  TextEditingController sendingFromController = TextEditingController();
  TextEditingController sendingToController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  List<String> currencies;
  String fromCurrency = "USD";
  String toCurrency = "GHS";
  String result;
  String rate;
  String phoneNumber;
  String accountNumber;
  String accountHolder;
  String sortCode;
  String iban;
  String bic;
  String payoFee;
  String totalPayment;


  //final db = Firestore.instance;

  //final Transfer transfers;
  // _TransferScreenState({@required this.transfers});

  _getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  final _formKey = GlobalKey<FormState>();

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
      builder: (context) => CountrySelection(),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
    _rate();
    _getUser();
  }

  Future<String> _loadCurrencies() async {
    String uri = DotEnv().env['API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    //print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = DotEnv().env['CONVERSION_API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(amountSentController.text) *
              (responseBody["rates"][toCurrency]))
          .toStringAsFixed(2);

      if (fromCurrency == toCurrency){
        payoFee = (double.parse(amountSentController.text) * 0.25).toStringAsFixed(2);
      }
      totalPayment = (double.parse(payoFee) + double.parse(result)).toStringAsFixed(2);
    });
    //print(rate);
    return "Success";
  }

  Future<String> _rate() async {
    String uri = DotEnv().env['CONVERSION_API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      rate = (responseBody["rates"][toCurrency]).toString();
    });
    //print(rate);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //fromTextController.text =
    return Scaffold(
      appBar: AppBar(
        // title: Text("Bank Transfer"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Color.fromRGBO(0, 128, 177, 1),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: currencies == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //InPut Amount Widgets
                      _buildAmountInPutWidget(),
                      _buildSendOptionWidget(),
                      _buildSendingForm(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildAmountInPutWidget() {
    return Container(
      // margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 0),
      // height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDropDownButton(fromCurrency),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 40,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'You are sending',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(165, 171, 172, 1),
                            ),
                          ),
                          TextField(
                            controller: amountSentController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                top: 3,
                                left: 0,
                                right: 0,
                                bottom: 0,
                              ),
                              isDense: true,
                            ),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromRGBO(11, 97, 130, 1),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (fromTextController) => setState(
                              () => _doConversion(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDropDownButton(toCurrency),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 40,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Recipient receives',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(165, 171, 172, 1),
                            ),
                          ),
                          TextField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: (result != null) ? result : rate,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                top: 3,
                                left: 0,
                                right: 0,
                                bottom: 0,
                              ),
                              isDense: true,
                            ),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color.fromRGBO(11, 97, 130, 1),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (fromTextController) => setState(
                              () => _doConversion(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: Text(
                'You can type the exact amount you want to send above',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(0, 128, 177, 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSendOptionWidget() {
    return Container(
      color: Color.fromRGBO(250, 250, 250, 1),
      margin: const EdgeInsets.only(
        bottom: 39,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You are sending',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 128, 177, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      amountSentController.text + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Color.fromRGBO(234, 234, 234, 1),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_icons/bank.svg',
                      alignment: Alignment.centerRight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Manual bank transfer',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 128, 177, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      amountSentController.text,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )*/
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Color.fromRGBO(234, 234, 234, 1),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_icons/bank.svg',
                      alignment: Alignment.centerRight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PayO fee',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 128, 177, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Of the amount that’s converted',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 128, 177, 1),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      (payoFee != null) ? payoFee : '0' + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Color.fromRGBO(234, 234, 234, 1),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg_icons/bank.svg',
                      alignment: Alignment.centerRight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Recipient receives',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 128, 177, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      (result != null) ? result: '0' + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Color.fromRGBO(234, 234, 234, 1),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 15,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Total payment',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 128, 177, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                           (payoFee != null) ? payoFee: '(0 ' + '$fromCurrency fee included)',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 128, 177, 1),
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      (totalPayment != null) ? totalPayment : '0' + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      fromCurrency,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return Container(
      width: 106,
      height: 72,
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 128, 177, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Center(
        child: DropdownButton(
          value: currencyCategory,
          // isExpanded: true,
          dropdownColor: Color.fromRGBO(0, 128, 177, 1),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
          ),
          underline: Divider(
            height: 0.0,
            color: Color.fromRGBO(0, 128, 177, 1),
          ),
          items: currencies
              .map((String value) => DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: <Widget>[
                        // Image.asset(""),
                        Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          onChanged: (String value) {
            if (currencyCategory == fromCurrency) {
              _onFromChanged(value);
            } else {
              _onToChanged(value);
            }
            _rate();
          },
        ),
      ),
    );
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget _buildSendingForm() {
    //User user = Provider.of<User>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Text(
              'Receiver\'s Details',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 22,
                color: const Color(0xff1280b1),
                fontWeight: FontWeight.w700,
                height: 0.9090909090909091,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              left: 28,
              bottom: 25,
            ),
            child: Row(
              children: [
                Text(
                  'United Kingdom',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    color: const Color.fromRGBO(27, 174, 203, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(

                    Icons.keyboard_arrow_down,
                    color: const Color.fromRGBO(27, 174, 203, 1),
                  ),
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Account holders name',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xff0b6182),
                          height: 1.1111111111111112,
                        ),
                        onChanged: (val) =>
                            setState(() => accountHolder = val)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Account number',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xff0b6182),
                          height: 1.1111111111111112,
                        ),
                        onChanged: (val) =>
                            setState(() => accountNumber = val)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'UK sortcode',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xff0b6182),
                          height: 1.1111111111111112,
                        ),
                        onChanged: (val) => setState(() => sortCode = val)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'BIC',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'this field is Required';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xff0b6182),
                          height: 1.1111111111111112,
                        ),
                        onChanged: (val) => setState(() => bic = val)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'IBAN',
                          hintStyle: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                        ),
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return 'this field is Required';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xff0b6182),
                          height: 1.1111111111111112,
                        ),
                        onChanged: (val) => setState(() => iban = val)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Button(
                    borderRadius: 30,
                    title: 'Continue',
                    function: () => _createTransfer(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createTransfer(BuildContext context) async {
    if (_validateAndSaveForm()) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      await FirestoreDatabase(uid: user.uid).bankTransfer(
          receiverNameController.text,
          phoneNumber,
          fromCurrency,
          toCurrency,
          'Transfer',
          sendingToController.text,
          sendingFromController.text,
          double.parse(result),
          int.parse(amountSentController.text),
          accountNumber,
          sortCode,
          'SWFTBIC',
          iban,
          'pending',
          Timestamp.now());
    }
    transferFlushbar(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PayByCashScreen()),
    );
  }
}


void transferFlushbar(BuildContext context) {
  Flushbar(
    message: 'just testing this rasclart',
    mainButton: FlatButton(
      child: Text(
        'Click Me',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      onPressed: () {},
    ),
    duration: Duration(seconds: 3),
  )..show(context);
}