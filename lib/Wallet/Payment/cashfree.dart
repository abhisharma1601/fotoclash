import 'dart:convert';
import 'dart:math';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

final _showtoast = () => Fluttertoast.showToast(
    msg: "payment failed!",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);

final _showtoastlogin = () => Fluttertoast.showToast(
    msg: "Login Please",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);

final _showtoastsuc = () => Fluttertoast.showToast(
    msg: "Payment Successful!",
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.black);

Future<void> handle_payment(String amount) async {
  int order_id = Random().nextInt(1000000) + 1000000;
  Map final_res = Map<String, String>();

  var res = await http.post(
      Uri.parse("https://test.cashfree.com/api/v2/cftoken/order"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-client-id': '145515ec0b50381b388f0f6d9a515541',
        'x-client-secret': '56102f71c2420adbf328a005aad5ae95098a8612'
      },
      body: jsonEncode(
        {
          "orderId": order_id,
          "orderAmount": amount,
          "orderCurrency": "INR",
        },
      ));

  Map<String, String> input_params = {
    "orderId": order_id.toString(),
    "orderAmount": amount,
    "customerName": "TEST",
    "orderNote": "Nothing!",
    "orderCurrency": "INR",
    "appId": "145515ec0b50381b388f0f6d9a515541",
    "customerPhone": "7018036347",
    "customerEmail": "4abhi45@gmail.com",
    "stage": "TEST",
    "tokenData": jsonDecode(res.body)["cftoken"]
  };
  await CashfreePGSDK.doPayment(input_params)
      .then((value) => value?.forEach((key, value) {
            final entry = <String, String>{key: value.toString()};
            final_res.addAll(entry);
          }));
  print("hello!");

  try {
    if (final_res["txStatus"] == "SUCCESS") {
      _handlePaymentSuccess(amount);
    } else {
      _showtoast();
    }
  } catch (e) {
    _showtoast();
  }
}

void _handlePaymentSuccess(String amount) async {
  FirebaseFirestore.instance.collection("Users").doc(app_user.uid).set({
    "Wallet": {
      "Balance": FieldValue.increment(int.parse(amount)),
      "Added": FieldValue.increment(int.parse(amount)),
    }
  }, SetOptions(merge: true));
  FirebaseFirestore.instance
      .collection("Users")
      .doc(app_user.uid)
      .collection("Transactions")
      .doc(DateTime.now().toString())
      .set({
    "Type": "Added",
    "Date":
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
    "Time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
    "Amount": int.parse(amount)
  });

  Fluttertoast.showToast(msg: "₹${int.parse(amount)} added!");
  _showtoastsuc();
}
