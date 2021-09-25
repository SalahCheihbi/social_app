class MessageModel {
  String? senderId;
  late String receiverId;
  late String text;
  late String dateTime;

  MessageModel({
    this.senderId,
    required this.receiverId,
    required this.text,
    required this.dateTime,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    text = json['text'];
    dateTime = json['dateTime'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
