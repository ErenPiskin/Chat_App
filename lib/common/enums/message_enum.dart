enum MessageEnum{
  text("text"),
  image("image"),
  audio("audio"),
  video("video"),
  gif("gif");
 // 2.17 üstü dart sürümü olması gerek

  const MessageEnum(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case "audio":
        return MessageEnum.audio;
      case "image":
        return MessageEnum.image;
      case "text":
        return MessageEnum.text;
      case "gif":
        return MessageEnum.gif;
      case "video":
        return MessageEnum.video;
      default:
        return MessageEnum.text;
    }
  }
}