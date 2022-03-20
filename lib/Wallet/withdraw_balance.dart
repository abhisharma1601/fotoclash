import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class WithdrawBalance extends StatefulWidget {
  WithdrawBalance(
      {required this.balance, required this.pending, required this.withdrawn});
  int balance, pending, withdrawn;

  @override
  State<WithdrawBalance> createState() => _WithdrawBalanceState();
}

late String _accnumber = "";
late String _accholdername = "";
late String _ifsc = "";
late String _contact = "";
late String _amount = "";
late String _upi = "";
Widget payment_gatway = Container();
List<String> gates = ["Bank Transfer", "UPI Transfer"];
String gate = "Select Payout Method";

class _WithdrawBalanceState extends State<WithdrawBalance> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> payment_methods = [BankTranfer(size: size), UPI(size: size)];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("background.png"), fit: BoxFit.cover)),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 99,
                  ),
                  const Center(
                    child: Text(
                      "Request Withdrawal",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 44),
              Container(
                height: 170,
                width: 230,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF3750FE),
                          Color(0xFF86F1F9),
                        ]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(150),
                        bottomLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\u{20B9} ${widget.balance}",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Avaliable Balance",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 33 / 375,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      _amount = value;
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFF4E5460),
                        filled: true,
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(color: Colors.white))),
              ),
              SizedBox(height: 10),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 18),
              //   height: size.height * 55 / 812,
              //   width: size.width * 339 / 375,
              //   decoration: BoxDecoration(
              //       color: Color(0xFF4E5460),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Select Payment method",
              //         style: TextStyle(fontSize: 16, color: Colors.white),
              //       ),
              //       Spacer(),
              //       Icon(Icons.arrow_drop_down_outlined)
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: size.height * 55 / 812,
                width: size.width * 339 / 375,
                decoration: BoxDecoration(
                    color: Color(0xFF4E5460),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Text(
                      gate,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Spacer(),
                    DropdownButtonHideUnderline(
                      child: Stack(
                        children: [
                          DropdownButton(
                              value: 0,
                              iconEnabledColor: Colors.white,
                              style: TextStyle(color: Colors.transparent),
                              dropdownColor: Color(0xff020C12),
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Bank Transfer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text(
                                    "UPI Transfer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  value: 1,
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  gate = gates[int.parse(val.toString())];
                                  payment_gatway = payment_methods[
                                      int.parse(val.toString())];
                                });
                              }),
                          Positioned(
                            top: 8,
                            child: Container(
                              height: 30,
                              width: 88,
                              color: Color(0xFF4E5460),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 23 / 812,
              ),
              payment_gatway,
              SizedBox(height: size.height * 75 / 812),
              Container(
                  width: MediaQuery.of(context).size.width * 249 / 360,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE65100), Color(0xFFFFE0B2)])),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          alignment: Alignment.center,
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 5, left: 5, top: 15, bottom: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          )),
                      onPressed: () {
                        if (int.parse(_amount) <= widget.balance) {
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(app_user.uid)
                              .set({
                            "Wallet": {
                              "Balance": widget.balance - int.parse(_amount),
                              "Withdrawn":
                                  widget.withdrawn + int.parse(_amount),
                              "Pending": widget.pending + int.parse(_amount),
                            }
                          }, SetOptions(merge: true));
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(app_user.uid)
                              .collection("Transactions")
                              .doc(DateTime.now().toString())
                              .set({
                            "Type": "Withdrawn",
                            "Date":
                                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                            "Time":
                                "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                            "Amount": int.parse(_amount),
                            "Method": gate,
                            "UPI": _upi,
                            "Account_No.": _accnumber,
                            "IFSC": _ifsc,
                            "Account_Holder": _accholdername
                          }, SetOptions(merge: true));
                          FirebaseFirestore.instance
                              .collection("Withdrawls")
                              .doc(DateTime.now().toString())
                              .set({
                            "Status": false,
                            "Date":
                                "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                            "Time":
                                "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}",
                            "Amount": int.parse(_amount),
                            "Method": gate,
                            "UPI": _upi,
                            "Account_No.": _accnumber,
                            "IFSC": _ifsc,
                            "UserID": app_user.uid,
                            "Account_Holder": _accholdername
                          }, SetOptions(merge: true));
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg:
                                  "Withdrawl initiated with amount \u{20B9}$_amount!");
                        } else {
                          Fluttertoast.showToast(msg: "Low Balance!");
                        }
                      },
                      child: const Text(
                        "Request Withdrawal",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ))),
              SizedBox(
                height: size.height * 44 / 812,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BankTranfer extends StatelessWidget {
  const BankTranfer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height * 46 / 812,
          width: size.width * 375 / 375,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
              onChanged: (value) {
                _accholdername = value;
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, left: 8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color(0xFF222633),
                  filled: true,
                  hintText: "Account holder name",
                  hintStyle: TextStyle(color: Color(0xFF6B7076)))),
        ),
        SizedBox(
          height: size.height * 17 / 812,
        ),
        Container(
          height: size.height * 46 / 812,
          width: size.width * 375 / 375,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
              onChanged: (value) {
                _accnumber = value;
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, left: 8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color(0xFF222633),
                  filled: true,
                  hintText: "Bank Acc No",
                  hintStyle: TextStyle(color: Color(0xFF6B7076)))),
        ),
        SizedBox(height: 17),
        Container(
          height: size.height * 46 / 812,
          width: size.width * 375 / 375,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
              onChanged: (value) {
                _ifsc = value;
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, left: 8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color(0xFF222633),
                  filled: true,
                  hintText: "IFSC code",
                  hintStyle: TextStyle(color: Color(0xFF6B7076)))),
        ),
      ],
    );
  }
}

class UPI extends StatelessWidget {
  UPI({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height * 46 / 812,
          width: size.width * 375 / 375,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
              onChanged: (value) {
                _accholdername = value;
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, left: 8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color(0xFF222633),
                  filled: true,
                  hintText: "Account holder name",
                  hintStyle: TextStyle(color: Color(0xFF6B7076)))),
        ),
        SizedBox(
          height: size.height * 17 / 812,
        ),
        Container(
          height: size.height * 46 / 812,
          width: size.width * 375 / 375,
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
              onChanged: (value) {
                _upi = value;
              },
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, left: 8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  fillColor: Color(0xFF222633),
                  filled: true,
                  hintText: "UPI ID",
                  hintStyle: TextStyle(color: Color(0xFF6B7076)))),
        ),
      ],
    );
  }
}
