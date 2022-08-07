import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/cubit.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key,}) : super(key: key);

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: TextFormField(
              onChanged: (value) =>
                  NewsCubit.get(context).getsearchData(value: value),
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: Icon(Icons.clear)),
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'time must not be empty';
                } else {
                  return null;
                }
              },
            ),
          ),
          body: ConditionalBuilder(
              condition: list.length > 0,
              builder: (context) =>
                  ListView.separated(
                    itemBuilder: (context, index) =>
                        buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) =>
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    itemCount: list.length,
                    physics: BouncingScrollPhysics(),
                  ),
              fallback: (context) =>Container(),
        ));
      },
    );
  }

}
