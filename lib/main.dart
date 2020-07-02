import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/login_bloc/bloc/login_bloc.dart';
import 'package:karo_app/ui/homepage.dart';
import 'package:karo_app/ui/welcomePages/loginPage.dart';
import 'package:karo_app/ui/welcomePages/login_page.dart';
import 'package:karo_app/ui/welcomePages/welcome_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ], child: LoginPage()),
    );
  }
}
