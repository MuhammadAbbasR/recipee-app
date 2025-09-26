import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/view/recipe_detail_screen_final.dart';

import 'package:recipeapp/viewmodel/cartvm.dart';
import 'package:recipeapp/viewmodel/recipevm.dart';

import '../model/recipeemodel.dart';

import '../service/response/status.dart';
import '../widget/banner.dart';

class RecipeDummyListScreen extends StatefulWidget {
  const RecipeDummyListScreen({super.key});

  @override
  State<RecipeDummyListScreen> createState() => _RecipeDummyListScreenState();
}

class _RecipeDummyListScreenState extends State<RecipeDummyListScreen> {
  @override
  void initState() {

    super.initState();
    Provider.of<RecipeVm>(context,listen: false).loadFoodList();
  }

  String selectedCategory = "All";
  List<String> categories = [
    "All",
    "Lunch",
    "Dinner",
    "Snack",
    "Dessert",
    "Breakfast",
    "Side Dish",
    "Beverage",
    "Appetizer"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recipes")),
      body: Consumer<RecipeVm>(

        builder: (context, providervm,_) {
         switch(providervm.response.status){

           case Status.loading :
             return Center(child: CircularProgressIndicator());

           case Status.error:
             return Center(
               child: Text("Error ${providervm.response.message}"),
             );



           case Status.completed:
             final List<RecipeeModel> recipes = providervm.response.data as List<RecipeeModel>;
             final filteredRecipes = providervm.getRecipeeList == "All"
                 ? recipes
                 : recipes.where((RecipeeModel recipe) {

               return recipe.mealType.contains(providervm.getRecipeeList);
             }).toList();

             return   Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 MyBanner(),
                 Padding(
                     padding: EdgeInsets.symmetric(vertical: 15),
                 child: Text("Categories",
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,

                 ),
                 ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: DropdownButton<String>(
                     value: providervm.getRecipeeList,
                     isExpanded: true,
                     items: categories.map((String category) {
                       return DropdownMenuItem<String>(
                         value: category,
                         child: Text(category),
                       );
                     }).toList(),
                     onChanged: (String? newValue) {

                        if(newValue!=null){
                          providervm.setRecipeeList(newValue);
                        }

                     },
                   ),
                 ),


                 Expanded(
                   child: ListView.builder(
                     itemCount: filteredRecipes.length,
                     itemBuilder: (context, index) {
                       final recipe = filteredRecipes[index];
                       return Card(
                         margin: const EdgeInsets.all(8),
                         child: ListTile(
                           leading: Container(
                             width: 60,
                             height: 60,
                             color: Colors.grey[300],
                             child: recipe.image != null && recipe.image.isNotEmpty
                                 ? Image.network(recipe.image, fit: BoxFit.cover)
                                 : const Icon(Icons.image),
                           ),
                           title: Text(recipe.name),
                           subtitle: Text(

                             "Category: ${recipe.mealType.isNotEmpty ? recipe.mealType.join(", ") : "N/A"}",
                           ),
                           trailing: ElevatedButton(
                             onPressed: () {
                               Provider.of<CartVm>(context, listen: false)
                                   .addToCart(recipe);
                             },
                             child: const Text("Add"),
                           ),
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (_) =>
                                     RecipeDetailScreenFinal(recipeeModel: recipe),
                                // RecipeDetailScreen2(recipeeModel: recipe),
                               ),
                             );
                           },
                         ),
                       );
                     },
                   ),
                 ),
               ],
             );


           default:
             return Center(child: Text("No cases registered default statement executed "));
         }



        },
      ),
    );
  }
}
