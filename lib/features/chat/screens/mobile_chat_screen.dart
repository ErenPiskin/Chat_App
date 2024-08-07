import 'package:chat_app_staj/common/widgets/loader.dart';
import 'package:chat_app_staj/features/auth/controller/auth_controller.dart';
import 'package:chat_app_staj/features/chat/widgets/bottom_chat_field.dart';
import 'package:chat_app_staj/models/user_model.dart';
import 'package:chat_app_staj/features/chat/widgets/chat_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;

  const MobileChatScreen({super.key, required this.name, required this.uid});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StreamBuilder<UserModel>(
          stream: ref.read(authControllerProvider).userDataById(uid),
          builder: (context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Loader();
            }
            return Row(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(
                        snapshot.data!.profilePic,
                      ),
                      radius: 25,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text(snapshot.data!.isOnline ? "online" : "offline",
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal
                          ),),



                      ],
                    ),
                  ),

                ],
              );

          }
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){



          }, icon: const Icon(Icons.videocam_outlined)
          ),
          IconButton(onPressed: (){



          }, icon: const Icon(Icons.call)),IconButton(onPressed: (){



          }, icon: const Icon(Icons.more_vert)
          ),
        ],
      ),
      body:  Column(
        children: [
           Expanded(
              child: ChatList(recieverUserId: uid,)
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 10.0,left: 2,right: 2),
            child: BottomChatField(
              recieverUserId: uid,
            ),
          )
        ],
      ),
    );
  }
}
