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
    _currencies = curMap.keys.toList();
    setState(() {});
    //print(currencies);
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri =
        "https://openexchangerates.org/api/latest.json?app_id=c4163e84d9ac4c6ebe5a19994780a145&base=$_fromCurrency&symbols=$_toCurrency";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      _result = (double.parse(_amountSentController.text) *
              (responseBody["rates"][_toCurrency]))
          .toStringAsFixed(2);
    });
    //print(rate);
    return "Success";
  }

  Future<String> _rate() async {
    String uri =
        "https://openexchangerates.org/api/latest.json?app_id=c4163e84d9ac4c6ebe5a19994780a145&base=$_fromCurrency&symbols=$_toCurrency";
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
        title: Text("Currency Converter"),
      ),
      body: _currencies == null
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
                                    controller: _amountSentController,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onChanged: (fromTextController) =>
                                        setState(() => _doConversion())),
                                trailing: _buildDropDownButton(_fromCurrency),
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_downward),
                                onPressed: _doConversion,
                              ),
                              ListTile(
                                title: Chip(
                                  label: _result != null
                                      ? Text(
                                          _result,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        )
                                      : Text(rate ?? 0),
                                ),
                                trailing: _buildDropDownButton(_toCurrency),
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
      items: _currencies
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
        if (currencyCategory == _fromCurrency) {
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _newTransfer(BuildContext context) async {
    if (_validateAndSaveForm()) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
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
