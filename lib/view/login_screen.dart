import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/config/Route/routes_name.dart';
import 'package:recipeapp/widget/MyButton.dart';
import 'package:recipeapp/widget/textfield.dart';

import '../viewmodel/auth_vm.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthVm(),
      child: Consumer<AuthVm>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_open_rounded,
                      size: 100,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Recipe App",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 25),
                    Textfield(
                      controller: emailController,
                      hinttext: 'Email',
                      obscuretext: false,
                    ),
                    const SizedBox(height: 25),
                    Textfield(
                      controller: passwordController,
                      hinttext: 'Password',
                      obscuretext: true,
                    ),
                    const SizedBox(height: 25),
                    vm.status == AuthStatus.loading
                        ? const CircularProgressIndicator()
                        : MyButton(
                      onTap: () async {
                        await vm.login(emailController.text,
                            passwordController.text);

                        if (vm.status == AuthStatus.success) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "sucess",
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

                           Navigator.pushReplacementNamed(context, RoutesName.homeRoute);
                        } else if (vm.status == AuthStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                vm.errorMessage,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.redAccent,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 3), // auto-dismiss
                            ),
                          );
                        }
                      },
                      text: "Sign in",
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a member?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            // Navigate to register screen
                          //  Navigator.push(context, RoutesName.signupRoute);

                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
