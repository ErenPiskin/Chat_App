import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/features/chat/widgets/display_text_image_gif.dart';
import 'package:flutter/material.dart';

import '../../../common/enums/message_enum.dart';


class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: whiteColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding:  type == MessageEnum.text ?
                const EdgeInsets.only(left: 15,right: 30,top: 5,bottom: 20): const EdgeInsets.only(left: 5,top: 5,right: 5,bottom: 25),
                child: DisplayTextImageGIF(message: message, type: type,myMessagesCard: false,)
                ),

              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}