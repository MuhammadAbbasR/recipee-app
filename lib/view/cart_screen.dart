import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/viewmodel/cartvm.dart';

import '../viewmodel/auth_vm.dart';
import 'check_out_failed.dart';
import 'check_out_sucess.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providervm = Provider.of<CartVm>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        title: const Text("My Cart",
        style: TextStyle(
          color: Colors.white
        ),
        ),
        centerTitle: true,
        elevation: 2,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart,
                color: Colors.white,),
              ),
              if (providervm.recipeeList.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      providervm.recipeeList.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: providervm.recipeeList.isEmpty
          ? const Center(
        child: Text(
          "🛒 Your cart is empty",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: providervm.recipeeList.length,
        itemBuilder: (context, index) {
          final recipee = providervm.recipeeList[index];
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
                  // Product image
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

                  // Product details
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
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.punch_clock,
                                size: 16, color: Colors.blueGrey),
                            const SizedBox(width: 4),
                            Text(
                              "${recipee.prepTimeMinutes} min",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),


                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  providervm.decreaseServings(recipee);
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text(
                                recipee.servings.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  providervm.increaseServings(recipee);
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Delete button
                  IconButton(
                    onPressed: () {
                      providervm.removeFromCart(recipee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text("${recipee.name} removed from cart"),
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Floating elongated Checkout button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: providervm.recipeeList.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: () {
          final isLoggedIn = Provider.of<AuthVm>(context, listen: false).isLoggedIn;

          if (isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutSuccessPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutFailedPage()),
            );
          }
        },
        icon: const Icon(Icons.payment,
        color: Colors.white
          ,),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Proceed to Checkout",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold,
              color: Colors.white

            ),
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
