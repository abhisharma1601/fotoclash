import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotoclash/Pages/instructions.dart';
import 'package:fotoclash/Screens/Notification/notification.dart';
import 'package:fotoclash/Screens/Profile/edit_profile.dart';
import 'package:fotoclash/Screens/leader_board.dart';
import 'package:fotoclash/Screens/Profile/set_profile.dart';
import 'package:fotoclash/Screens/sign_up.dart';
import 'package:fotoclash/Wallet/wallet.dart';
import 'package:fotoclash/main.dart';
import 'package:share_plus/share_plus.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  image: DecorationImage(
                      image: NetworkImage(app_user.photo), fit: BoxFit.cover)),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Welcome ${app_user.username}",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 18),
            )
          ]),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeaderBoard()));
              },
              child:
                  _RowBox(ico: Icons.leaderboard_rounded, body: "Leaderboard")),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Wallet()));
              },
              child: _RowBox(
                  ico: Icons.account_balance_wallet_rounded, body: "Wallet")),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsPage()));
              },
              child:
                  _RowBox(ico: Icons.notifications_none, body: "Notification")),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Instructions()));
            },
            child: _RowBox(
                ico: Icons.integration_instructions_outlined,
                body: "Instruction"),
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: _RowBox(ico: Icons.edit_rounded, body: "Edit Profile")),
          GestureDetector(
              onTap: () {
                Share.share(
                    "Hey, look at this new DP battle app with an actual chance of winning real money. Try it now by downloading using the link provided below:\n",
                    subject: "Fotoclash Invitation!");
              },
              child: _RowBox(ico: Icons.share, body: "Share App")),
          _RowBox(ico: Icons.info_outlined, body: "About Us"),
          _RowBox(ico: Icons.fact_check_outlined, body: "Terms of Services"),
          _RowBox(ico: Icons.poll_outlined, body: "Privacy Policy"),
          InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUp())));
              },
              child: _RowBox(ico: Icons.logout, body: "Log Out"))
        ],
      ),
    );
  }
}

class _RowBox extends StatelessWidget {
  _RowBox({
    required this.ico,
    required this.body,
  });

  IconData ico;
  String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width * 342 / 375,
      decoration: BoxDecoration(
          // color: const Color(0xffbac333863),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(
            ico,
            color: Colors.orange[900],
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            body,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
