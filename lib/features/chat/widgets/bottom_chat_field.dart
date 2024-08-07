import 'dart:io';

import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/common/enums/message_enum.dart';
import 'package:chat_app_staj/common/utils/utils.dart';
import 'package:chat_app_staj/features/chat/controller/chat_controller.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  BottomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false ;
  final TextEditingController _messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  void sentTextMessage() async{
    if(isShowSendButton){
      ref.read(chatControllerProvider).sendTextMessage(
          context,
          _messageController.text.trim(),
          widget.recieverUserId);
      setState(() {
        _messageController.text = "";
      });

    }
  }

  void sendFileMassage(
      File file,
      MessageEnum messageEnum,
      ){
    ref.read(chatControllerProvider).sendFileMessage(context, file, widget.recieverUserId, messageEnum);

  }

  void selectImage()async{
    File? image = await pickImageFromGallery(context);
    if(image !=null){
      sendFileMassage(image,MessageEnum.image);

    }
  }

  void selectVideo()async{
    File? video = await pickVideoFromGallery(context);
    if(video !=null){
      sendFileMassage(video,MessageEnum.video);

    }
  }

  void hideEmojiContainer(){
    setState(() {
      isShowEmojiContainer = false;
    });
  }
  void showEmojiContainer(){
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeybordContainer(){
    if(isShowEmojiContainer){
      showKeyboard();
      hideEmojiContainer();
    }else{
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val){
                  if(val.isNotEmpty){
                    setState(() {
                      isShowSendButton = true;
                    });
                  }else{
                    setState(() {
                      isShowSendButton=false;
                    });
                  }
                },
                  decoration: InputDecoration(
                    hintText: "Type a message!",
                    filled: true,
                    fillColor: whiteColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child:  SizedBox(
                       width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.emoji_emotions_outlined,color: Colors.black54,),
                              onPressed: toggleEmojiKeybordContainer,
                             ),
                            IconButton(
                                icon: const Icon(Icons.gif_box_outlined,color: Colors.black54,),
                              onPressed: () {},),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width:130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(icon: const Icon(Icons.attach_file_outlined,color: Colors.black54),
                            onPressed: selectVideo,),
                          IconButton(icon: const Icon(Icons.camera_alt_outlined,color: Colors.black54),
                            onPressed: selectImage,
                          ),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
            ),
             Padding(
              padding: const EdgeInsets.only(right: 8.0,bottom: 2,left: 2),
              child:  GestureDetector(
                  onTap: sentTextMessage,
                  child: isShowSendButton ?  Image.asset("assets/send.png",) : const Icon(Icons.mic,size: 35,),
              ),


            )

          ],
        ),
        isShowEmojiContainer ? SizedBox(
          height: 310,
          child: EmojiPicker(
            onEmojiSelected: ((category, emoji) {
              setState(() {
                _messageController.text = _messageController.text+emoji.emoji;
              });
              if(!isShowSendButton){
                setState(() {
                  isShowSendButton = true;
                });
              }
            }),
          ),
        ): const SizedBox(),
      ],
    );
    }
}

