import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  String userName;
  String image;
  final int index;
  final VoidCallback press;

   HomeBody(this.userName,this.image,{required this.index,required this.press, Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("Users").get(),
          builder:(ctx, AsyncSnapshot futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return   Row(
            children: [
              Stack(
                children: [CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.image),
                ),
                 Positioned(
                   left: 0,
                   bottom: 0,
                   child: Container(
                     height: 16,
                     width: 16,
                     decoration: BoxDecoration(color: Colors.red,
                     shape: BoxShape.circle,
                     border: Border.all()),
                   ),
                 )
                ]),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                children:  [     
                  Text(
                    widget.userName,
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 5,),
                  Opacity(
                    opacity: 0.6,
                    child: Text("Hi this is test .................",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                     style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
                  ),
                ],
              )),
              const Opacity(
                opacity: 0.6,
                child: Text("3m ago",style: TextStyle(color: Colors.white),))
            ],
          );
           } ),
      ),
    );
  }
}
