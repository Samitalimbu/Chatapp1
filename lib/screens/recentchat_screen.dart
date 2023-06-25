import 'package:division/division.dart';
import 'package:firebase/constants/firebase_instances.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';

class RecentChats extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final roomData = ref.watch(roomStream);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Txt(
                  "Welcome to Recent chats",
                  style: TxtStyle()
                    ..fontSize(16)
                    ..textColor(Colors.white),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 330),
                      color: Colors.white,
                      child: roomData.when(
                          data: (data) {
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final currentUser = FirebaseInstances
                                      .firebaseAuth.currentUser!.uid;
                                  final otherUser = data[index]
                                      .users
                                      .firstWhere((element) =>
                                          element.id != currentUser);
                                  final user = data[index].users.firstWhere(
                                      (element) => element.id == currentUser);
                                  return ListTile(
                                    onTap: () {
                                      Get.to(() => ChatPage(
                                            room: data[index],
                                            currentUser: user.firstName!,
                                            token: otherUser.metadata!['token'],
                                          ));
                                    },
                                    leading:
                                        Image.network(data[index].imageUrl!),
                                    title: Text(data[index].name!),
                                    subtitle:
                                        Text("Click here to see the chat"),
                                    trailing: Icon(
                                      Icons.chat,
                                      color: Colors.blue,
                                    ),
                                  );
                                });
                          },
                          error: (err, stack) => Center(child: Text('$err')),
                          loading: () =>
                              Center(child: CircularProgressIndicator()))),
                )
              ],
            ),
          ),
          Container(
            height: 330,
            width: 600,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 226, 221, 219),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Txt(
                      "Welcome to Recent chats",
                      style: TxtStyle()
                        ..fontSize(16)
                        ..textColor(Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/images/recent.png",
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
