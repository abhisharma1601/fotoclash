import 'package:flutter/material.dart';

class Legal extends StatelessWidget {
  const Legal({Key? key}) : super(key: key);

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
                  "Legality ",
                  style: TextStyle(fontSize: 25),
                ),
                const Text("Home/ Legality "),
                const SizedBox(height: 25),
                const Text(
                  "With regards to the Public Gambling Act, 1867 (PGA):",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "All contests available on the FotoClash platform where users can participate with real money are 'Games of Skill'. FotoClash does not support, endorse or offer 'games of chance' for real money rewards. While 'Games of Skill' do not have a comprehensive definition, they are those games where the impact of a player's effort and skill on the outcome of a game is the dominant factor over luck or chance. "),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "FotoClash has clearly defined rules. Users are encouraged to follow, understand and read these rules to be successful and earn money in FotoClash's contests. "),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "The contests, which can be participated with real money, hosted on the FotoClash platform are 'Games of Skills', such that the outcome / success in the games is directly dependent on the user's effort, performance and skill. By choosing how to play, the actions of users shall have a direct impact on the game. "),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "Every game will have some elements of chance, but in the form of challenges or obstacles that a user would be able to overcome using his/her skills and knowledge of the contests. Elements of luck are present in every contests to add thrill and excitement, but no two attempts at a contest are identical so users must use their skills in order to be successful. "),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "Since the contests available on the FotoClash platform can be won through users' skills and such skills may be enhanced with practice and experience, the performance of a User may improve with time and practice. "),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "The performance of a User may improve with time and practice.Different contests will reward different skills, but each contest will reward certain skills, such as knowledge of the game, familiarity with rules, experience, reflexes, experience, practice, hand-eye coordination etc."),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "Certain games may have pre-determined outcomes and these outcomes are achievable by users using their skills. "),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Banned States",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                    "If you are accessing this site from Andhra Pradesh, Assam, Orissa, Telangana, Sikkim or Nagaland, we hope you will enjoy our practice contests. However, the law in these states is unclear on playing games of skill with entry fees for cash prizes. You are therefore prohibited from playing cash contests on FotoClash from any of these states."),
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
                      textAlign: TextAlign.center,
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
