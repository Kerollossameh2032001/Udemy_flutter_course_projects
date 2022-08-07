import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/components/constant.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                defaultTextFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    prefixIcon: Icon(Icons.person),
                    title: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The Name must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email),
                    title: 'E-mail',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The Email must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    prefixIcon: Icon(Icons.phone),
                    title: 'Phone',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'The Phone must not be empty';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                defaultElevatedButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    ShopCubit.get(context).putUserData(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                  },
                  size: Size(300, 40),
                ),
                SizedBox(
                  height: 20,
                ),
                defaultElevatedButton(
                  child: Text('LOGOUT'),
                  onPressed: () {
                    sinOut(context);
                  },
                  size: Size(300, 40),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
