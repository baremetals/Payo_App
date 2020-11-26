import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payo/models/transfers.dart';
import 'package:payo/screens/pay_by_cash_screen.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/country_selection_widget.dart';

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
  String sortCode;
  String iban;
  String bic;

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
    String uri = "https://openexchangerates.org/api/latest.json?app_id=c4163e84d9ac4c6ebe5a19994780a145";
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
    String uri =
        "https://openexchangerates.org/api/latest.json?app_id=c4163e84d9ac4c6ebe5a19994780a145&base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(amountSentController.text) *
          (responseBody["rates"][toCurrency]))
          .toStringAsFixed(2);
    });
    //print(rate);
    return "Success";
  }

  Future<String> _rate() async {
    String uri =
        "https://openexchangerates.org/api/latest.json?app_id=c4163e84d9ac4c6ebe5a19994780a145&base=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      rate = (responseBody["rates"][toCurrency]).toString();
    });
    print(rate);
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
        title: Text("Bank Transfer"),
      ),
      body: currencies == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          padding:
          EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 150),
                  child: Card(
                    elevation: 3.0,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ListTile(
                          title: TextField(
                              controller: amountSentController,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              keyboardType:
                              TextInputType.numberWithOptions(
                                  decimal: true),
                              onChanged: (fromTextController) =>
                                  setState(() => _doConversion())),
                          trailing: _buildDropDownButton(fromCurrency),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: _doConversion,
                        ),
                        ListTile(
                          title: Chip(
                            label: result != null
                                ? Text(
                              result,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4,
                            )
                                : Text(rate),
                          ),
                          trailing: _buildDropDownButton(toCurrency),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildSendingForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((String value) => DropdownMenuItem(
        value: value,
        child: Row(
          children: <Widget>[
            Text(value),
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
          Text(
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
          SizedBox(
            height: 25,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                  child: TextFormField(
                    controller: receiverNameController,
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
                    // controller: phoneNumberController,
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
                          setState(() => phoneNumber = val)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                  child: TextFormField(
                      controller: sendingFromController,
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
                    controller: sendingToController,
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
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45, bottom: 24),
                      child: Text(
                        'Bank Account details',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 12,
                          color: const Color(0xff0080b1),
                          fontWeight: FontWeight.w700,
                          height: 1.6666666666666667,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
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
                          setState(() => accountNumber = val)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sort Code',
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
                          setState(() => sortCode = val)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                  child: TextFormField(
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
                      onChanged: (val) =>
                          setState(() => bic = val)
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
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
                      onChanged: (val) =>
                          setState(() => iban = val)
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Button(
                  borderRadius: 30,
                  title: 'Continue',
                  function: () => _createTransfer(context),
                ),
              ],
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PayByCashScreen()),
    );
  }
}
