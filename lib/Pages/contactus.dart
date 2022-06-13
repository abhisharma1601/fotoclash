import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 25),
                ),
                const Text("Home/ Contact Us"),
                const SizedBox(height: 25),
                const Text(
                  "SUPPORT ISSUES ?",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "If you need any help with the app and require any assistance with your account, please feel free to contact us here at"),
                const SizedBox(
                  height: 15,
                ),
                const Text("helpdesk@fotoclash.com "),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "PROMOTIONS QUERIES ?",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "If you have any questions about promotions or want to advertise with us, please feel free to contact our marketing team at"),
                const SizedBox(
                  height: 15,
                ),
                const Text("promotions@fotoclash.com "),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "OTHER ISSUES ?",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "If you are not satisfied with the solution provided by the FotoClash Team, you can then write to our Chief Grievance Officer - Akash Gupta"),
                const SizedBox(
                  height: 15,
                ),
                const Text("connectakash@fotoclash.com "),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                    "Reach Us At Shaan Tech Solutions Pvt. Ltd., New Indhira Colony ,Rajan Nagla bholepur farrukhabad, uttar pradesh, INDIA,209625 Contact Number +91895734197"),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Safe & Secure transactions Powered by:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image(
                  image: AssetImage("images/razorpay.png"),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "© 2021 SHAAN Tech Solutions Pvt Ltd. All Rights Reserved",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                        "*This game involes an element of financial risk and may be addictive please play responsibly at your own risk.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10)),
                    Text(
                        "And you must be 18 years of age to play real money skill games.",
                        style: TextStyle(fontSize: 10))
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
