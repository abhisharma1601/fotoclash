import 'package:flutter/material.dart';

import 'package:fotoclash/Widgets/search_bar.dart';

class HomeChats extends StatefulWidget {
  const HomeChats({Key? key}) : super(key: key);

  @override
  _HomeChatsState createState() => _HomeChatsState();
}

class _HomeChatsState extends State<HomeChats> {
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("background.png"), fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 150 / 375,
                  ),
                  const Center(
                    child: Text(
                      "Messages",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 250 / 812,
                    width: MediaQuery.of(context).size.width * 340 / 375,
                    child: SingleChildScrollView(
                        child: SearchInput(
                            textController: searchC, hintText: "Search"))),
              ),

              // Expanded(
              //   child: StreamBuilder(
              //       stream: FirebaseFirestore.instance
              //           .collection("Users")
              //           .snapshots(),
              //       builder:
              //           (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
              //         if (streamsnapshot.connectionState ==
              //             ConnectionState.waiting) {
              //           return const Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         }
              //         return ListView.builder(
              //             itemCount: streamsnapshot.data?.docs.length,
              //             itemBuilder: (context, index) {
              //               return HomeBody(
              //                 streamsnapshot.data?.docs[index]['userName'],
              //                 streamsnapshot.data?.docs[index]['imageUrl'],
              //                 index: index,
              //                 press: () {
              //                   Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                           builder: (context) => Messages(
              //                               streamsnapshot.data?.docs[index]
              //                                   ['userName'],
              //                               streamsnapshot.data?.docs[index]
              //                                   ['imageUrl'])));
              //                 },
              //               );
              //             });
              //       }),
              // )
            ],
          )
        ],
      ),
    );
  }
}
