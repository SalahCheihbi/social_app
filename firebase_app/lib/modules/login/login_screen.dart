import 'package:firebase_app/layout/social_layout.dart';
import 'package:firebase_app/modules/login/cubit/cubit.dart';
import 'package:firebase_app/modules/login/cubit/states.dart';
import 'package:firebase_app/modules/register/register_screen.dart';
import 'package:firebase_app/shared/components/components.dart';
import 'package:firebase_app/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginErrorStates) {
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is ShopLoginSuccessStates) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SocialLayout()),
                  (route) => false);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email is Empty';
                              }
                              return null;
                            },
                            label: 'Email',
                            prefix: Icons.email_outlined),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is Empty';
                              }
                              return null;
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            type: TextInputType.visiblePassword,
                            controller: passwordController,
                            label: 'Password',
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            prefix: Icons.lock_outline),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                state is! ShopLoginLoadingStates,
                            widgetBuilder: (context) => Container(
                                  height: 50,
                                  child: defaultButton(
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                      text: 'LOGIN'),
                                ),
                            fallbackBuilder: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text('register'.toUpperCase()),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
