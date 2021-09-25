import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/register_user_model.dart';
import 'package:firebase_app/modules/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialStates());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          email: value.user!.email!,
          phone: phone,
          uId: value.user!.uid,
          name: name);
    }).catchError((error) {
      emit(SocialRegisterErrorStates(error));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'bio...',
      cover:
          'https://image.freepik.com/photos-gratuite/medecin-sans-visage-fait-injection-vaccin-covid-19-patient-age-porte-gants-protection-caoutchouc_273609-52652.jpg',
      image:
          'https://image.freepik.com/photos-gratuite/medecin-sans-visage-fait-injection-vaccin-covid-19-patient-age-porte-gants-protection-caoutchouc_273609-52652.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccesStates());
    }).catchError((error) {
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changePasswordVisibilty() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialChangePasswordVisibilityStates());
  }
}
