import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/viewmodel/auth_vm.dart';
import 'package:recipeapp/viewmodel/cartvm.dart';
import 'package:recipeapp/viewmodel/recipevm.dart';

import 'config/Route/routes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyAAVxxqWVxb_0yYNW9zwnHONjh71GUmGZg',
        appId: '1:222135710420:android:1c693bdcba5e2047e04141',
        messagingSenderId: '222135710420',
        projectId: 'practicefyp-c3931',
        storageBucket: 'practicefyp-c3931.firebasestorage.app'),
  );

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
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}