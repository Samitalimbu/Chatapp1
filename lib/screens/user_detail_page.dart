import 'package:division/division.dart';
import 'package:firebase/screens/edit_profile.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/services/post_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';

class UserDetailPage extends ConsumerWidget {
  final types.User user;
  final String currentUserName;
  UserDetailPage(this.user, this.currentUserName);

  @override
  Widget build(BuildContext context, ref) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final postData = ref.watch(postStream);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(HomeScreen());
                      },
                      child: Icon(Icons.arrow_back_ios_new)),
                  if (user.id == uid)
                    InkWell(
                        onTap: () {
                          Get.to(EditProfile(
                            user: user,
                          ));
                        },
                        child: Icon(Icons.edit)),
                ],
              ),
              Expanded(
                child: Container(
                  color: const Color(0xfff5f6f7),
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/user_detail.png",
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt("Username"),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffD9D9D9),
                                        border:
                                            Border.all(color: Colors.white24),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, .2),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Txt(
                                      user.firstName!,
                                      style: TxtStyle()
                                        ..alignmentContent.center(true)
                                        ..width(160),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Txt("Email"),
                                      SizedBox(height: 14),
                                      Container(
                                        height: 54,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffD9D9D9),
                                            border: Border.all(
                                                color: Colors.white24),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, .2),
                                                  blurRadius: 20.0,
                                                  offset: Offset(0, 10))
                                            ]),
                                        child: Txt(
                                          user.metadata!['email'],
                                          style: TxtStyle()
                                            ..alignmentContent.center(true)
                                            ..width(160),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Text(user.firstName!),
                                // Text(user.metadata!['email']),

                                const SizedBox(height: 20),
                                if (user.id != uid)
                                  Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(90, 54),
                                          primary: const Color.fromARGB(
                                              255, 156, 200, 235),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                        ),
                                        onPressed: () async {
                                          final response = await ref
                                              .read(roomProvider)
                                              .createRoom(user);
                                          if (response != null) {
                                            Get.to(() => ChatPage(
                                                  room: response,
                                                  token:
                                                      user.metadata!['token'],
                                                  currentUser: currentUserName,
                                                ));
                                          }
                                        },
                                        child: Text('Message')),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
              // Expanded(
              //     child: postData.when(
              //         data: (data) {
              //           final userPost = data
              //               .where((element) => element.userId == user.id)
              //               .toList();
              //           return GridView.builder(
              //               itemCount: userPost.length,
              //               gridDelegate:
              //                   SliverGridDelegateWithFixedCrossAxisCount(
              //                       crossAxisCount: 3,
              //                       childAspectRatio: 2 / 3,
              //                       crossAxisSpacing: 5,
              //                       mainAxisSpacing: 5),
              //               itemBuilder: (context, index) {
              //                 return Image.network(userPost[index].imageUrl);
              //               });
              //         },
              //         error: (err, stack) => Center(child: Text('$err')),
              //         loading: () =>
              //             Center(child: CircularProgressIndicator())))
            ],
          ),
        ),
      ),
    );
  }
}
//   }
// }
