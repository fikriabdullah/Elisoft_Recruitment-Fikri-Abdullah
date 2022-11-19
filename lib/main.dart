import 'package:elisoft/blocs/article/article_cubit.dart';
import 'package:elisoft/blocs/user/user_cubit.dart';
import 'package:elisoft/pages/dashboard.dart';
import 'package:elisoft/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login' : (context)=>MultiBlocProvider(
            providers: [
              BlocProvider<UserCubit>(
                  create: (context)=>UserCubit()),
              BlocProvider(
                  create: (context)=>ArticleCubit())
            ],
            child: const Login()),
        '/dashboard' : (context)=>MultiBlocProvider(
            providers: [
              BlocProvider<ArticleCubit>(
                  create: (context)=>ArticleCubit()
              ),
              BlocProvider<UserCubit>(
                  create: (context)=>UserCubit()),
            ],
            child: const Dashboard())
      },
    );
  }
}
