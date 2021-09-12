import 'package:firebase_app/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            margin: EdgeInsetsDirectional.all(8.0),
            elevation: 8.0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Image(
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                  image: NetworkImage(
                      'https://image.freepik.com/photos-gratuite/j-ai-peur-frayeur-portrait-homme-effraye-homme-affaires-debout-isole-fond-studio-rouge-mode-portrait-demi-longueur-male_155003-29132.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'communication with friends',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(context, index),
              separatorBuilder: (context, index) => SizedBox(
                    height: 5.0,
                  ),
              itemCount: 10)
        ],
      ),
    );
  }
}

Widget buildPostItem(context, index) => Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/photos-gratuite/j-ai-peur-frayeur-portrait-homme-effraye-homme-affaires-debout-isole-fond-studio-rouge-mode-portrait-demi-longueur-male_155003-29132.jpg'),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Salah Eddine Cheihbi',
                            style: TextStyle(
                                height: 1.4, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        'Junary 09 2022',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.6),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 14.0,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
            Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the \'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 25.0,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                            onPressed: () {},
                            child: Text(
                              '#flutterDev',
                              style: TextStyle(color: Colors.blue),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://image.freepik.com/photos-gratuite/j-ai-peur-frayeur-portrait-homme-effraye-homme-affaires-debout-isole-fond-studio-rouge-mode-portrait-demi-longueur-male_155003-29132.jpg'),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('120')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '120 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
