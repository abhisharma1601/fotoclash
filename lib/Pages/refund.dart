import 'package:flutter/material.dart';

class Refund extends StatelessWidget {
  const Refund({Key? key}) : super(key: key);

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
                  "Refund/Cancellation policy",
                  style: TextStyle(fontSize: 25),
                ),
                const Text("Home/ Refund/Cancellation policy"),
                const SizedBox(height: 10),
                const Text(
                  "Refund/Cancellation policy",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "a) In the event, that there is an error in the Services provided by us, we may refund the Entry Fee, provided the reasons are genuine and proved after investigation by Fotoclash."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "b) Please read the rules of Contest before participating."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "c) We do not cancel registrations once entered, however, in case of exceptional circumstances wherein the fault may lie with the payment gateway or from Our side, We will cancel your participation on request and refund the Entry Fee to You within a reasonable amount of time."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "d) In case we cancel your participation in any Contest as a result of this, We will return Your Entry Fee to You within a reasonable amount of time for You to redeem the same by playing other Contests on Fotoclash."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "e) We will try Our best to create the best user experience for You. If paid by credit card, refunds will be issued to the original credit card provided at the time of purchase and in case of payments made through a payment gateway, payment refunds will be made to the same account."),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Refund Policy",
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
                    "a) Please Email us at helpdesk@fotoclash.com from your registered Email ID & also mention the registered phone number. We will call you to verify the request."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "b) Please mention the reason for which you’re requesting to withdraw the deposit funds."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "c) Give us your correct Bank account number with IFSC code to get back the deposit money."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "d) We will process the refund validating the reason within 7-14 working days."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "In order to comply with extant law relating to deposit regulations, please note that the Users must withdraw any idle Balance lying in their Account within 365 days of having won a particular Contest. Similarly, Users must use any money in their Account within 365 days. If not, the said Balance will have to be forfeited by Fotoclash."),
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
                    // Text("How To Play/ Privacy Policy/ Terms & Conditions"),
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
