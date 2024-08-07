import 'package:chat_app_staj/common/enums/message_enum.dart';

class Message{

  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "recieverId": recieverId,
      "text": text,
      "type": type.type,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "messageId": messageId,
      "isSeen": isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] ?? 0),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }



  Message({required this.senderId, required this.recieverId, required this.text, required this.type, required this.timeSent, required this.messageId, required this.isSeen});

}