import 'package:flutter/material.dart';
// import 'package:social_media_buttons/social_media_buttons.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
                  "About Us",
                  style: TextStyle(fontSize: 25),
                ),
                const Text("Home/ About Us "),
                const SizedBox(height: 25),
                const Text(
                    "Owned and operated by SHAAN Tech Solutions Private Limited (CIN- U72900UP2022PTC162667) is an Indian company incorporated under the Companies Act, 2013."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "We are a Social-Gaming company attempting to disrupt the real-money, skill-gaming market in India."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "We took your love for Photo Competitions and gave it an interesting spin! Why play for free when you could win amazing rewards and CASH for playing Photo Competitions ? Everyday hundreds and thousands of players join FotoClash and unlock the Model within them. And gains popularity overnight."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "d) In case we cancel your participation in any Contest as a result of this, We will return Your Entry Fee to You within a reasonable amount of time for You to redeem the same by playing other Contests on Fotoclash."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "We keep your experience while playing contests fun by offering you a variety of contests and 1v1,4v4 battles around the clock."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "Simply participate, compete and win cash prizes all day! Once the results are announced for a contest, winners can cash-out immediately with Google Pay, PhonePe, UPI or bank transfer."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "So what are you waiting for? Download the app NOW and start winning!"),
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
                const Text(
                  "Follow Us On Other Platforms",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocialMediaButton.twitter(
                //       url: "https://twitter.com/CipliOnat",
                //       size: 35,
                //       color: Colors.blue,
                //     ),
                //     SocialMediaButton.instagram(
                //       url: "https://twitter.com/CipliOnat",
                //       size: 35,
                //       color: Colors.blue,
                //     ),
                //     SocialMediaButton.facebook(
                //       url: "https://twitter.com/CipliOnat",
                //       size: 35,
                //       color: Colors.blue,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 20,
                ),
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
