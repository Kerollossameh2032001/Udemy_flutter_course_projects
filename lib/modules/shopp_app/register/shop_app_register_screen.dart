import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/shopp_app/register/cubit/cubit.dart';
import 'package:todo_app/modules/shopp_app/register/cubit/states.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/cubit/cubit.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/local/cachHelper.dart';

class ShopRegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates>(
        listener: (context , state){
          if(state is ShopRegisterErrorState){
            print(state.error);
          }
          if (state is ShopRegisterSucessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CachHelper.savedData(
                  key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
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
        builder: (context , state){
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
                        Text("Register",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black87)),
                        Text(
                          "Register now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30),
                        defaultTextFormField(
                            controller: nameController,
                            title: 'Name',
                            type: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(Icons.person)),
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
                                ShopRegisterCubit.get(context).changePasswordVisibility();
                              },
                              icon: ShopRegisterCubit.get(context).suffix),
                          obscure: ShopRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(height: 30),
                        defaultTextFormField(
                            controller: phoneController,
                            title: 'Phone',
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone must not be empty';
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Icon(Icons.phone)),
                        SizedBox(height: 30),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultElevatedButton(
                            child: Text(
                              "REGISTER",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            elevation: 20.0,
                            size: const Size(350, 30),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

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
