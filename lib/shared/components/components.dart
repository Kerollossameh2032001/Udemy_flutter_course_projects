import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';
import '../cubit/cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text("${model['time']}"),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['title']}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    model['date'],
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDate(status: 'done', id: model['id']);
                },
                icon: const Icon(Icons.check_circle_outline)),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDate(status: 'archive', id: model['id']);
                },
                icon: const Icon(Icons.archive_outlined))
          ],
        ),
      ),
      onDismissed: (DismissDirection direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget TaskBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(thickness: 1),
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100,
            ),
            Text(
              "No tasks yet , Please Add some tasks",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );

Widget buildArticleItem(article, context) {
  return InkWell(
    onTap: () => navigateTo(context, WebViewScreen(url: article['url'])),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage("${article['urlToImage']}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${article['title']}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${article['publishedAt']}",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    ),
  );
}

void navigateTo(context, widget) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (context) => widget));

Widget defaultTextFormField({
  required TextEditingController controller,
  String? title,
  InputBorder? border = const OutlineInputBorder(),
  InputBorder? errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 5)),
  Widget? prefixIcon,
  required TextInputType type,
  FormFieldValidator<String>? validator,
  Widget? suffixIcon,
  bool obscure = false,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: title,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 5)),
      prefixIcon: prefixIcon,
    ),
    obscureText: obscure,
    keyboardType: type,
    validator: validator,
  );
}

Widget defaultElevatedButton({
  required Widget child,
  required void Function()? onPressed,
  double? elevation,
  Size? size,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation),
        fixedSize: MaterialStateProperty.all(size)),
    child: child,
  );
}

enum ToastState { SUCCESS, ERROR, WARNING }

MaterialColor chooseToastColor(ToastState state){
  MaterialColor color;
  switch(state){
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast({
  required String text,
  required ToastState state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
