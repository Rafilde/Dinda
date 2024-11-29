import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<YourBlocA>(
          create: (context) => YourBlocA(),
        ),
        BlocProvider<YourBlocB>(
          create: (context) => YourBlocB(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('MultiBlocProvider Example'),
          ),
          body: const Center(
            child: Text('Hello, Flutter!'),
          ),
        ),
      ),
    );
  }
}