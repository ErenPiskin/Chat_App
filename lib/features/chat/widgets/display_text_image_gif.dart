import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/common/enums/message_enum.dart';
import 'package:chat_app_staj/features/chat/widgets/video_player.dart';
import 'package:flutter/material.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final bool myMessagesCard;
  const DisplayTextImageGIF({super.key, required this.message, required this.type, required this.myMessagesCard});

  @override
  Widget build(BuildContext context) {

    return type == MessageEnum.text? Text(
      message,
      style:  TextStyle(
        color: myMessagesCard == true ? whiteColor: blackColor,
        fontSize: 18,
      ),
    ) : type == MessageEnum.video ?
        VideoPlayer(
        videoUrl: message)
        : CachedNetworkImage(
        imageUrl: message);
  }
}
