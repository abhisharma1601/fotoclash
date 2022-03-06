import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fotoclash/main.dart';

class AddBalance extends StatefulWidget {
  AddBalance({required this.balance, required this.added});
  int balance, added;

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("background.png"), fit: BoxFit.cover)),
        width: size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
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
                  width: MediaQuery.of(context).size.width * 100 / 375,
                ),
                const Center(
                  child: Text(
                    "Add Balance",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
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
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Avaliable Balance",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 113 / 812,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          amount.text = "50";
                        },
                        child: PriceBox(price: 50)),
                    GestureDetector(
                        onTap: () {
                          amount.text = "100";
                        },
                        child: PriceBox(price: 100)),
                    GestureDetector(
                        onTap: () {
                          amount.text = "200";
                        },
                        child: PriceBox(price: 200)),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            amount.text = "500";
                          },
                          child: PriceBox(price: 500)),
                      GestureDetector(
                          onTap: () {
                            amount.text = "1000";
                          },
                          child: PriceBox(price: 1000)),
                      GestureDetector(
                          onTap: () {
                            amount.text = "2000";
                          },
                          child: PriceBox(price: 2000)),
                    ])
              ],
            ),
            SizedBox(height: 15),
            Text(
              "OR",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                  controller: amount,
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      fillColor: Color(0xFF222633),
                      filled: true,
                      hintText: "Enter Amount",
                      hintStyle: TextStyle(color: Color(0xFF6B7076)))),
            ),
            SizedBox(
              height: size.height * 55 / 812,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 339 / 360,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE65100), Color(0xFFFFE0B2)])),
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    alignment: Alignment.center,
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        right: 75, left: 75, top: 15, bottom: 15)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    )),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(app_user.uid)
                      .set({
                    "Wallet": {
                      "Balance": widget.balance + int.parse(amount.text),
                      "Added": widget.added + int.parse(amount.text)
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
                    "Amount": int.parse(amount.text)
                  });
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "₹${int.parse(amount.text)} added!");
                },
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Add Money",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriceBox extends StatelessWidget {
  PriceBox({required this.price});
  final price;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
      height: 36,
      decoration: BoxDecoration(
          color: const Color(0xFF222633),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          "\u{20B9} ${price}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
