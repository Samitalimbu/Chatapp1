import 'package:division/division.dart';
import 'package:firebase/common_widgets/snack_show.dart';
import 'package:firebase/models/post.dart';
import 'package:firebase/providers/post_provider.dart';
import 'package:firebase/screens/home.dart';
import 'package:firebase/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DetailPageScreen extends ConsumerWidget {
  final Post post;
  final types.User user;
  DetailPageScreen(this.post, this.user);

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final posts = ref.watch(postStream);
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding:const  EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.to(() => HomeScreen());
                  },
                  child:  const Icon(Icons.arrow_back_ios)),
            ],
          ),
        ),
        Txt(
          "Discover new Friends!",
          style: TxtStyle()
            ..fontSize(28)
            ..fontWeight(FontWeight.bold)
            ..padding(all: 10),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.imageUrl,
              height: 390,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(post.detail),
            const SizedBox(height: 10),
            TextFormField(
              controller: commentController,
              onFieldSubmitted: (val) {
                SnackShow.showFailure(context, "please provide comment");
                if (val.isEmpty) {
                } else {
                  ref.read(postProvider.notifier).addComment([
                    ...post.comments,
                    Comment(
                        userName: user.firstName!,
                        imageUrl: user.imageUrl!,
                        comment: val.trim())
                  ], post.postId);
                }
              },
              decoration: InputDecoration(hintText: "Add some Comment"),
            ),
            const SizedBox(height: 30),
            posts.when(
                data: (data) {
                  final postRelated = data
                      .firstWhere((element) => element.postId == post.postId);
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: postRelated.comments.length,
                    itemBuilder: (context, index) {
                      final pos = postRelated.comments[index];
                      return ListTile(
                        leading: Image.network(pos.imageUrl),
                        title: Text(pos.userName),
                        subtitle: Text(pos.comment),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => const Center(child: CircularProgressIndicator()))
          ]),
        ),
      ],
    ));
  }
}
