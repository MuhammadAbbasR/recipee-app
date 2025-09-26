import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/viewmodel/auth_vm.dart';

import '../config/Route/routes_name.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: Colors.green.shade400,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 100),
          child: Icon(
            Icons.lock_open_rounded,
            size: 80,
            color: Colors.white,
          ),
          ),

          Padding(padding: EdgeInsets.all(25),

          child: Divider(
            color: Colors.white,
          ),
          ),

    Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Consumer<AuthVm>(
    builder: (context, authVm, child) {
    final isLoggedIn = authVm.user != null; // 👈 check login status

    return ListTile(
    onTap: () async {
    if (isLoggedIn) {
    // Logout flow
    await authVm.logout();



    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text("Logged out successfully"),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
    ),
    );
    } else {
    // Login flow
    Navigator.pushNamed(context, RoutesName.loginRoute);
    }
    },
    title: Text(
    isLoggedIn ? "LOGOUT" : "LOGIN",
    style: const TextStyle(color: Colors.white),
    ),
    leading: Icon(
    isLoggedIn ? Icons.logout : Icons.login,
    color: Colors.white,
    ),
    );
    },
    ),
    )


    ],
      ),



    );
  }
}
