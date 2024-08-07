import 'dart:io';

import 'package:chat_app_staj/common/enums/message_enum.dart';
import 'package:chat_app_staj/features/auth/controller/auth_controller.dart';
import 'package:chat_app_staj/features/chat/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat_contact.dart';
import '../../../models/message.dart';


final chatControllerProvider = Provider(
        (ref)  {
          final chatRepository = ref.watch(chatRepositoryProvider);
          return ChatController(
             chatRepository: chatRepository,
              ref: ref,
    );}
  );
class ChatController{
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatContact>> chatContact(){
    return chatRepository.getChatContact();
  }
  Stream<List<Message>> chatStream(String recieverUserId){
    return chatRepository.getChatStream(recieverUserId);
  }


  void sendTextMessage(BuildContext context, String text,String recieverUserId){
    ref.read(userDataAuthProvider).whenData(
            (value) => chatRepository.sendTextMessage(
                context: context,
                text: text,
                recieverUserId: recieverUserId,
                senderUser: value!
            )
    );
  }
  void sendFileMessage(
      BuildContext context,
      File file,
      String recieverUserId,
      MessageEnum messageEnum
      ){
    ref.read(userDataAuthProvider).whenData(
            (value) => chatRepository.sendFileMessage(
              context: context, 
              file: file,
              recieverUserId: recieverUserId,
              senderUserData: value!,
              messageEnum: messageEnum,
              ref: ref,
        )
    );
  }

}