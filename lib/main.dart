import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/app_state.dart';
import 'package:inherited_notifier_sample/modules/login/login.dart';
import 'package:inherited_notifier_sample/shared/provider/provider.dart';

import 'modules/home/home.dart';

void main() {
  runApp(Provider(create: () => AppState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppState state = context.read<AppState>();
    return MaterialApp(
        title: 'Flutter Demo',
        home: state.logged ? const Home() : const Login());
  }
}
