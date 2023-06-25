import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase/common_widgets/snack_show.dart';
import 'package:firebase/providers/auth_provider.dart';
import 'package:firebase/screens/mystatus_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:division/src/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../constants/firebase_instances.dart';
import 'home.dart';


class EditProfile extends ConsumerStatefulWidget {
  final types.User user;
  EditProfile({required this.user});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final _form = GlobalKey<FormState>();
  static CollectionReference userDb = FirebaseInstances.fireStore.collection('users');
  @override
  Widget build(BuildContext context) {
    // var username = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const Mystatus());
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                  ),
                ),
                const Center(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: CircleAvatar(
                    radius: 70.sp,
                    backgroundImage:AssetImage("assets/images/ok.png"),
                  ),
                ),
                Text("Email"),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: emailController,

                        decoration: InputDecoration(
                          labelText:
                              widget.user.metadata!['email'] ??
                                  'email',
                          prefixIcon: Icon(Icons.mail),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Text("username"),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: usernameController,

                        decoration: InputDecoration(
                          labelText:
                              widget.user.firstName??
                                  'username',
                          prefixIcon: Icon(Icons.mail),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();



                     if(emailController.text.isNotEmpty && usernameController.text.isNotEmpty ){
                       try{
                         await FirebaseAuth.instance.currentUser!.updateEmail(emailController.text).then((value) async{
                           await userDb.doc(widget.user.id).update({'metadata.email': emailController.text});
                         }).then((value) async {
                           await userDb.doc(widget.user.id).update({'firstName': usernameController.text});
                         }).then((value) => SnackShow.showSuccess(context, 'Profile Updated')).then((value) => Get.offAll(HomeScreen())).catchError((e){
                           SnackShow.showFailure(context, '$e');
                         });
                       } catch (error){
                         print(error);
                         SnackShow.showFailure(context, '$error');
                       }
                     }
                      else if(emailController.text.isNotEmpty){
                        try{
                          await FirebaseAuth.instance.currentUser!.updateEmail(emailController.text).then((value) async{
                            await userDb.doc(widget.user.id).update({'metadata.email': emailController.text});
                          }).then((value) => SnackShow.showSuccess(context, 'Profile Updated')).then((value) => Get.offAll(HomeScreen())).catchError((error){
                            print(error);
                            SnackShow.showFailure(context, 'failed email update');
                          });
                        } catch(e){
                          SnackShow.showFailure(context, '$e');
                          print(e);
                        }

                      }
                      else if(usernameController.text.isNotEmpty){
                        try{
                          await userDb.doc(widget.user.id).update({'firstName': usernameController.text})
                              .then((_) {
                            SnackShow.showSuccess(context, 'Profile Updated');
                          }).then((value) => Get.offAll(HomeScreen())).catchError((error) {
                            SnackShow.showFailure(context, '$error');
                            print('Error updating first name: $error');
                          });
                        } catch(e){
                          SnackShow.showFailure(context, '$e');
                          print(e);
                        }
                      }
                     else{
                       SnackShow.showFailure(context, 'Cannot leave the field empty');
                     }





                    },

                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 116.0, vertical: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        primary: Color.fromARGB(255, 192, 187, 187)),
                    child: const Text(
                      "Update ",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
