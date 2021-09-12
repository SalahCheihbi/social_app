import 'package:firebase_app/layout/cubit/cubit.dart';
import 'package:firebase_app/layout/social_layout.dart';
import 'package:firebase_app/modules/login/login_screen.dart';
import 'package:firebase_app/shared/bloc_obsever.dart';
import 'package:firebase_app/shared/components/constants.dart';
import 'package:firebase_app/shared/network/local/cache_helper.dart';
import 'package:firebase_app/shared/styles/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget? widget;

  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = ShopLoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({Key? key, this.startWidget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => SocialCubit()..getUserData())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter ',
          theme: lightTheme,
          home: startWidget,
        ));
  }
}
