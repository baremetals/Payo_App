import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:payo/models/transfers.dart';
import 'package:payo/screens/pay_by_cash_screen.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/country_selection_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CashTransferScreen extends StatefulWidget {
  const CashTransferScreen({Key key, @required this.database, this.transfer})
      : super(key: key);
  final DatabaseService database;
  final Transfer transfer;

  @override
  _CashTransferScreenState createState() => _CashTransferScreenState();
}

class _CashTransferScreenState extends State<CashTransferScreen> {
  TextEditingController _amountSentController = TextEditingController();
  TextEditingController _sendingFromController = TextEditingController();
  TextEditingController _sendingToController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  List<String> _currencies;
  String _fromCurrency = "USD";
  String _toCurrency = "GHS";
  String _result;
  String rate;
  String _phoneNumber;
  String payoFee;
  String _totalPayment;

  //final db = Firestore.instance;

  //final Transfer transfers;
  // _TransferScreenState({@required this.transfers});

  _getUser() async {
    User user = FirebaseAuth.instance.currentUser;
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

  // void _fee() {
  //   if (_fromCurrency == _toCurrency){
  //     payoFee = (double.parse(_amountSentController.text) * 0.25).toString() ;
  //   } else{
  //     payoFee = '0';
  //   }
  // }

  Future<String> _loadCurrencies() async {
    String uri = DotEnv().env['API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    _currencies = curMap.keys.toList();
    setState(() {

    });
    //print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = DotEnv().env['CONVERSION_API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      _result = (double.parse(_amountSentController.text) *
              (responseBody["rates"][_toCurrency]))
          .toStringAsFixed(2);
      if (_fromCurrency == _toCurrency){
        payoFee = (double.parse(_amountSentController.text) * 0.25).toStringAsFixed(2);
      } else{
        payoFee = '0';
      }
      _totalPayment = (double.parse(payoFee) + double.parse(_result)).toStringAsFixed(2);
    });
    print(_totalPayment);
    return "Success";
  }

  Future<String> _rate() async {
    String uri = DotEnv().env['CONVERSION_API_URL'];
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      rate = (responseBody["rates"][_toCurrency]).toString();
    });
    print(rate);
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      _fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      _toCurrency = value;
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
      body: _currencies == null
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
                  _buildDropDownButton(_fromCurrency),
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
                            controller: _amountSentController,
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
                  _buildDropDownButton(_toCurrency),
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
                              text: (_result != null) ? _result : rate,
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
                      _amountSentController.text + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _fromCurrency,
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
                        'Cash transfer',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 128, 177, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
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
                      _fromCurrency,
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
                      (_result != null) ? _result: '0' + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _toCurrency,
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
                        (payoFee != null) ? payoFee: '(0 ' + '$_fromCurrency fee included)',
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
                      (_totalPayment != null) ? _totalPayment : '0' + ' ',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 128, 177, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _fromCurrency,
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
          items: _currencies
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
            if (currencyCategory == _fromCurrency) {
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

  // Future<void> _createTransfer(BuildContext context) async {
  //   if (_validateAndSaveForm()) {
  //     //final id = widget.transfer.id ;
  //     final transfer = Transfer(
  //         //id: id,
  //         receiverName: _receiverNameController.text,
  //         phoneNumber: _phoneNumber,
  //         sendingCurrency: _fromCurrency,
  //         receivingCurrency: _toCurrency,
  //         paymentType: 'Cash',
  //         destination: _sendingToController.text,
  //         from: _sendingFromController.text,
  //         amountReceived: double.parse(_result).truncateToDouble(),
  //         amountSent: int.parse(_amountSentController.text),
  //         status: 'pending',
  //         date: Timestamp.now());
  //     await widget.database.setTransfer(transfer);
  //   }
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => PayByCashScreen()),
  //   );
  // }

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
          // Text(
          //   'Receiver\'s Details',
          //   style: TextStyle(
          //     fontFamily: 'SF Pro Display',
          //     fontSize: 22,
          //     color: const Color(0xff1280b1),
          //     fontWeight: FontWeight.w700,
          //     height: 0.9090909090909091,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          SizedBox(
            height: 25,
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
                        border:
                            Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                      controller: _receiverNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
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
                      onChanged: (receiverNameController) =>
                          setState(() => receiverNameController),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone number',
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
                            setState(() => _phoneNumber = val)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                      controller: _sendingFromController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Sending from',
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
                        onChanged: (sendingFromController) =>
                            setState(() => sendingFromController)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                    child: TextFormField(
                      controller: _sendingToController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Sending to',
                        hintStyle: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                      ),
                      validator: (sendingToController) {
                        if (sendingToController.isEmpty) {
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
                      onChanged: (sendingToController) =>
                          setState(() => sendingToController),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Button(
                    borderRadius: 30,
                    title: 'Continue',
                    function: () => _newTransfer(context),
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

  Future<void> _newTransfer(BuildContext context) async {
    if (_validateAndSaveForm()) {
      User user = FirebaseAuth.instance.currentUser;
      await FirestoreDatabase(uid: user.uid).createTransfer(
          _receiverNameController.text,
          _phoneNumber,
          _fromCurrency,
          _toCurrency,
          'Cash',
          _sendingToController.text,
          _sendingFromController.text,
          double.parse(_result),
          int.parse(_amountSentController.text),
          'pending',
          Timestamp.now());
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PayByCashScreen()),
    );
  }
}

