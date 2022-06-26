import 'package:flutter/material.dart';

class HowTo extends StatelessWidget {
  const HowTo({Key? key}) : super(key: key);

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
                  "How to Play",
                  style: TextStyle(fontSize: 25),
                ),
                const Text("Home/ How to Play"),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Download our ‘Mobile App’ from https://fotoclash.com/ and sign up with basic details."),
                const SizedBox(
                  height: 15,
                ),
                const Text("• Login with registered email and password."),
                const SizedBox(
                  height: 15,
                ),
                const Text("• Recharge your wallet with desired amount."),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "TO JOIN CONTEST",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "If you want to withdraw your unused deposit funds from Fotoclash wallet."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Tap on Create btn (Plus btn) then you will see live contests on the ‘Join Contest’ , join contests of your choice by paying the entry fee and uploading your photograph."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• As all the participants of the contests join successfully the contest will be live on home page."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Share your contest ID with your friends to like your photo."),
                const SizedBox(
                  height: 15,
                ),
                const Text("• After 24 hrs the result will be announced."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• The winner of the contest will get its winning amount updated in his/her wallet."),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "TO CREATE CONTEST",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("• Tap on Create btn (Plus btn) -> Create Contest"),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Enter Contest name, select entry fee, select contest size."),
                const SizedBox(
                  height: 15,
                ),
                const Text("• Then upload your photograph"),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Now your contest is live on ‘JOIN CONTEST’ now any one join your contets."),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "SHARE YOUR CONTEST TO INVITE YOUR FRIENDS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("• Tap on Create btn (Plus btn) ->My Contests"),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Copy the contest ID and share it directly with friends (OR)"),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "• Tap on share button to share the contest details in a single click. "),
                // const SizedBox(
                //   height: 25,
                // ),
                // const Text(
                //   "Safe & Secure transactions Powered by:",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // Image(
                //   image: AssetImage("images/razorpay.png"),
                // ),
                const SizedBox(
                  height: 25,
                ),
                // const Text(
                //   "Follow Us On Other Platforms",
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("How To Play Privacy Policy Terms & Conditions"),
                    // Text(
                    //     "Contact Us / About Us / Refund / Cancellation policy"),
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
