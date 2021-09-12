import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/shared/components/components.dart';
import 'package:firebase_app/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profil', action: [
            defaultTextButton(
              text: 'Update',
              function: () {
                SocialCubit.get(context).uploadProfileImage();
              },
            ),
            SizedBox(
              width: 15.0,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  '${userModel.cover}')
                                              : FileImage(coverImage)
                                                  as ImageProvider,
                                          fit: BoxFit.fill))),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 16.0,
                                  child: IconButton(
                                    icon: Icon(
                                      IconBroken.Camera,
                                      size: 18.0,
                                    ),
                                    onPressed: () {
                                      SocialCubit.get(context).getCover();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 65.0,
                              child: CircleAvatar(
                                  radius: 61.0,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}')
                                      : FileImage(profileImage)
                                          as ImageProvider),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 5.0),
                              child: CircleAvatar(
                                radius: 16.0,
                                child: IconButton(
                                  icon: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                  onPressed: () {
                                    SocialCubit.get(context).getImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFromField(
                      label: 'Name',
                      type: TextInputType.name,
                      prefix: IconBroken.User,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      controller: nameController),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFromField(
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      controller: bioController)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
