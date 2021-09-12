import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/layout/cubit/states.dart';
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
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  late UserModel model;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = UserModel.fromJson(value.data()!);
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
    if (index == 2)
      emit(SocialPostBottomNavState());
    else {
      currentIndex = index;

      emit(SocialChangeBottomNavState());
    }
  }

  final picker = ImagePicker();
  File? profileImage;
  File? coverImage;
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

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error) {});
    }).catchError((error) {});
  }
}
