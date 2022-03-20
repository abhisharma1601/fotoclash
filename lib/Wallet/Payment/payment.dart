import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../main.dart';

class py_pg extends StatefulWidget {
  py_pg({required this.amount});
  String amount;

  @override
  _py_pgState createState() => _py_pgState();
}

class _py_pgState extends State<py_pg> {
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    oC();
    super.initState();
  }

  void oC() async {
    var options = {
      'key': 'rzp_test_AJKHfMYpz8OXtU',
      'amount': int.parse(widget.amount) * 100,
      'name': 'Fotoclash',
      'description': 'Fotoclash Payment',
      'prefill': {'contact': 'Enter Mobile'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e as String);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    FirebaseFirestore.instance.collection("Users").doc(app_user.uid).set({
      "Wallet": {
        "Balance": FieldValue.increment(int.parse(widget.amount)),
        "Added": FieldValue.increment(int.parse(widget.amount)),
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
      "Amount": int.parse(widget.amount)
    });
    Navigator.pop(context);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "₹${int.parse(widget.amount)} added!");
    _showtoastsuc();
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
    _showtoast();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Page")),
      body: Column(),
    );
  }
}

late Razorpay _razorpay;
late String em;

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
