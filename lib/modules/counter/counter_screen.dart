import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/modules/counter/cubit/cubit.dart';
import 'package:project_one/modules/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  // const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is CounterMinusState) {
            print("Minus state ${state.counter}");
          }
          if (state is CounterPlusState) {
            print("Plus state ${state.counter}");
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              "Counter",
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).minus();
                  },
                  child: Text(
                    "Minus",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    CounterCubit.get(context).plus();
                  },
                  child: Text(
                    "Plus",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
