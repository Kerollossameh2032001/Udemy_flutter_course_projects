import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/cubit.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';
import 'package:todo_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return ConditionalBuilder(
              condition: list.length > 0,
              builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    itemCount: list.length,
                    physics: BouncingScrollPhysics(),
                  ),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}
