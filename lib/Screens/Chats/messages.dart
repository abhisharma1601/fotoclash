import 'package:flutter/material.dart';
import 'package:fotoclash/Models/chat_messages.dart';
import 'package:fotoclash/Screens/Chats/new_message.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
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
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 120 / 375,
                  ),
                  const Center(
                    child: Text(
                      "User Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: demeChatMessages[index].isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!demeChatMessages[index].isSender) ...[
                              const CircleAvatar(
                                radius: 18,
                                backgroundImage: NetworkImage(
                                    "https://i.insider.com/5e820b04671de06758588fb8?width=700"),
                              )
                            ],
                            Container(
                              decoration: BoxDecoration(
                                  color: demeChatMessages[index].isSender
                                      ? Colors.blueGrey[900]
                                      : Colors.grey[600],
                                  borderRadius: demeChatMessages[index].isSender
                                      ? const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))
                                      : const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20 * 0.75, vertical: 10),
                              child: Text(
                                demeChatMessages[index].text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      })),
              const NewMessages()
            ],
          )
        ],
      ),
    );
  }
}
