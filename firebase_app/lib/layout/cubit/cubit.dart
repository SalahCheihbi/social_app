import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/models/message_model.dart';
import 'package:firebase_app/models/new_post_model.dart';
import 'package:firebase_app/models/register_user_model.dart';
import 'package:firebase_app/modules/chats/chats_screen.dart';
import 'package:firebase_app/modules/feeds/feeds_screen.dart';
import 'package:firebase_app/modules/posts/post_screen.dart';
import 'package:firebase_app/modules/settings/settings_screen.dart';
import 'package:firebase_app/modules/users/users_screen.dart';
import 'package:firebase_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  late UserModel userModel;

  Future getUserData() async {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottom(int index) {
    if (index == 1) getUser();
    if (index == 2)
      emit(SocialPostBottomNavState());
    else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  final picker = ImagePicker();
  File? profileImage;

  Future<void> getImage() async {
    XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      profileImage = File(pickerFile.path);
      print(pickerFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCover() async {
    XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      coverImage = File(pickerFile.path);
      print(pickerFile.path);
      emit(SocialProfileCoverPickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        userUpdate(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userUpdate(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void userUpdate({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: userModel.email,
      bio: bio,
      cover: cover ?? userModel.cover,
      image: image ?? userModel.image,
      uId: userModel.uId,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required text,
    String? postImage,
  }) {
    late PostModel model = PostModel(
      name: userModel.name,
      uId: userModel.uId,
      image: userModel.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('post')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  File? postImage;
  Future<void> getPost() async {
    XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      postImage = File(pickerFile.path);
      print(pickerFile.path);
      emit(SocialUploadPostImageSuccessState());
    } else {
      print('No image selected');
      emit(SocialUploadPostErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialUploadPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialUploadPostErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void getLike(String? postsId) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(postsId)
        .collection('likes')
        .doc(userModel.uId)
        .set({'like': true}).then((value) {
      emit(SocialGetLikePostSuccessState());
    }).catchError((error) {
      emit(SocialGetLikePostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getUser() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel.uId)
            users.add(UserModel.fromJson(element.data()));
          emit(SocialGetAllUserSuccessState());
        });
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String dateTime,
    required String text,
    required String receiverId,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      senderId: userModel.uId,
    );
// Send chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
//receive Chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccesState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance

        .collection('users')
        .doc(userModel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
    });

    emit(SocialGetMessageSuccessState());
  }
}

