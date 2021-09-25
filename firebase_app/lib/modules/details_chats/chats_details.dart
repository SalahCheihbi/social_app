// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/models/message_model.dart';
import 'package:firebase_app/models/register_user_model.dart';

import 'package:firebase_app/shared/styles/colors.dart';
import 'package:firebase_app/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetails extends StatelessWidget {
  late UserModel userModel;

  ChatDetails({required this.userModel});
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessage(
          receiverId: userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 75.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel.image}'),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(userModel.name)
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.length > 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 50,
                          child: Container(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var messages =
                                      SocialCubit.get(context).messages[index];
                                  if (SocialCubit.get(context).userModel.uId ==
                                      messages.senderId) {
                                    return buildMyMessage(messages);
                                  }
                                  return buildMessage(messages);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 15.0,
                                    ),
                                itemCount:
                                    SocialCubit.get(context).messages.length),
                          ),
                        ),
                        Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextField(
                                    controller: messageController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ...',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                        receiverId: userModel.uId);
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ));
          },
        );
      },
    );
  }
}

Widget buildMessage(MessageModel messages) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
              )),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Text(
            '${messages.text}',
          )),
    );

Widget buildMyMessage(MessageModel messages) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.5),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
              )),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Text(
            '${messages.text}',
          )),
    );
