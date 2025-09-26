import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/model/recipeemodel.dart';

import '../viewmodel/cartvm.dart';

class RecipeDetailScreenFinal extends StatefulWidget {
  RecipeeModel recipeeModel;
  RecipeDetailScreenFinal({super.key, required this.recipeeModel});

  @override
  State<RecipeDetailScreenFinal> createState() =>
      _RecipeDetailScreenFinalState();
}

class _RecipeDetailScreenFinalState extends State<RecipeDetailScreenFinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width *0.6,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            onPressed: (){
              Provider.of<CartVm>(context, listen: false)
                  .addToCart(widget.recipeeModel);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(

                      "${widget.recipeeModel.name} added to cart",
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
            
            icon: Icon(
              Icons.add
            ),
            label: Center(child: Text("Add to cart"))

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.recipeeModel.image,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.recipeeModel.image),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: (){
                        Navigator.pop(context);
                      },

                ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: MediaQuery.of(context).size.height/2.2, // match image height
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                  ],
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipeeModel.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("${widget.recipeeModel.rating}"),
                        Text("/5"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.recipeeModel.reviewCount} Reviews",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.flash_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.recipeeModel.caloriesPerServing} Cal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.punch_clock,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.recipeeModel.prepTimeMinutes} prep time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.task,
                          size: 16,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.recipeeModel.difficulty} level",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.fastfood,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.recipeeModel.cuisine} cuisine",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Wrap(

                          spacing: 8,
                          runSpacing: 4,
                          children: widget.recipeeModel.ingredients.map<Widget>((ingredient) {
                            return Chip(
                              label: Text(

                                ingredient,
                                style: const TextStyle(
                                  backgroundColor: Colors.white,
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   // Text(widget.recipeeModel.instruction as String),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instruction",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5,),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.recipeeModel.instructions.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: Icon(Icons.play_circle,
                                color: Colors.green,),
                                title: Text(widget.recipeeModel.instructions[index]),
                              );
                            }),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
