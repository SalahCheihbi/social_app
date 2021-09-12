import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/modules/edit_profile/edit_profil_screen.dart';

import 'package:firebase_app/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Padding(
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
                      child: Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage('${userModel.cover}'),
                                  fit: BoxFit.fill))),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 65.0,
                      child: CircleAvatar(
                        radius: 61.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${userModel.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {},
                          child: Text('Add Photos'),
                        )),
                        SizedBox(
                          width: 5.0,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()));
                            },
                            child: Icon(IconBroken.Edit))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
