import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/view/view_all_page.dart';
import 'package:recipeapp/widget/MyDrawer.dart';
import '../model/recipeemodel.dart';
import '../service/network/networkapi.dart';
import '../service/response/status.dart';
import '../viewmodel/cartvm.dart';
import '../viewmodel/recipevm.dart';


class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<RecipeVm>(context, listen: false).loadFoodList());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(

        appBar: AppBar(title: const Text("Recipes",
        style: TextStyle(
          color: Colors.white,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        drawer: MyDrawer(),
        body: Consumer<RecipeVm>(
          builder: (context, vm, _) {
            if (vm.response.status==Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.response.status == Status.error) {
              return Center(child: Text(vm.response.message.toString()));
            }
            if (vm.getRecipeeList.isEmpty) {
              return const Center(child: Text("No recipes found"));
            }

            final recipes = vm.response.data ?? [];

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green,
                    ),
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 30,
                          left: 15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Cook the best \nrecipes at home",
                                style: TextStyle(
                                  height: 1.1,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 33),
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Explore",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewAllPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  const TabBar(
                    isScrollable: true,
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Breakfast"),
                      Tab(text: "Lunch"),
                      Tab(text: "Dinner"),
                      Tab(text: "Snack"),
                      Tab(text: "Dessert"),
                      Tab(text: "Side Dish"),
                      Tab(text: "Beverage"),
                      Tab(text: "Appetizer"),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: TabBarView(
                      children: [
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Breakfast")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Lunch")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Dinner")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Snack")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Dessert")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Side Dish")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Beverage")).toList()),
                        _buildRecipeList(recipes.where((r) => r.mealType.contains("Appetizer")).toList()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  static Widget _buildRecipeList(List<RecipeeModel> recipes) {
    if (recipes.isEmpty) {
      return const Center(child: Text("No recipes in this category"));
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 8),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipee = recipes[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    recipee.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipee.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.flash_on,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text(
                            "${recipee.caloriesPerServing} Cal",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.punch_clock,
                              size: 16, color: Colors.blueGrey),
                          const SizedBox(width: 4),
                          Text(
                            "${recipee.prepTimeMinutes} min",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Provider.of<CartVm>(context, listen: false)
                                  .addToCart(recipee);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(

                                    "${recipee.name} added to cart",
                                    style: const TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  backgroundColor: Colors.greenAccent,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  duration: const Duration(seconds: 3), // auto-dismiss
                                ),
                              );
                            },
                            icon: const Icon(Icons.add_shopping_cart,
                                size: 16, color: Colors.white),
                            label: const Text(
                              "Add",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

