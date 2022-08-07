import 'package:flutter/material.dart';
import 'boarding_model.dart';

Widget buildBoardingItem(BoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image(
        image: AssetImage(model.image),
      ),
      SizedBox(
        height: 40,
      ),
      Text(
        model.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        model.body,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  );
}