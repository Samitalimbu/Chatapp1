import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:firebase/constants/firebase_instances.dart';
import 'package:firebase/notication_service.dart';
import 'package:firebase/providers/post_provider.dart';

import 'package:firebase/screens/create_page.dart';
import 'package:firebase/screens/detail_screen.dart';
import 'package:firebase/screens/mystatus_screen.dart';
import 'package:firebase/screens/recentchat_screen.dart';
import 'package:firebase/screens/update_page_screen.dart';
import 'package:firebase/screens/user_detail_page.dart';
import 'package:firebase/services/auth_service.dart';
import 'package:firebase/services/post_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_nav_bar/google_nav_bar.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final userId = FirebaseInstances.firebaseAuth.currentUser!.uid;
  late types.User user;
  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // // 2. This method only call when App in foreground it mean app must be opened
    // FirebaseMessaging.onMessage.listen(
    //   (message) {
    //     print("FirebaseMessaging.onMessage.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data11 ${message.data}");
    //       LocalNotificationService.createanddisplaynotification(message);
    //     }
    //   },
    // );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    // getToken();
  }

  // Future<void> getToken() async {
  //   final response = await FirebaseMessaging.instance.getToken();
  //   print(response);
  // }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userStream(userId));
    final users = ref.watch(usersStream);
    final postData = ref.watch(postStream);
    int _indexSelected = 0;
    userData.when(
        data: (data) {
          user = data;
        },
        error: (err, stack) => Text('$err'),
        loading: () => const Center(child: CircularProgressIndicator()));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 207, 202, 191),
          title: Text("Welcome to ChitChat"),
        ),
        bottomNavigationBar: GNav(
          activeColor: const Color(0xffd36868),
          color: Colors.black45,
          tabBackgroundColor: const Color(0xFFF1EFEF),
          padding: const EdgeInsets.all(16),
          gap: 10,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 400),
          tabs: [
            GButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Icons.home,
              text: 'Home',
              textSize: 12,
            ),
            GButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePageScreen()));
                },
                icon: Icons.upload_file_outlined,
                text: 'Upload',
                textSize: 12),
            GButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecentChats()));
                },
                icon: Icons.chat_bubble_outline_outlined,
                text: 'Chat',
                textSize: 12),
            GButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mystatus()));
                },
                icon: Icons.logout_outlined,
                text: '',
                textSize: 12),
          ],
          selectedIndex: _indexSelected,
          onTabChange: (index) {
            _indexSelected = index;
          },
        ),
        drawer: Drawer(
          shadowColor: Colors.red,
          child: userData.when(
              data: (data) {
                user = data;
                return ListView(
                  children: [
                    ListTile(
                      onTap: () =>
                          Get.to(UserDetailPage(user, user.firstName!)),
                      leading: CircleAvatar(
                        radius: 30.sp,
                        backgroundImage: NetworkImage(data.imageUrl!),
                      ),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.firstName!),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(data.metadata!['email'])
                        ],
                      ),
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black,
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20.w,
                      endIndent: 20.w,
                      height: 30.h,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(() => RecentChats());
                      },
                      leading: const Icon(Icons.chat),
                      title: Text('Recent Chats'),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => CreatePageScreen());
                      },
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text("Create Post"),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        ref.read(authProvider.notifier).userLogout();
                      },
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text("Signout"),
                    )
                  ],
                );
              },
              error: (err, stack) => Text('$err'),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Container(
                  height: 140,
                  child: users.when(
                      data: (data) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => UserDetailPage(
                                          data[index], user.firstName!),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(data[index].imageUrl!),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(data[index].firstName!)
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => Center(child: CircularProgressIndicator())

                      //
                      ),
                ),
                const SizedBox(height: 14),
                Expanded(
                    child: postData.when(
                        data: (data) {
                          return ListView.builder(
                              itemCount: data.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 300,
                                            child: Text(
                                              data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (data[index].userId == userId)
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                      title: 'Customize Post',
                                                      titleStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      content: const Text(
                                                          'Edit or Remove Post'),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Parent(
                                                              style:
                                                                  ParentStyle()
                                                                    ..height(40)
                                                                    ..borderRadius(
                                                                        topLeft:
                                                                            6,
                                                                        topRight:
                                                                            6)
                                                                    ..width(90)
                                                                    ..alignmentContent
                                                                        .center(
                                                                            true)
                                                                    ..elevation(
                                                                        3)
                                                                    ..background.color(
                                                                        const Color(
                                                                            0xffAECBD6)),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Get.to(() =>
                                                                      UpdatePage(
                                                                          data[
                                                                              index]));
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Edit",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                            Parent(
                                                              style:
                                                                  ParentStyle()
                                                                    ..height(40)
                                                                    ..borderRadius(
                                                                        topLeft:
                                                                            6,
                                                                        topRight:
                                                                            6)
                                                                    ..width(90)
                                                                    ..alignmentContent
                                                                        .center(
                                                                            true)
                                                                    ..elevation(
                                                                        3)
                                                                    ..background.color(
                                                                        const Color(
                                                                            0xffAECBD6)),
                                                              child: const Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]);
                                                },
                                                icon: const Icon(
                                                  Icons.more_horiz_rounded,
                                                  color: Colors.black,
                                                ))
                                        ],
                                      ),
                                      const SizedBox(height: 18),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => DetailPageScreen(
                                              data[index], user));
                                        },
                                        child: CachedNetworkImage(
                                          height: 240,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          imageUrl: data[index].imageUrl,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 280,
                                            child: Text(
                                              data[index].detail,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (data[index].userId != userId)
                                            IconButton(
                                                onPressed: () {
                                                  if (data[index]
                                                      .like
                                                      .usernames
                                                      .contains(
                                                          user.firstName)) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            duration: Duration(
                                                                seconds: 1),
                                                            content: Text(
                                                                'You have already like this post')));
                                                  } else {
                                                    ref
                                                        .read(postProvider
                                                            .notifier)
                                                        .addLike(
                                                            [
                                                          ...data[index]
                                                              .like
                                                              .usernames,
                                                          user.firstName!
                                                        ],
                                                            data[index].postId,
                                                            data[index]
                                                                .like
                                                                .likes);
                                                  }
                                                },
                                                icon: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 60),
                                                  child: Icon(Icons
                                                      .thumb_up_alt_outlined),
                                                )),
                                          if (data[index].like.likes != 0)
                                            Text('${data[index].like.likes}')
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        error: (err, stack) => Center(child: Text('$err')),
                        loading: () =>
                            const Center(child: CircularProgressIndicator())))
              ],
            ),
          ),
        ));
  }
}
