
import 'package:flutter/material.dart';
import 'package:fotoclash/Models/databse.dart';
import 'package:fotoclash/main.dart';

class NewMessages extends StatefulWidget {
   String chatRoomId;
   NewMessages(this.chatRoomId,{Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {

  final _controller = TextEditingController();
  var _enteredMessage = '';
    addMessage() async {
    if (_controller.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        'userName': app_user.username,
        "message": _enteredMessage,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      setState(() {
        _controller.text = "";
        DataBase().addMessage(widget.chatRoomId, chatMessageMap);
      });
      print(MediaQuery.of(context).viewInsets.bottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: _controller,
              onChanged: (value) {
                _enteredMessage = value;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.add,
                  color: Colors.grey[500]!,
                ),
                
                filled: true,
                fillColor: const Color(0xFF263238),
                hintText: "Type Message",
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w400),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          )),
          IconButton(
              color: Colors.grey,
              onPressed: () {
                addMessage();
              },
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
