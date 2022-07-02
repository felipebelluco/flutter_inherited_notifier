import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/app_state.dart';
import 'package:inherited_notifier_sample/modules/home/home.dart';
import 'package:inherited_notifier_sample/modules/home/home_state.dart';
import 'package:inherited_notifier_sample/shared/provider/provider.dart';

class Guest extends StatelessWidget {
  const Guest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest"),
      ),
      body: Center(
        child: TextField(
          onSubmitted: (value) {
            if (value.length <= 5) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("A name shouldn't be less than 5 characters")));
              return;
            }

            context.read<AppState>().changeName(value);
            Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Provider(
                        create: () => HomeState(), child: const Home())),
                (_) => false);
          },
          decoration: const InputDecoration(
              label: Text("Inform your name"), border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
