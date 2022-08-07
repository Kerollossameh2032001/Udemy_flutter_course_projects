import 'package:flutter/material.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Center(
          child: Container(
        child: Text(
          'Search Screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      )),
    );
  }
}
