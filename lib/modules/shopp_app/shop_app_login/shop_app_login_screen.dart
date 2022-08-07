import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/shop_app/shop_layout.dart';
import 'package:todo_app/modules/shopp_app/register/shop_app_register_screen.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/cubit/cubit.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/cubit/states.dart';
import 'package:todo_app/shared/network/local/cachHelper.dart';
import '../../../shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CachHelper.savedData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                    if (value) {
                      navigateAndFinish(context, ShopLayout());
                    }
              });
            } else {
              showToast(
                  text: state.loginModel.message!, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
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
                        Text("LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black87)),
                        Text(
                          "Login now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30),
                        defaultTextFormField(
                            controller: emailController,
                            title: 'Email',
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'title must not be empty';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(Icons.email_outlined)),
                        SizedBox(height: 30),
                        defaultTextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is too short';
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          type: TextInputType.text,
                          title: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              icon: cubit.suffix),
                          obscure: cubit.isPassword,
                        ),
                        SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultElevatedButton(
                            child: Text(
                              "LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            elevation: 20.0,
                            size: const Size(350, 30),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don\'t have an Account ? "),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                child: const Text('Register'))
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
