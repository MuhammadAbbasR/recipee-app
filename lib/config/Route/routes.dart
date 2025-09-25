import 'package:flutter/material.dart';
import 'package:recipeapp/config/Route/routes_name.dart';
import 'package:recipeapp/model/recipeemodel.dart';
import 'package:recipeapp/view/check_out_failed.dart';
import 'package:recipeapp/view/check_out_sucess.dart';
import 'package:recipeapp/view/mainscreen.dart';
import 'package:recipeapp/view/recipe_detail_screen_final.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeRoute:
         return MaterialPageRoute(builder: (_)=> MainScreen() );

     case RoutesName.detailRoute:
        final args = settings.arguments as RecipeeModel;
       return MaterialPageRoute(
           builder: (_) => RecipeDetailScreenFinal( recipeeModel: args,));

      case RoutesName.failureCheckoutRoute:

        return MaterialPageRoute(builder: (_)=> CheckoutSuccessPage() );

      case RoutesName.successCheckoutRoute:
        return MaterialPageRoute(builder: (_)=> CheckoutFailedPage() );

    // 404 fallback
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("404 - Page Not Found")),
          ),
        );
    }
  }
}
