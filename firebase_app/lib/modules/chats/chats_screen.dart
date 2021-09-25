import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/cubit/states.dart';
import 'package:firebase_app/models/register_user_model.dart';
import 'package:firebase_app/modules/details_chats/chats_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                SocialCubit.get(context).users.length > 0,
            widgetBuilder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => defaultItemChat(
                      SocialCubit.get(context).users[index], context),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: SocialCubit.get(context).users.length,
                ),
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget defaultItemChat(UserModel model, context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatDetails(
                    userModel: model,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                '${model.name}',
                style: TextStyle(height: 1.4, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
