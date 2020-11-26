import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Transfer {
  final String id;
  final Timestamp date;
  final String receiverName;
  final String phoneNumber;
  final String sendingCurrency;
  final String receivingCurrency;
  final String paymentType;
  final String destination;
  final String from;
  final int amountSent;
  final double amountReceived;
  final String status;

  Transfer({ @required this.id, this.receiverName, this.phoneNumber, this.sendingCurrency, this.receivingCurrency, this.paymentType, this.destination, this.from, this.amountReceived, this.amountSent, this.status, this.date });

  factory Transfer.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String id = data['id'];
    final Timestamp date = data['date'];
    final String receiverName = data['receiverName'];
    final String sendingCurrency = data['sendingCurrency'];
    final String receivingCurrency = data['receivingCurrency'];
    final String paymentType = data['paymentType'];
    final String destination = data['destination'];
    final String from = data['from'];
    final double amountReceived = data['amountReceived'];
    final int amountSent = data['amountSent'];
    final String status = data['status'];

    return Transfer(
      id: documentId,
      date: date,
      receiverName: receiverName,
      sendingCurrency: sendingCurrency,
      receivingCurrency: receivingCurrency,
      paymentType: paymentType,
      destination: destination,
      from: from,
      amountReceived: amountReceived,
      amountSent: amountSent,
      status: status
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverName': receiverName,
      'phoneNumber': phoneNumber,
      'sendingCurrency': sendingCurrency,
      'receivingCurrency': receivingCurrency,
      'paymentType': paymentType,
      'destination': destination,
      'from': from,
      'amountReceived': amountReceived,
      'amountSent': amountSent,
      'status': status,
      'date': date
    };
  }
}