class PostModel {
  late String name;
  late String uId;
  late String text;
   String? image;
  String? postImage;
  late String dateTime;

  PostModel({
    required this.name,
    required this.uId,
    required this.text,
    required this.image,
    this.postImage,
    required this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    text = json['text'];
    image = json['image'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'text': text,
      'image': image,
      'postImage': postImage,
      'dateTime': dateTime,
    };
  }
}
