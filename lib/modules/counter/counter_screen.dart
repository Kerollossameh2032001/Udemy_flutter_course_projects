import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:todo_app/modules/counter/cubit/cubit.dart';
import 'package:todo_app/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit , CounterStates>(
        listener: (context, states) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text("Counter Screen")),
          body: Center(
            child: DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => CounterCubit.get(context).plus(),
                      child: const Text(
                        "PLUS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                  Text("${CounterCubit.get(context).counter}"),
                  TextButton(
                      onPressed: () => CounterCubit.get(context).minus(),
                      child: const Text(
                        "MINUS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
