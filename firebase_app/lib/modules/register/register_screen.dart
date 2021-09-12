import 'package:firebase_app/layout/social_layout.dart';
import 'package:firebase_app/modules/register/cubit/cubit.dart';
import 'package:firebase_app/modules/register/cubit/states.dart';
import 'package:firebase_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var nameController = TextEditingController();

    var emailController = TextEditingController();

    var passwordController = TextEditingController();

    var phoneController = TextEditingController();
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccesStates) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SocialLayout()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFromField(
                            controller: nameController,
                            label: 'Name',
                            type: TextInputType.name,
                            prefix: Icons.person,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Name is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: emailController,
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Email is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: passwordController,
                            isPassword:
                                SocialRegisterCubit.get(context).isPassword,
                            label: 'Password',
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibilty();
                            },
                            type: TextInputType.visiblePassword,
                            prefix: Icons.lock_outlined,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is Empty';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFromField(
                            controller: phoneController,
                            label: 'Phone',
                            type: TextInputType.phone,
                            prefix: Icons.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Phone is Emppty';
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Register'.toUpperCase()),
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
