import 'package:flutter/material.dart';

class WithdrawBalance extends StatefulWidget {
  const WithdrawBalance({Key? key}) : super(key: key);

  @override
  State<WithdrawBalance> createState() => _WithdrawBalanceState();
}

class _WithdrawBalanceState extends State<WithdrawBalance> {
  late String accnumber;
  late String accholdername;
  late String ifsc;
  late String contact;
  late String amount;

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
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
              const SizedBox(height: 23),
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
                  children: const [
                    Text(
                      "\u{20B9} 115.55",
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
                      amount = value;
                    },
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                height: size.height * 55 / 812,
                width: size.width * 339 / 375,
                decoration: BoxDecoration(
                    color: Color(0xFF4E5460),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Text(
                      "Select Payment method",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down_outlined)
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 23 / 812,
              ),
              Container(
                height: size.height * 46 / 812,
                width: size.width * 200 / 375,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      accholdername = value;
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
                width: size.width * 200 / 375,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      accnumber = value;
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFF222633),
                        filled: true,
                        hintText: "Bank Acc No",
                        hintStyle: TextStyle(color: Color(0xFF6B7076)))),
              ),
              SizedBox(height: 17),
              Container(
                height: size.height * 46 / 812,
                width: size.width * 200 / 375,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      ifsc = value;
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFF222633),
                        filled: true,
                        hintText: "IFSC code",
                        hintStyle: TextStyle(color: Color(0xFF6B7076)))),
              ),
              SizedBox(height: 17),
              Container(
                height: size.height * 46 / 812,
                width: size.width * 200 / 375,
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                    onChanged: (value) {
                      contact = value;
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 8, left: 8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        fillColor: Color(0xFF222633),
                        filled: true,
                        hintText: "Contact no",
                        hintStyle: TextStyle(color: Color(0xFF6B7076)))),
              ),
              SizedBox(height: size.height * 55 / 812),
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
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  right: 75, left: 75, top: 15, bottom: 15)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          )),
                      onPressed: () {
                        //process of req widhdrawl
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
