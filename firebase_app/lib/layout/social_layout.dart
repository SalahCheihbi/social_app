import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/modules/posts/post_screen.dart';

import 'package:firebase_app/shared/styles/icons_broken.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialPostBottomNavState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()));
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex],
                style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User), label: 'User'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settigns'),
            ],
          ),
        );
      },
    );
  }
}
