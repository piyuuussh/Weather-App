import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherassign/Data/Provider.dart';
import 'package:weatherassign/UI/Details.dart';
import 'package:weatherassign/UI/Home.dart';
import 'package:weatherassign/bloc/weather_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CityProvider(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
