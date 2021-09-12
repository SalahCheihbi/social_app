class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool IsEmailVerified;
  late String image;
  late String cover;
  late String bio;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.IsEmailVerified,
    required this.image,
    required this.cover,
    required this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    IsEmailVerified = json['IsEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'cover': cover,
      'image': image,
      'IsEmailVerified': IsEmailVerified,
    };
  }
}
