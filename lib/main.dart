import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:recipeapp/view/login_screen.dart';
import 'package:recipeapp/view/mainscreen.dart';
import 'package:recipeapp/viewmodel/auth_vm.dart';
import 'package:recipeapp/viewmodel/cartvm.dart';
import 'package:recipeapp/viewmodel/recipevm.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeVm()),
        ChangeNotifierProvider(create: (_) => CartVm()),
        ChangeNotifierProvider(create: (_)=>AuthVm())
      ],
      child: const RecipeApp(),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home:  MainScreen(),
    );
  }
}
