import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TabPair {
  final Tab tab;
  final Widget view;
  TabPair({required this.tab, required this.view});
}

final _auth = FirebaseAuth.instance;
List<TabPair> TabPairs = [
  TabPair(
    tab: const Tab(
      text: 'Contests Played',
    ),
    view: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Users")
            .doc(_auth.currentUser!.uid)
            .collection("Participations")
            .where("isActive", isEqualTo: false)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return snapshot.hasData
                ? Center(
                    child: StaggeredGridView.countBuilder(
                        staggeredTileBuilder: (index) =>
                            StaggeredTile.count(2, index.isEven ? 2 : 1),
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        itemCount: snapshot.requireData.docs.length,
                        itemBuilder: (_, index) {
                          print(snapshot.requireData.docs[index]['Winner']);
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xFF141E31),
                                      title: Text(
                                        "Contest Details",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      content: Text(
                                        " Prize : " +
                                            snapshot.requireData
                                                .docs[index]['Prize']
                                                .toString() +
                                            "\n Entry Fee : " +
                                            snapshot.requireData
                                                .docs[index]['Entry Fee']
                                                .toString() +
                                            "\n Contest ID : " +
                                            snapshot.requireData
                                                .docs[index]['ContestId']
                                                .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  });
                            },
                            child: Card(
                                color: Colors.transparent,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image(
                                          image: NetworkImage(snapshot
                                              .requireData
                                              .docs[index]["images"][0]),
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Container(
                                              height: 22,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: snapshot.requireData
                                                                  .docs[index]
                                                              ['Winner'] ==
                                                          false
                                                      ? Colors.red[300]
                                                      : Colors.green[300]),
                                              child: Center(
                                                  child: Text(
                                                snapshot.requireData.docs[index]
                                                            ['Winner'] ==
                                                        false
                                                    ? "Lost"
                                                    : "Won",
                                                style: TextStyle(
                                                    color: snapshot.requireData
                                                                    .docs[index]
                                                                ['Winner'] ==
                                                            false
                                                        ? Colors.red
                                                        : Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        }),
                  )
                : Center(child: CircularProgressIndicator());
          }
        }),
  ),
  TabPair(
    tab: const Tab(
      text: 'Contests Live',
    ),
    view: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Users")
            .doc(_auth.currentUser!.uid)
            .collection("Participations")
            .where("isActive", isEqualTo: true)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return snapshot.hasData
                ? Center(
                    child: StaggeredGridView.countBuilder(
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(2, index.isEven ? 2 : 1),
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      itemCount: snapshot.requireData.docs.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF141E31),
                                    title: Text(
                                      "Contest Details",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                      " Prize : " +
                                          snapshot
                                              .requireData.docs[index]['Prize']
                                              .toString() +
                                          "\n Entry Fee : " +
                                          snapshot.requireData
                                              .docs[index]['Entry Fee']
                                              .toString() +
                                          "\n Contest ID : " +
                                          snapshot.requireData
                                              .docs[index]['ContestId']
                                              .toString() +
                                          "\n Time Left : " +
                                          DateTime.parse(snapshot.requireData
                                                      .docs[index]['DateTime'] +
                                                  "0")
                                              .add(Duration(days: 1))
                                              .difference(DateTime.now())
                                              .inHours
                                              .toString() +
                                          " hrs" +
                                          " " +
                                          (int.parse(DateTime.parse(snapshot
                                                                  .requireData
                                                                  .docs[index]
                                                              ['DateTime'] +
                                                          "0")
                                                      .add(Duration(days: 1))
                                                      .difference(DateTime.now())
                                                      .inMinutes
                                                      .toString()) %
                                                  24)
                                              .toString() +
                                          " minutes",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                });
                          },
                          child: Card(
                              color: Colors.transparent,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image(
                                        image: NetworkImage(snapshot.requireData
                                            .docs[index]["images"][0]),
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Opacity(
                                          opacity: 0.8,
                                          child: Container(
                                            height: 22,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.purple[300]),
                                            child: const Center(
                                                child: Text(
                                              "Live",
                                              style: TextStyle(
                                                  color: Colors.purple,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          }
        }),
  ),
];

class TabBarAndTabViews extends StatefulWidget {
  const TabBarAndTabViews({Key? key}) : super(key: key);

  @override
  _TabBarAndTabViewsState createState() => _TabBarAndTabViewsState();
}

class _TabBarAndTabViewsState extends State<TabBarAndTabViews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: TabPairs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          children: [
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(65, 74, 91, 1),
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(134, 241, 249, 1),
                          Color.fromRGBO(55, 80, 254, 1)
                        ])),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    tabs: TabPairs.map((tabPair) => tabPair.tab).toList()),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: TabPairs.map((tabPair) => tabPair.view).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
