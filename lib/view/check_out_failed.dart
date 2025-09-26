import 'package:flutter/material.dart';

import '../config/Route/routes_name.dart';

class CheckoutFailedPage extends StatelessWidget {
  const CheckoutFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 80),
            const SizedBox(height: 20),
            const Text("You are not logged in!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.loginRoute);
              },
              child: const Text("Go to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
